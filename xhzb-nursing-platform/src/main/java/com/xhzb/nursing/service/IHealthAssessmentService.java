package com.xhzb.nursing.service;

import java.util.List;
import java.util.Map;

import com.xhzb.nursing.domain.HealthAssessment;
import com.baomidou.mybatisplus.extension.service.IService;
import com.xhzb.nursing.domain.HealthAssessmentDataCollection;
import com.xhzb.nursing.domain.dto.health.ElderAssessmentDto;

/**
 * 健康评估记录Service接口
 * 
 * @author ruoyi
 * @date 2026-04-01
 */
public interface IHealthAssessmentService extends IService<HealthAssessment>
{
    /**
     * 查询健康评估记录
     * 
     * @param id 健康评估记录主键
     * @return 健康评估记录
     */
    public HealthAssessmentDataCollection selectHealthAssessmentById(Long id);

    /**
     * 查询健康评估记录列表
     * 
     * @param healthAssessment 健康评估记录
     * @return 健康评估记录集合
     */
    public List<HealthAssessment> selectHealthAssessmentList(HealthAssessment healthAssessment);

    /**
     * 新增健康评估记录
     * 
     * @param dto 健康评估记录
     * @return 结果
     */
    public Long insertHealthAssessment(ElderAssessmentDto dto);

    /**
     * 修改健康评估记录
     * 
     * @param dto 健康评估记录
     * @return 结果
     */
    public Long updateHealthAssessment(ElderAssessmentDto dto);

    /**
     * 批量删除健康评估记录
     * 
     * @param ids 需要删除的健康评估记录主键集合
     * @return 结果
     */
    public int deleteHealthAssessmentByIds(Long[] ids);

    /**
     * 删除健康评估记录信息
     * 
     * @param id 健康评估记录主键
     * @return 结果
     */
    public int deleteHealthAssessmentById(Long id);

    /**
     * 健康评估数据
     * @param dto
     * @return
     */
    Long assessmentData(ElderAssessmentDto dto);

    /**
     * 取消健康评估
     * @param id
     * @return
     */
    int cancel(Long id);

    /**
     * 查询老人详情
     * @param id
     * @return
     */
    Map<String, Object> getElderInfoById(Long id);
}
