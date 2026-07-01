package com.xhzb.nursing.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xhzb.nursing.domain.Elder;
import com.xhzb.nursing.domain.NursingTask;

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


}
