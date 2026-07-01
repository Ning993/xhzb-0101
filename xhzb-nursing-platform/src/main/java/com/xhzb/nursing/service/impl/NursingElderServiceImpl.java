package com.xhzb.nursing.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xhzb.nursing.domain.NursingElder;
import com.xhzb.nursing.domain.dto.NursingElderDto;
import com.xhzb.nursing.mapper.NursingElderMapper;
import com.xhzb.nursing.service.INursingElderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 护理员老人关联Service业务层处理
 *
 * @author ruoyi
 * @date 2024-05-28
 */
@Service
public class NursingElderServiceImpl extends ServiceImpl<NursingElderMapper, NursingElder> implements INursingElderService {

    @Autowired
    private NursingElderMapper nursingElderMapper;

    /**
     * 查询护理员老人关联
     *
     * @param id 护理员老人关联主键
     * @return 护理员老人关联
     */
    @Override
    public NursingElder selectNursingElderById(Long id) {
        return getById(id);
    }

    /**
     * 查询护理员老人关联列表
     *
     * @param nursingElder 护理员老人关联
     * @return 护理员老人关联
     */
    @Override
    public List<NursingElder> selectNursingElderList(NursingElder nursingElder) {
        return nursingElderMapper.selectNursingElderList(nursingElder);
    }

    /**
     * 新增护理员老人关联
     *
     * @param nursingElder 护理员老人关联
     * @return 结果
     */
    @Override
    public int insertNursingElder(NursingElder nursingElder) {
        return save(nursingElder) ? 1 : 0;
    }

    /**
     * 修改护理员老人关联
     *
     * @param nursingElder 护理员老人关联
     * @return 结果
     */
    @Override
    public int updateNursingElder(NursingElder nursingElder) {
        return updateById(nursingElder) ? 1 : 0;
    }

    /**
     * 批量删除护理员老人关联
     *
     * @param ids 需要删除的护理员老人关联主键
     * @return 结果
     */
    @Override
    public int deleteNursingElderByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) ? 1 : 0;
    }

    /**
     * 删除护理员老人关联信息
     *
     * @param id 护理员老人关联主键
     * @return 结果
     */
    @Override
    public int deleteNursingElderById(Long id) {
        return removeById(id) ? 1 : 0;
    }
}
