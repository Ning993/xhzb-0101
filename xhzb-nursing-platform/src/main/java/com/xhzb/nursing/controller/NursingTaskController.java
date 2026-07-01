package com.xhzb.nursing.controller;

import com.xhzb.common.core.controller.BaseController;
import com.xhzb.nursing.service.INursingTaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 护理任务Controller
 *
 * @author ruoyi
 * @date 2024-09-27
 */
@RestController
@RequestMapping("/nursing/nursingTask")
public class NursingTaskController extends BaseController
{
    @Autowired
    private INursingTaskService nursingTaskService;


}
