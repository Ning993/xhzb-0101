package com.xhzb.nursing.service.impl;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

import cn.hutool.json.JSONUtil;
import com.xhzb.common.exception.base.BaseException;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.oss.client.OSSAliyunFileStorageService;
import org.springframework.ai.document.Document;
import org.springframework.ai.reader.ExtractedTextFormatter;
import org.springframework.ai.reader.pdf.PagePdfDocumentReader;
import org.springframework.ai.reader.pdf.config.PdfDocumentReaderConfig;
import org.springframework.ai.transformer.splitter.TextSplitter;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.mapper.KnowledgeBaseMapper;
import com.xhzb.nursing.domain.KnowledgeBase;
import com.xhzb.nursing.service.IKnowledgeBaseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 知识库主Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-03-30
 */
@Service
public class KnowledgeBaseServiceImpl extends ServiceImpl<KnowledgeBaseMapper, KnowledgeBase> implements IKnowledgeBaseService
{
    @Autowired
    private KnowledgeBaseMapper knowledgeBaseMapper;

    /**
     * 查询知识库主
     * 
     * @param id 知识库主主键
     * @return 知识库主
     */
    @Override
    public KnowledgeBase selectKnowledgeBaseById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询知识库主列表
     * 
     * @param knowledgeBase 知识库主
     * @return 知识库主
     */
    @Override
    public List<KnowledgeBase> selectKnowledgeBaseList(KnowledgeBase knowledgeBase)
    {
        return knowledgeBaseMapper.selectKnowledgeBaseList(knowledgeBase);
    }

    @Autowired
    private OSSAliyunFileStorageService fileStorageService;

    @Autowired
    private TextSplitter textSplitter;

    @Autowired
    private VectorStore vectorStore;

    /**
     * 新增知识库主
     * @param knowledgeBase 知识库主
     * @return 结果
     */
    @Override
    public int insertKnowledgeBase(KnowledgeBase knowledgeBase)
    {
        // 下载文档
        InputStream inputStream = fileStorageService.download(knowledgeBase.getDocumentUrl());
        if(inputStream == null){
            throw new BaseException("文件不存在");
        }

        // 读文档  pdf  按页读取
        InputStreamResource resource = new InputStreamResource(inputStream);
        PagePdfDocumentReader pdfReader = new PagePdfDocumentReader(resource,
                PdfDocumentReaderConfig.builder()
                        .withPageExtractedTextFormatter(ExtractedTextFormatter.builder()
                                .build())
                        .withPagesPerDocument(1)  //每次读几页  默认是1
                        .build());
        //获取文档
        List<Document> documentList = pdfReader.read();

        //拆分文档
        List<Document> docments = textSplitter.split(documentList);
        //获取文档的id,方便后期删除
        List<String> ids = docments.stream().map(Document::getId).toList();

        // 存储文档
        int batchSize = 10;
        for (int i = 0; i < docments.size(); i+= batchSize) {
            //获取批次数据
            List<Document> batch = docments.subList(i, Math.min(i + batchSize, docments.size()));
            vectorStore.add(batch);
            System.out.println("已添加批次: " + (i / batchSize + 1) + ", 数量: " + batch.size());
        }

        // 存储数据库
        knowledgeBase.setCreateTime(DateUtils.getNowDate());
        knowledgeBase.setRemark(JSONUtil.toJsonStr(ids));
        return knowledgeBaseMapper.insertKnowledgeBase(knowledgeBase);
    }

    /**
     * 修改知识库主
     * 
     * @param knowledgeBase 知识库主
     * @return 结果
     */
    @Override
    public int updateKnowledgeBase(KnowledgeBase knowledgeBase)
    {
        return updateById(knowledgeBase)? 1 : 0;
    }

    /**
     * 批量删除知识库主
     * 
     * @param ids 需要删除的知识库主主键
     * @return 结果
     */
    @Override
    public int deleteKnowledgeBaseByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids))? 1 : 0;
    }

    /**
     * 删除知识库主信息
     * 
     * @param id 知识库主主键
     * @return 结果
     */
    @Override
    public int deleteKnowledgeBaseById(Long id)
    {
        //查数据
        KnowledgeBase knowledgeBase = selectKnowledgeBaseById(id);
        if(null == knowledgeBase){
            throw new BaseException("知识库不存在");
        }
        // 删除向量中的数据
        String idsStr = knowledgeBase.getRemark();
        List<String> ids = JSONUtil.toList(idsStr, String.class);
        vectorStore.delete(ids);
        //OSS中的数据 也要删除
        fileStorageService.delete(knowledgeBase.getDocumentUrl());
        // 删除mysql的数据
        return knowledgeBaseMapper.deleteKnowledgeBaseById(id);
    }
}
