package com.xhzb.test;

import org.junit.jupiter.api.Test;
import org.springframework.ai.document.Document;
import org.springframework.ai.rag.Query;
import org.springframework.ai.rag.retrieval.search.DocumentRetriever;
import org.springframework.ai.rag.retrieval.search.VectorStoreDocumentRetriever;
import org.springframework.ai.reader.ExtractedTextFormatter;
import org.springframework.ai.reader.TextReader;
import org.springframework.ai.reader.pdf.PagePdfDocumentReader;
import org.springframework.ai.reader.pdf.ParagraphPdfDocumentReader;
import org.springframework.ai.reader.pdf.config.PdfDocumentReaderConfig;
import org.springframework.ai.transformer.splitter.TokenTextSplitter;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.ai.vectorstore.filter.FilterExpressionBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.InputStreamResource;

import java.io.DataOutput;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.List;

@SpringBootTest
public class ETLTest {


    @Test
    public void testText() throws FileNotFoundException {
        //读文件
//        InputStreamResource resource = new InputStreamResource(new FileInputStream("D:\\2026\\AI01\\散文《春韵无边》.txt"));
        //加载文件  txt文件
        TextReader textReader = new TextReader("https://movie.douban.com/review/17524460/");
        // 给文档添加元数据
//        textReader.getCustomMetadata().put("filename", "散文《春韵无边》.txt");
        //读取文档
        List<Document> documentList = textReader.read();
        System.out.println(documentList);

    }

    @Test
    public void testPDFByPage() throws FileNotFoundException {
        InputStreamResource resource = new InputStreamResource(new FileInputStream("D:\\2026\\AI01\\护理员工工作手册.pdf"));
        PagePdfDocumentReader pdfReader = new PagePdfDocumentReader(resource,
                PdfDocumentReaderConfig.builder()
                        .withPageTopMargin(0)
                        .withPageExtractedTextFormatter(ExtractedTextFormatter.builder()
                                .withNumberOfTopTextLinesToDelete(0)
                                .build())
                        .withPagesPerDocument(1)  //每次读几页  默认是1
                        .build());
        //获取文档
        List<Document> documentList = pdfReader.read();
        System.out.println("读取到的文档，总页码："+documentList.size());
        System.out.println(documentList);
    }


    @Test
    public void testPDFByParaGraph() throws FileNotFoundException {
        InputStreamResource resource = new InputStreamResource(new FileInputStream("D:\\2026\\AI01\\护理员工工作手册.pdf"));
        ParagraphPdfDocumentReader pdfReader = new ParagraphPdfDocumentReader(resource,
                PdfDocumentReaderConfig.builder()
                        .withPageTopMargin(0)
                        .withPageExtractedTextFormatter(ExtractedTextFormatter.builder()
                                .withNumberOfTopTextLinesToDelete(0)
                                .build())
                        .withPagesPerDocument(1)
                        .build());
        //获取文档
        List<Document> documentList = pdfReader.read();
        System.out.println("读取到的文档，总段数："+documentList.size());
        System.out.println(documentList);
    }

    @Autowired
    private VectorStore vectorStore;


    @Test
    public void testSplitter() throws FileNotFoundException {
        InputStreamResource resource = new InputStreamResource(new FileInputStream("D:\\2026\\AI01\\护理员工工作手册.pdf"));
        PagePdfDocumentReader pdfReader = new PagePdfDocumentReader(resource,
                PdfDocumentReaderConfig.builder()
                        .withPageTopMargin(0)
                        .withPageExtractedTextFormatter(ExtractedTextFormatter.builder()
                                .withNumberOfTopTextLinesToDelete(0)
                                .build())
                        .withPagesPerDocument(1)  //每次读几页  默认是1
                        .build());
        //获取文档
        List<Document> documentList = pdfReader.read();
        System.out.println("读取到的文档，总页码："+documentList.size());
        //切割文档
        TokenTextSplitter tokenTextSplitter = new TokenTextSplitter();
        List<Document> documentList1 = tokenTextSplitter.split(documentList);
        System.out.println(documentList1);
        //存储到向量数据库中
        int batchSize = 10;
        for (int i = 0; i < documentList1.size(); i+= batchSize) {
            //获取批次数据
            List<Document> batch = documentList1.subList(i, Math.min(i + batchSize, documentList1.size()));
            vectorStore.add(batch);
            System.out.println("已添加批次: " + (i / batchSize + 1) + ", 数量: " + batch.size());
        }
    }

    @Test
    public void testSearch(){
        DocumentRetriever retriever = VectorStoreDocumentRetriever.builder()
                .vectorStore(vectorStore)
                .similarityThreshold(0.81)  //分值  相似度分值
                .topK(5)  //相似度最高的5个文档
                .build();
        List<Document> documents = retriever.retrieve(new Query("护理服务宗旨与核心价值"));
        System.out.println("检索到的文档数量：" + documents.size());
        System.out.println(documents);
    }
}
