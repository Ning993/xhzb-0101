package com.xhzb.nursing.controller;

import java.lang.ref.WeakReference;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.xhzb.nursing.domain.HealthAssessmentReport;
import com.xhzb.nursing.domain.dto.health.ElderAssessmentDto;
import com.xhzb.nursing.service.IHealthAssessmentReportService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
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
import com.xhzb.nursing.domain.HealthAssessment;
import com.xhzb.nursing.service.IHealthAssessmentService;
import com.xhzb.common.utils.poi.ExcelUtil;
import com.xhzb.common.core.page.TableDataInfo;

/**
 * 健康评估记录Controller
 * 
 * @author ruoyi
 * @date 2026-04-01
 */
@RestController
@RequestMapping("/nursing/healthAssessment")
@Tag(name = "健康评估记录相关接口")
public class HealthAssessmentController extends BaseController
{
    @Autowired
    private IHealthAssessmentService healthAssessmentService;

    @GetMapping("/elder/{id}")
    public AjaxResult getElderInfoById(@PathVariable Long id){
        Map<String, Object> result = healthAssessmentService.getElderInfoById(id);
        return success(result);
    }

    /**
     * 查询健康评估记录列表
     */
    @PreAuthorize("@ss.hasPermi('nursing:healthAssessment:list')")
    @GetMapping("/list")
    @Operation(summary = "查询健康评估记录列表")
    public TableDataInfo list(HealthAssessment healthAssessment)
    {
        startPage();
        List<HealthAssessment> list = healthAssessmentService.selectHealthAssessmentList(healthAssessment);
        return getDataTable(list);
    }

    /**
     * 导出健康评估记录列表
     */
    @PreAuthorize("@ss.hasPermi('nursing:healthAssessment:export')")
    @Log(title = "健康评估记录", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @Operation(summary = "导出健康评估记录列表")
    public void export(HttpServletResponse response, HealthAssessment healthAssessment)
    {
        List<HealthAssessment> list = healthAssessmentService.selectHealthAssessmentList(healthAssessment);
        ExcelUtil<HealthAssessment> util = new ExcelUtil<HealthAssessment>(HealthAssessment.class);
        util.exportExcel(response, list, "健康评估记录数据");
    }

    /**
     * 获取健康评估记录详细信息
     */
    @PreAuthorize("@ss.hasPermi('nursing:healthAssessment:query')")
    @GetMapping(value = "/{id}")
    @Operation(summary = "获取健康评估记录详细信息")
    public AjaxResult getInfo(@Schema(name = "健康评估记录ID", requiredMode = Schema.RequiredMode.REQUIRED)
            @PathVariable("id") Long id)
    {
        return success(healthAssessmentService.selectHealthAssessmentById(id));
    }

    /**
     * 新增健康评估记录
     */
    @PreAuthorize("@ss.hasPermi('nursing:healthAssessment:add')")
    @Log(title = "健康评估记录", businessType = BusinessType.INSERT)
    @PostMapping
    @Operation(summary = "新增健康评估记录")
    public AjaxResult add(@RequestBody ElderAssessmentDto dto)
    {
        return success(healthAssessmentService.insertHealthAssessment(dto));
    }

    /**
     * 修改健康评估记录
     */
    @PreAuthorize("@ss.hasPermi('nursing:healthAssessment:edit')")
    @Log(title = "健康评估记录", businessType = BusinessType.UPDATE)
    @PutMapping
    @Operation(summary = "修改健康评估记录")
    public AjaxResult edit(@RequestBody ElderAssessmentDto dto)
    {
        return success(healthAssessmentService.updateHealthAssessment(dto));
    }

    /**
     * 删除健康评估记录
     */
    @PreAuthorize("@ss.hasPermi('nursing:healthAssessment:remove')")
    @Log(title = "健康评估记录", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    @Operation(summary = "删除健康评估记录")
    public AjaxResult remove(@PathVariable Long id)
    {
        return toAjax(healthAssessmentService.deleteHealthAssessmentById(id));
    }

    /**
     * 取消健康评估记录
     */
    @PreAuthorize("@ss.hasPermi('nursing:healthAssessment:edit')")
    @Log(title = "取消评估记录", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}")
    @Operation(summary = "取消健康评估记录")
    public AjaxResult cancel(@PathVariable Long id)
    {
        return toAjax(healthAssessmentService.cancel(id));
    }


    @PostMapping("/assessmentData")
    public AjaxResult assessmentData(@RequestBody ElderAssessmentDto dto){
        return success(healthAssessmentService.assessmentData(dto));
    }

    @Autowired
    private IHealthAssessmentReportService healthAssessmentReportService;


    @GetMapping("/report/{id}")
    public AjaxResult getReport(@PathVariable Long id){
        /*LambdaQueryWrapper<HealthAssessmentReport> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(HealthAssessmentReport::getHealthAssessmentId,id);*/
        /*LambdaQueryWrapper<HealthAssessmentReport> healthAssessmentReportLambdaQueryWrapper = Wrappers.<HealthAssessmentReport>lambdaQuery();
        healthAssessmentReportLambdaQueryWrapper.eq(HealthAssessmentReport::getHealthAssessmentId, id);*/
        HealthAssessmentReport healthAssessmentReport = healthAssessmentReportService.getOne(Wrappers.<HealthAssessmentReport>lambdaQuery().eq(HealthAssessmentReport::getHealthAssessmentId, id));
        return success(healthAssessmentReport);
    }
}
