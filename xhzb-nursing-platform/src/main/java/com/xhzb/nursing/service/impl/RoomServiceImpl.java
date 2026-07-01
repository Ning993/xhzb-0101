package com.xhzb.nursing.service.impl;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xhzb.common.constant.CacheConstants;
import com.xhzb.common.utils.StringUtils;
import com.xhzb.nursing.domain.DeviceData;
import com.xhzb.nursing.domain.Room;
import com.xhzb.nursing.mapper.RoomMapper;
import com.xhzb.nursing.service.IRoomService;
import com.xhzb.nursing.domain.vo.RoomVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

/**
 * 房间Service业务层处理
 *
 * @author ruoyi
 * @date 2025-03-28
 */
@Service
public class RoomServiceImpl extends ServiceImpl<RoomMapper, Room> implements IRoomService {
    @Autowired
    private RoomMapper roomMapper;

    /**
     * 查询房间
     *
     * @param id 房间主键
     * @return 房间
     */
    @Override
    public Room selectRoomById(Long id) {
        return getById(id);
    }

    /**
     * 查询房间列表
     *
     * @param room 房间
     * @return 房间
     */
    @Override
    public List<Room> selectRoomList(Room room) {
        return roomMapper.selectRoomList(room);
    }

    /**
     * 新增房间
     *
     * @param room 房间
     * @return 结果
     */
    @Override
    public int insertRoom(Room room) {
        return save(room) ? 1 : 0;
    }

    /**
     * 修改房间
     *
     * @param room 房间
     * @return 结果
     */
    @Override
    public int updateRoom(Room room) {
        return updateById(room) ? 1 : 0;
    }

    /**
     * 批量删除房间
     *
     * @param ids 需要删除的房间主键
     * @return 结果
     */
    @Override
    public int deleteRoomByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) ? 1 : 0;
    }

    /**
     * 根据楼层 id 获取房间视图对象列表
     *
     * @param floorId
     * @return
     */
    @Override
    public List<RoomVo> getRoomsByFloorId(Long floorId) {
        return roomMapper.selectByFloorId(floorId);
    }


    /**
     * 获取所有房间（负责老人）
     *
     * @param floorId
     * @return
     */
    @Override
    public List<RoomVo> getRoomsWithNurByFloorId(Long floorId) {
        return roomMapper.selectByFloorIdWithNur(floorId);
    }

    /**
     * 根据 id 获取房间视图对象
     *
     * @param id
     * @return
     */
    @Override
    public RoomVo getRoomById(Long id) {
        return roomMapper.getRoomById(id);
    }

    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    /**
     * 根据楼层 id 获取房间视图对象列表
     *
     * @return
     */
    @Override
    public List<RoomVo> getRoomsWithDeviceByFloorId(Long floorId) {
        List<RoomVo> roomVos = roomMapper.getRoomsWithDeviceByFloorId(floorId);
        //先找到房间设备中的数据
        roomVos.forEach(roomVo -> {
            roomVo.getDeviceVos().forEach(deviceVo -> {
                // 获取redis中的数据
                String jsonStr = (String) redisTemplate.opsForHash().get(CacheConstants.IOT_DEVICE_LAST_DATA, deviceVo.getIotId());
                if(StringUtils.isEmpty(jsonStr)){
                    return;  // 在foreach 中的return 是跳出本次循环，并不是结束方法
                }
                deviceVo.setDeviceDataVos(JSONUtil.toList(jsonStr, DeviceData.class));
            });
            //找房间中的床位 床位上的设备
            roomVo.getBedVoList().forEach(bedVo -> {
                bedVo.getDeviceVos().forEach(deviceVo -> {
                    // 获取redis中的数据
                    String jsonStr = (String) redisTemplate.opsForHash().get(CacheConstants.IOT_DEVICE_LAST_DATA, deviceVo.getIotId());
                    if(StringUtils.isEmpty(jsonStr)){
                        return;  // 在foreach 中的return 是跳出本次循环，并不是结束方法
                    }
                    deviceVo.setDeviceDataVos(JSONUtil.toList(jsonStr, DeviceData.class));

                });

            });
        });


        return roomVos;
    }
}
