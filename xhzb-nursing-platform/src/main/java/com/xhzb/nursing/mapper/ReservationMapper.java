package com.xhzb.nursing.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.xhzb.nursing.domain.Reservation;
import com.xhzb.nursing.domain.dto.ReservationQueryDto;
import com.xhzb.nursing.domain.vo.TimeCountVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 预约信息Mapper接口
 * 
 * @author ruoyi
 * @date 2024-06-07
 */
@Mapper
public interface ReservationMapper extends BaseMapper<Reservation>
{
    /**
     * 查询预约信息
     * 
     * @param id 预约信息主键
     * @return 预约信息
     */
    public Reservation selectReservationById(Long id);

    /**
     * 查询预约信息列表
     * 
     * @param dto 预约信息
     * @return 预约信息集合
     */
    public List<Reservation> selectReservationList(ReservationQueryDto dto);

    /**
     * 新增预约信息
     * 
     * @param reservation 预约信息
     * @return 结果
     */
    public int insertReservation(Reservation reservation);

    /**
     * 修改预约信息
     * 
     * @param reservation 预约信息
     * @return 结果
     */
    public int updateReservation(Reservation reservation);

    /**
     * 删除预约信息
     * 
     * @param id 预约信息主键
     * @return 结果
     */
    public int deleteReservationById(Long id);

    /**
     * 批量删除预约信息
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteReservationByIds(Long[] ids);

    List<TimeCountVo> countReservationsForTime(@Param("startTime") LocalDateTime startTime,@Param("endTime")  LocalDateTime endTime);

    void batchUpdateStatus(@Param("list") List<Long> ids);
}
