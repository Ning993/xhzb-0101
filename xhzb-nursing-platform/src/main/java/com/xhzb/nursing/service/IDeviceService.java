package com.xhzb.nursing.service;

import java.util.List;
import java.util.Map;

import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.nursing.domain.Device;
import com.baomidou.mybatisplus.extension.service.IService;
import com.xhzb.nursing.domain.dto.DeviceDto;
import com.xhzb.nursing.domain.vo.DeviceDetailVo;
import com.xhzb.nursing.domain.vo.ProductVo;

/**
 * 设备Service接口
 * 
 * @author ruoyi
 * @date 2026-04-07
 */
public interface IDeviceService extends IService<Device>
{
    /**
     * 查询设备
     * 
     * @param id 设备主键
     * @return 设备
     */
    public Device selectDeviceById(Long id);

    /**
     * 查询设备列表
     * 
     * @param device 设备
     * @return 设备集合
     */
    public List<Device> selectDeviceList(Device device);

    /**
     * 新增设备
     * 
     * @param device 设备
     * @return 结果
     */
    public int insertDevice(Device device);

    /**
     * 修改设备
     *
     * @param dto 设备
     * @return 结果
     */
    public void updateDevice(DeviceDto dto);

    /**
     * 批量删除设备
     * 
     * @param ids 需要删除的设备主键集合
     * @return 结果
     */
    public int deleteDeviceByIds(Long[] ids);

    /**
     * 删除设备信息
     *
     * @param iotId 设备主键
     * @return 结果
     */
    public void deleteDeviceById(String iotId);

    /**
     * 同步产品列表到本地
     */
    void syncProductList();

    /**
     * 查询所有产品
     * @return
     */
    List<ProductVo> allProduct();

    /**
     * 注册设备
     * @param dto
     */
    void registerDevice(DeviceDto dto);

    /**
     * 查询设备详情
     * @param iotId
     * @return
     */
    DeviceDetailVo getInfo(String iotId);

    /**
     * 查询设备属性
     * @param iotId
     * @return
     */
    AjaxResult queryServiceProperties(String iotId);

    /**
     * 查询设备物模型属性状态
     * @param params 查询参数（deviceId/iotId 等）
     * @return
     */
    AjaxResult queryDevicePropertyStatus(Map<String, Object> params);

    /**
     * 查询产品
     * @param productKey
     * @return
     */
    AjaxResult queryProduct(String productKey);
}
