package com.xhzb.nursing.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xhzb.common.core.page.TableDataInfo;
import com.xhzb.common.exception.base.BaseException;
import com.xhzb.common.utils.UserThreadLocal;
import com.xhzb.nursing.domain.Reservation;
import com.xhzb.nursing.domain.dto.ReservationDto;
import com.xhzb.nursing.domain.dto.ReservationQueryDto;
import com.xhzb.nursing.domain.vo.TimeCountVo;
import com.xhzb.nursing.mapper.ReservationMapper;
import com.xhzb.nursing.service.IReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 预约信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2024-06-07
 */
@Service
public class ReservationServiceImpl extends ServiceImpl<ReservationMapper, Reservation> implements IReservationService
{
    @Autowired
    private ReservationMapper reservationMapper;

    /**
     * 查询每个时间段剩余预约次数
     * @return
     */
    @Override
    public List<TimeCountVo> countReservationsForTime(Long time) {

        //2025-04-27  前端传入的日期，由毫秒值转换为LocalDateTime
        LocalDateTime localDateTime = LocalDateTimeUtil.of(time);
        //构建当天开始时间：2025-04-27 00:00:00
        LocalDateTime startTime = localDateTime.toLocalDate().atStartOfDay();
        //构建当天结束时间：2025-04-28 00:00:00
        LocalDateTime endTime = startTime.plusHours(24);
        List<TimeCountVo> timeCountVoList = reservationMapper.countReservationsForTime(startTime,endTime);
        return timeCountVoList;
    }

    /**
     * 查询取消预约次数
     * @param userId
     * @return
     */
    @Override
    public int getCancelledCount(Long userId) {
        //当天的开始时间 2025-04-27 00:00:00
        LocalDateTime startTime = LocalDate.now().atStartOfDay();
        //当天结束时间：2025-04-28 00:00:00
        LocalDateTime endTime = startTime.plusHours(24);
        //查询条件
        LambdaQueryWrapper<Reservation> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        //修改人  也是登录人
        lambdaQueryWrapper.eq(Reservation::getUpdateBy,userId);
        //修改时间在当天范围内
        lambdaQueryWrapper.between(Reservation::getUpdateTime,startTime,endTime);
        //count值，返回取消次数
        return (int) count(lambdaQueryWrapper);
    }

    /**
     * 分页查询预约信息
     * @param pageNum
     * @param pageSize
     * @param status
     * @return
     */
    @Override
    public TableDataInfo findByPage(int pageNum, int pageSize, Integer status) {
        //获取当前登录人
        Long userId = UserThreadLocal.getUserId();
        if(ObjectUtil.isEmpty(userId)){
            throw new BaseException("请先登录");
        }
        //构建查询条件对象
        LambdaQueryWrapper<Reservation> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        //必加条件，只能查询自己的预约
        lambdaQueryWrapper.eq(Reservation::getCreateBy,userId);
        //状态不空，则根据状态查询
        lambdaQueryWrapper.eq(ObjectUtil.isNotEmpty(status),Reservation::getStatus,status);
        //按照时间降序查询
        lambdaQueryWrapper.orderByDesc(Reservation::getCreateTime);
        //构建分页条件
        Page page = new Page<>(pageNum,pageSize);
        //查询
        page = page(page,lambdaQueryWrapper);
        //构建返回值
        return createTableDataInfo(page);
    }

    private TableDataInfo createTableDataInfo(Page page) {
        TableDataInfo tableDataInfo = new TableDataInfo();
        tableDataInfo.setRows(page.getRecords());
        tableDataInfo.setTotal(page.getTotal());
        tableDataInfo.setMsg("请求成功");
        tableDataInfo.setCode(200);
        return  tableDataInfo;
    }

    /**
     * 取消预约
     * @param id
     * @return
     */
    @Override
    public int cancelReservation(Long id) {
        //根据id查询
        Reservation reservation = getById(id);
        if(ObjectUtil.isEmpty(reservation)){
            throw new BaseException("预约不存在");
        }
        //设置状态为取消
        reservation.setStatus(2);
        //设置修改人
        reservation.setUpdateBy(UserThreadLocal.getUserId()+"");
        return updateById(reservation) ? 1 : 0;
    }

    /**
     * 查询预约信息
     * 
     * @param id 预约信息主键
     * @return 预约信息
     */
    @Override
    public Reservation selectReservationById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询预约信息列表
     * 
     * @param dto 预约信息
     * @return 预约信息
     */
    @Override
    public List<Reservation> selectReservationList(ReservationQueryDto dto)
    {
        return reservationMapper.selectReservationList(dto);
    }

    /**
     * 新增预约信息
     * 
     * @param reservationDto 预约信息
     * @return 结果
     */
    @Override
    public int insertReservation(ReservationDto reservationDto)
    {
        //获取当前登录人
        Long userId = UserThreadLocal.getUserId();
        //属性拷贝对象
        Reservation reservation = BeanUtil.toBean(reservationDto, Reservation.class);
        //设置创建人
        reservation.setCreateBy(userId+"");
        //设置修改人
        reservation.setUpdateBy(userId+"");
        //设置状态，默认为0：待报道
        reservation.setStatus(0);
        return save(reservation) ? 1 : 0;
    }

    /**
     * 修改预约信息
     * 
     * @param reservation 预约信息
     * @return 结果
     */
    @Override
    public int updateReservation(Reservation reservation)
    {
        return updateById(reservation) ? 1 : 0;
    }

    /**
     * 批量删除预约信息
     * 
     * @param ids 需要删除的预约信息主键
     * @return 结果
     */
    @Override
    public int deleteReservationByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids)) ? 1 : 0;
    }

    /**
     * 删除预约信息信息
     * 
     * @param id 预约信息主键
     * @return 结果
     */
    @Override
    public int deleteReservationById(Long id)
    {
        return removeById(id) ? 1 : 0;
    }

    /**
     * 每小时的第1分和第31分钟  执行一次状态检查
     *       0 1,31 * * * ?
     */
    @Override
    public void updateReservationStatus() {
        //查询符合条件的预约信息，已经过期，还没有来的
        LocalDateTime now = LocalDateTime.now();
        LambdaQueryWrapper<Reservation> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(Reservation::getStatus,0);
        lambdaQueryWrapper.lt(Reservation::getTime,now);
        List<Reservation> list = list(lambdaQueryWrapper);
        if(CollUtil.isNotEmpty(list)){
            //获取所有的ID,并且转换为集合
            List<Long> ids = list.stream().map(Reservation::getId).collect(Collectors.toList());
            /*List<Long> list2 = new ArrayList();
            list.forEach(item->{
                list2.add(item.getId());
            });*/

            //批量更新
            reservationMapper.batchUpdateStatus(ids);
        }
    }
}
