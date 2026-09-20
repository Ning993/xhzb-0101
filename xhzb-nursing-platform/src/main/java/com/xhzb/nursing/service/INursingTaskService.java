package com.xhzb.nursing.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xhzb.nursing.domain.Elder;
import com.xhzb.nursing.domain.NursingTask;

import java.util.List;

/**
 * 护理任务Service接口
 *
 * @author ruoyi
 * @date 2024-09-27
 */
public interface INursingTaskService extends IService<NursingTask>
{

    /**
     * 生成护理任务
     * @param elder
     */
    void createMonthTask(Elder elder);

    /**
     * 查询护理任务列表
     *
     * @param nursingTask 护理任务查询条件
     * @return 护理任务集合
     */
    List<NursingTask> selectNursingTaskList(NursingTask nursingTask);

    /**
     * 查询护理任务详情
     *
     * @param id 护理任务主键
     * @return 护理任务
     */
    NursingTask selectNursingTaskById(Long id);

    /**
     * 取消护理任务
     *
     * @param taskId 任务ID
     * @param reason 取消原因
     */
    void cancelTask(Long taskId, String reason);

    /**
     * 执行护理任务
     *
     * @param taskId 任务ID
     * @param estimatedServerTime 预计服务时间
     * @param taskImage 执行图片
     * @param mark 执行记录
     */
    void executeTask(Long taskId, String estimatedServerTime, String taskImage, String mark);

    /**
     * 修改护理任务预计服务时间
     *
     * @param taskId 任务ID
     * @param estimatedServerTime 新的预计服务时间
     */
    void updateTaskTime(Long taskId, String estimatedServerTime);

}
