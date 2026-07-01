package com.xhzb.nursing.controller;

import com.xhzb.common.core.controller.BaseController;
import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.common.core.page.TableDataInfo;
import com.xhzb.nursing.domain.Device;
import com.xhzb.nursing.domain.dto.DeviceDto;
import com.xhzb.nursing.domain.vo.DeviceDetailVo;
import com.xhzb.nursing.service.IDeviceService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.hibernate.validator.constraints.ParameterScriptAssert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 设备Controller
 * 
 * @author ruoyi
 * @date 2026-04-07
 */
@RestController
@RequestMapping("/nursing/device")
@Tag(name = "设备相关接口")
public class DeviceController extends BaseController
{
    @Autowired
    private IDeviceService deviceService;

    @GetMapping("/queryProduct/{productKey}")
    public AjaxResult queryProduct(@PathVariable String productKey){
        return deviceService.queryProduct(productKey);
    }


    @DeleteMapping("/{iotId}")
    public AjaxResult delDevice(@PathVariable String iotId){
        deviceService.deleteDeviceById(iotId);
        return success();
    }

    @PutMapping
    public AjaxResult updateDevice(@RequestBody DeviceDto dto){
        deviceService.updateDevice(dto);
        return success();
    }

    @GetMapping("/queryServiceProperties/{iotId}")
    public AjaxResult queryServiceProperties(@PathVariable String iotId){
        return deviceService.queryServiceProperties(iotId);
    }

    @GetMapping("/{iotId}")
    public AjaxResult getInfo(@PathVariable String iotId){
        DeviceDetailVo deviceDetailVo = deviceService.getInfo(iotId);
        return success(deviceDetailVo);
    }

    @PostMapping("/register")
    public AjaxResult registerDevice(@RequestBody DeviceDto dto){
        deviceService.registerDevice(dto);
        return success();
    }

    @GetMapping("/allProduct")
    public AjaxResult allProduct(){
        return success(deviceService.allProduct());
    }

    @PostMapping("/syncProductList")
    public AjaxResult syncProductList(){
        deviceService.syncProductList();
        return success();
    }

    /**
     * 查询设备列表
     */
    @PreAuthorize("@ss.hasPermi('nursing:device:list')")
    @GetMapping("/list")
    @Operation(summary = "查询设备列表")
    public TableDataInfo list(Device device)
    {
        startPage();
        List<Device> list = deviceService.selectDeviceList(device);
        return getDataTable(list);
    }

}
