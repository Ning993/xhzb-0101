package com.xhzb.nursing.controller;

import com.xhzb.common.annotation.Log;
import com.xhzb.common.core.controller.BaseController;
import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.common.core.page.TableDataInfo;
import com.xhzb.common.enums.BusinessType;
import com.xhzb.common.utils.poi.ExcelUtil;
import com.xhzb.nursing.domain.NursingElder;
import com.xhzb.nursing.domain.dto.NursingElderDto;
import com.xhzb.nursing.service.INursingElderService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 护理员老人关联Controller
 * 
 * @author ruoyi
 * @date 2024-05-28
 */
@RestController
@RequestMapping("/elder/nursingElder")
public class NursingElderController extends BaseController
{
    @Autowired
    private INursingElderService nursingElderService;

    /**
     * 查询护理员老人关联列表
     */
    @PreAuthorize("@ss.hasPermi('elder:elder:list')")
    @GetMapping("/list")
    public TableDataInfo list(NursingElder nursingElder)
    {
        startPage();
        List<NursingElder> list = nursingElderService.selectNursingElderList(nursingElder);
        return getDataTable(list);
    }

    /**
     * 导出护理员老人关联列表
     */
    @PreAuthorize("@ss.hasPermi('elder:elder:export')")
    @Log(title = "护理员老人关联", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, NursingElder nursingElder)
    {
        List<NursingElder> list = nursingElderService.selectNursingElderList(nursingElder);
        ExcelUtil<NursingElder> util = new ExcelUtil<NursingElder>(NursingElder.class);
        util.exportExcel(response, list, "护理员老人关联数据");
    }

    /**
     * 获取护理员老人关联详细信息
     */
    @PreAuthorize("@ss.hasPermi('elder:elder:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(nursingElderService.selectNursingElderById(id));
    }

    /**
     * 新增护理员老人关联
     */
    @PreAuthorize("@ss.hasPermi('elder:elder:add')")
    @Log(title = "护理员老人关联", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody NursingElder nursingElder)
    {
        return toAjax(nursingElderService.insertNursingElder(nursingElder));
    }

    /**
     * 修改护理员老人关联
     */
    @PreAuthorize("@ss.hasPermi('elder:elder:edit')")
    @Log(title = "护理员老人关联", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody NursingElder nursingElder)
    {
        return toAjax(nursingElderService.updateNursingElder(nursingElder));
    }

    /**
     * 删除护理员老人关联
     */
    @PreAuthorize("@ss.hasPermi('elder:elder:remove')")
    @Log(title = "护理员老人关联", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(nursingElderService.deleteNursingElderByIds(ids));
    }
}
