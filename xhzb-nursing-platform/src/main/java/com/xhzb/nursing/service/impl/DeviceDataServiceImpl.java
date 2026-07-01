package com.xhzb.nursing.service.impl;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.xhzb.common.constant.CacheConstants;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.nursing.domain.Device;
import com.xhzb.nursing.job.vo.IotMsgNotifyData;
import com.xhzb.nursing.mapper.DeviceMapper;
import com.xhzb.nursing.util.DateTimeZoneConverter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.mapper.DeviceDataMapper;
import com.xhzb.nursing.domain.DeviceData;
import com.xhzb.nursing.service.IDeviceDataService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;
import java.util.Map;

/**
 * 设备数据Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-04-09
 */
@Slf4j
@Service
public class DeviceDataServiceImpl extends ServiceImpl<DeviceDataMapper, DeviceData> implements IDeviceDataService
{
    @Autowired
    private DeviceDataMapper deviceDataMapper;

    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    /**
     * 批量保存数据
     *
     * @param iotMsgNotifyData
     */
    @Override
    public void batchInsertDeviceData(IotMsgNotifyData iotMsgNotifyData) {
        // 获取设备id
        String iotId = iotMsgNotifyData.getHeader().getDeviceId();
        //查询设备是否存在
        Device device = deviceMapper.selectOne(Wrappers.<Device>lambdaQuery().eq(Device::getIotId, iotId));
        if(ObjectUtil.isEmpty(device)){
            log.info("设备不存在");
            return;
        }

        // 保存数据
        iotMsgNotifyData.getBody().getServices().forEach(s->{
            // 某一个服务  只有一个服务
            Map<String, Object> properties = s.getProperties();
            if(CollUtil.isEmpty(properties)){
                return;
            }

            List<DeviceData> list = new ArrayList<>();

            //处理上报时间
            String eventTimeStr = s.getEventTime();
            LocalDateTime eventTime = DateTimeZoneConverter.utcToShanghai(LocalDateTimeUtil.parse(eventTimeStr, "yyyyMMdd'T'HHmmss'Z'"));

            //批量保存  k  functionId  v  value
            s.getProperties().forEach((k,v)->{
                // 1 从设备中拷贝数据到设备数据表中
                DeviceData deviceData = BeanUtil.toBean(device, DeviceData.class);
                // 哪些字段不能拷贝
                deviceData.setId(null);
                deviceData.setCreateTime(null);
                deviceData.setAccessLocation(device.getBindingLocation());
                // 哪些字段需要补全
                deviceData.setFunctionId(k);
                deviceData.setDataValue(v+"");
                deviceData.setAlarmTime(eventTime);

                list.add(deviceData);
            });
            saveBatch(list);
            //存储到redis中
            redisTemplate.opsForHash().put(CacheConstants.IOT_DEVICE_LAST_DATA,iotId, JSONUtil.toJsonStr(list));
        });

    }

    /**
     * 查询设备数据
     * 
     * @param id 设备数据主键
     * @return 设备数据
     */
    @Override
    public DeviceData selectDeviceDataById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询设备数据列表
     * 
     * @param deviceData 设备数据
     * @return 设备数据
     */
    @Override
    public List<DeviceData> selectDeviceDataList(DeviceData deviceData)
    {
        return deviceDataMapper.selectDeviceDataList(deviceData);
    }

    /**
     * 新增设备数据
     * 
     * @param deviceData 设备数据
     * @return 结果
     */
    @Override
    public int insertDeviceData(DeviceData deviceData)
    {
        return save(deviceData)? 1 : 0;
    }

    /**
     * 修改设备数据
     * 
     * @param deviceData 设备数据
     * @return 结果
     */
    @Override
    public int updateDeviceData(DeviceData deviceData)
    {
        return updateById(deviceData)? 1 : 0;
    }

    /**
     * 批量删除设备数据
     * 
     * @param ids 需要删除的设备数据主键
     * @return 结果
     */
    @Override
    public int deleteDeviceDataByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids))? 1 : 0;
    }

    /**
     * 删除设备数据信息
     * 
     * @param id 设备数据主键
     * @return 结果
     */
    @Override
    public int deleteDeviceDataById(Long id)
    {
        return removeById(id)? 1 : 0;
    }
}
