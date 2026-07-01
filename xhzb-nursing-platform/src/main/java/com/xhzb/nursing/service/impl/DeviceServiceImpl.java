package com.xhzb.nursing.service.impl;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.*;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.huaweicloud.sdk.iotda.v5.IoTDAClient;
import com.huaweicloud.sdk.iotda.v5.model.*;
import com.xhzb.common.constant.CacheConstants;
import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.common.exception.base.BaseException;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.common.utils.StringUtils;
import com.xhzb.nursing.domain.dto.DeviceDto;
import com.xhzb.nursing.domain.vo.DeviceDetailVo;
import com.xhzb.nursing.domain.vo.ProductVo;
import com.xhzb.nursing.util.DateTimeZoneConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.mapper.DeviceMapper;
import com.xhzb.nursing.domain.Device;
import com.xhzb.nursing.service.IDeviceService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

/**
 * 设备Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-04-07
 */
@Service
public class DeviceServiceImpl extends ServiceImpl<DeviceMapper, Device> implements IDeviceService
{
    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    private IoTDAClient client;

    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    /**
     * 查询产品
     * @param productKey
     * @return
     */
    @Override
    public AjaxResult queryProduct(String productKey) {

        //参数校验
        if(StringUtils.isEmpty(productKey)){
            throw new BaseException("参数不能为空");
        }

        //调用iot
        ShowProductRequest request = new ShowProductRequest();
        request.setProductId(productKey);
        ShowProductResponse response;
        try {
            response = client.showProduct(request);
        } catch (Exception e) {
            throw new BaseException("华为云接口调用，查询产品失败");
        }

        // 获取数据
        List<ServiceCapability> serviceCapabilities = response.getServiceCapabilities();
        if(CollUtil.isEmpty(serviceCapabilities)){
            return AjaxResult.success(List.of());
        }
        return AjaxResult.success(serviceCapabilities);
    }

    /**
     * 查询设备属性
     * @param iotId
     * @return
     */
    @Override
    public AjaxResult queryServiceProperties(String iotId) {

        // iot平台数据
        ShowDeviceShadowRequest request = new ShowDeviceShadowRequest();
        request.setDeviceId(iotId);
        ShowDeviceShadowResponse response;
        try {
            response = client.showDeviceShadow(request);
        } catch (Exception e) {
            throw new BaseException("华为云接口调用，查询属性失败");
        }

        // 获取数据
        List<DeviceShadowData> shadow = response.getShadow();
        if(CollUtil.isEmpty(shadow)){
            return AjaxResult.success(List.of());
        }
        //解析数据
        DeviceShadowProperties reported = shadow.get(0).getReported();
        //转换为json对象
        JSONObject jsonObject = JSONUtil.parseObj(reported.getProperties());

        List<Map<String,Object>> result = new ArrayList<>();

        // 获取时间
        String eventTimeStr = reported.getEventTime();
        LocalDateTime localDateTime = LocalDateTimeUtil.parse(eventTimeStr, "yyyyMMdd'T'HHmmss'Z'");
        LocalDateTime eventTime = DateTimeZoneConverter.utcToShanghai(localDateTime);

        jsonObject.forEach((k,v)->{
            Map<String,Object> map = new HashMap<>();
            map.put("functionId",k);
            map.put("eventTime",eventTime);
            map.put("value",v);

            result.add(map);
        });

        return AjaxResult.success(result);
    }

    /**
     * 查询设备详情
     * @param iotId
     * @return
     */
    @Override
    public DeviceDetailVo getInfo(String iotId) {

        // 查询设备  到数据库中
        Device device = getOne(Wrappers.<Device>lambdaQuery().eq(Device::getIotId, iotId));

        // 到iot平台中去查询
        ShowDeviceRequest request = new ShowDeviceRequest();
        request.setDeviceId(iotId);
        ShowDeviceResponse response;
        try {
            response = client.showDevice(request);
        } catch (Exception e) {
            throw new BaseException("华为云接口调用，查询失败");
        }
        //属性拷贝
        DeviceDetailVo deviceDetailVo = BeanUtil.toBean(device, DeviceDetailVo.class);

        // 获取状态  获取激活时间
        String status = response.getStatus();
        // 获取激活时间
        String activeTimeStr = response.getActiveTime();
        if(StringUtils.isNotEmpty(activeTimeStr)){
            LocalDateTime localDateTime = LocalDateTimeUtil.parse(activeTimeStr, DatePattern.UTC_MS_PATTERN);
            LocalDateTime activeTime = DateTimeZoneConverter.utcToShanghai(localDateTime);
            deviceDetailVo.setActiveTime(activeTime);
        }
        deviceDetailVo.setDeviceStatus(status);

        return deviceDetailVo;
    }

    /**
     * 注册设备
     * @param dto
     */
    @Override
    public void registerDevice(DeviceDto dto) {
        // 判断设备名称是否重复
        long count = count(Wrappers.<Device>lambdaQuery().eq(Device::getDeviceName, dto.getDeviceName()));
        if(count > 0){
            throw new BaseException("设备名称已存在，请重新输入");
        }

        // 判断设备标识是否重复
        count = count(Wrappers.<Device>lambdaQuery().eq(Device::getNodeId, dto.getNodeId()));
        if(count > 0){
            throw new BaseException("设备标识已存在，请重新输入");
        }

        // 判断同一个位置或老人是否绑定了同一款产品
        // 产品id   位置类型  物理位置类型  绑定的id
        count = count(Wrappers.<Device>lambdaQuery()
                .eq(Device::getProductKey,dto.getProductKey())
                .eq(Device::getLocationType,dto.getLocationType())
                .eq(dto.getPhysicalLocationType() != null,Device::getPhysicalLocationType,dto.getPhysicalLocationType())
                .eq(Device::getBindingLocation,dto.getBindingLocation()));
        if(count > 0){
            throw new BaseException("该老人/位置已绑定该产品，请重新选择");
        }


        // 注册设备  iot平台
        AddDeviceRequest request = new AddDeviceRequest();
        AddDevice addDevice = new AddDevice();
        addDevice.withDeviceName(dto.getDeviceName());
        addDevice.withNodeId(dto.getNodeId());
        addDevice.withProductId(dto.getProductKey());

        AuthInfo authInfo = new AuthInfo();
        String secret = UUID.randomUUID().toString().replaceAll("-", "");
        authInfo.withSecret(secret);

        addDevice.setAuthInfo(authInfo);
        request.withBody(addDevice);
        AddDeviceResponse response;
        try {
            response = client.addDevice(request);
        } catch (Exception e) {
            throw new BaseException("华为云接口调用，注册失败");
        }

        // 保存设备  本地数据库
        // 属性拷贝
        Device device = BeanUtil.toBean(dto, Device.class);
        // 设备id
        String deviceId = response.getDeviceId();
        device.setIotId(deviceId);
        // 秘钥
        device.setSecret(secret);
        save(device);
    }

    /**
     * 查询所有产品
     * @return
     */
    @Override
    public List<ProductVo> allProduct() {

        //从redis中获取数据
        String result = redisTemplate.opsForValue().get(CacheConstants.IOT_ALL_PRODUCT_LIST);
        if(StringUtils.isEmpty(result)){
            return List.of();
        }
        //json字符串转换为list
        List<ProductVo> list = JSONUtil.toList(result, ProductVo.class);

        return list;
    }

    /**
     * 同步产品列表到本地
     */
    @Override
    public void syncProductList() {
        // 从华为平台中获取产品的数据
        ListProductsRequest request = new ListProductsRequest();
        request.setLimit(50);
        ListProductsResponse response = client.listProducts(request);
        if(response.getHttpStatusCode() != 200){
            throw new BaseException("同步失败");
        }

        // 存储到本地的redis中
        String jsonStr = JSONUtil.toJsonStr(response.getProducts());
        redisTemplate.opsForValue().set(CacheConstants.IOT_ALL_PRODUCT_LIST,jsonStr);
    }

    /**
     * 查询设备
     * 
     * @param id 设备主键
     * @return 设备
     */
    @Override
    public Device selectDeviceById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询设备列表
     * 
     * @param device 设备
     * @return 设备
     */
    @Override
    public List<Device> selectDeviceList(Device device)
    {
        return deviceMapper.selectDeviceList(device);
    }

    /**
     * 新增设备
     * 
     * @param device 设备
     * @return 结果
     */
    @Override
    public int insertDevice(Device device)
    {
        return save(device)? 1 : 0;
    }

    /**
     * 修改设备
     *
     * @param dto 设备
     * @return 结果
     */
    @Override
    public void updateDevice(DeviceDto dto)
    {

        //修改本地数据
        Device device = BeanUtil.toBean(dto, Device.class);
        try {
            updateById(device);
        } catch (Exception e) {
            throw new BaseException("相同的位置不能绑定同一个产品");
        }

        //修改iot平台的数据
        UpdateDeviceRequest request = new UpdateDeviceRequest();
        //条件，设备id
        request.withDeviceId(dto.getIotId());
        UpdateDevice body = new UpdateDevice();
        //设备名称
        body.withDeviceName(dto.getDeviceName());
        request.withBody(body);
        UpdateDeviceResponse response;
        try {
            response = client.updateDevice(request);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BaseException("物联网接口 - 修改设备，调用失败");
        }
    }

    /**
     * 批量删除设备
     * 
     * @param ids 需要删除的设备主键
     * @return 结果
     */
    @Override
    public int deleteDeviceByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids))? 1 : 0;
    }

    /**
     * 删除设备信息
     * @param iotId 设备主键
     * @return 结果
     */
    @Override
    public void deleteDeviceById(String iotId)
    {
        // 数据库中删除数据
        remove(Wrappers.<Device>lambdaQuery().eq(Device::getIotId, iotId));

        // iot平台删除
        DeleteDeviceRequest request = new DeleteDeviceRequest();
        request.withDeviceId(iotId);
        try {
            client.deleteDevice(request);
        } catch (Exception e) {
            e.printStackTrace();
            throw new BaseException("物联网接口 - 删除设备，调用失败");
        }
    }
}
