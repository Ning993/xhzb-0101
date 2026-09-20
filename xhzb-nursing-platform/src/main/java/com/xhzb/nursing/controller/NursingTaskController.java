package com.xhzb.nursing.controller;

import java.util.List;
import java.util.Map;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.xhzb.common.annotation.Log;
import com.xhzb.common.core.controller.BaseController;
import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.common.enums.BusinessType;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.xhzb.nursing.domain.NursingTask;
import com.xhzb.nursing.service.INursingTaskService;
import com.xhzb.common.core.page.TableDataInfo;

/**
 * 护理任务Controller
 *
 * @author ruoyi
 * @date 2024-09-27
 */
@RestController
@RequestMapping("/nursing/nursingTask")
@Tag(name = "护理任务相关接口")
public class NursingTaskController extends BaseController
{
    @Autowired
    private INursingTaskService nursingTaskService;

    /**
     * 查询护理任务列表
     */
    @PreAuthorize("@ss.hasPermi('nursing:nursingTask:list')")
    @GetMapping("/list")
    @Operation(summary = "查询护理任务列表")
    public TableDataInfo list(NursingTask nursingTask)
    {
        startPage();
        List<NursingTask> list = nursingTaskService.selectNursingTaskList(nursingTask);
        return getDataTable(list);
    }

    /**
     * 获取护理任务详细信息
     */
    @PreAuthorize("@ss.hasPermi('nursing:nursingTask:query')")
    @GetMapping(value = "/{id}")
    @Operation(summary = "获取护理任务详细信息")
    public AjaxResult getInfo(@Schema(name = "护理任务ID", requiredMode = Schema.RequiredMode.REQUIRED)
            @PathVariable("id") Long id)
    {
        return success(nursingTaskService.selectNursingTaskById(id));
    }

    /**
     * 取消护理任务
     */
    @PreAuthorize("@ss.hasPermi('nursing:nursingTask:edit')")
    @Log(title = "护理任务", businessType = BusinessType.UPDATE)
    @PutMapping("/cancel")
    @Operation(summary = "取消护理任务")
    public AjaxResult cancel(@RequestBody Map<String, Object> params)
    {
        Long taskId = ((Number) params.get("taskId")).longValue();
        String reason = (String) params.get("reason");
        nursingTaskService.cancelTask(taskId, reason);
        return success();
    }

    /**
     * 执行护理任务
     */
    @PreAuthorize("@ss.hasPermi('nursing:nursingTask:edit')")
    @Log(title = "护理任务", businessType = BusinessType.UPDATE)
    @PutMapping("/do")
    @Operation(summary = "执行护理任务")
    public AjaxResult doTask(@RequestBody Map<String, Object> params)
    {
        Long taskId = ((Number) params.get("taskId")).longValue();
        String estimatedServerTime = (String) params.get("estimatedServerTime");
        String taskImage = (String) params.get("taskImage");
        String mark = (String) params.get("mark");
        nursingTaskService.executeTask(taskId, estimatedServerTime, taskImage, mark);
        return success();
    }

    /**
     * 修改护理任务预计服务时间
     */
    @PreAuthorize("@ss.hasPermi('nursing:nursingTask:edit')")
    @Log(title = "护理任务", businessType = BusinessType.UPDATE)
    @PutMapping("/updateTime")
    @Operation(summary = "修改护理任务预计服务时间")
    public AjaxResult updateTime(@RequestBody Map<String, Object> params)
    {
        Long taskId = ((Number) params.get("taskId")).longValue();
        String estimatedServerTime = (String) params.get("estimatedServerTime");
        nursingTaskService.updateTaskTime(taskId, estimatedServerTime);
        return success();
    }

}
