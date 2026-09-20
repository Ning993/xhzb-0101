package com.xhzb.nursing.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import com.xhzb.common.exception.ServiceException;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.mapper.AlertDataMapper;
import com.xhzb.nursing.domain.AlertData;
import com.xhzb.nursing.service.IAlertDataService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import java.util.Arrays;

/**
 * 报警数据Service业务层处理
 *
 * @author ruoyi
 * @date 2026-04-10
 */
@Service
public class AlertDataServiceImpl extends ServiceImpl<AlertDataMapper, AlertData> implements IAlertDataService
{
    @Autowired
    private AlertDataMapper alertDataMapper;

    /**
     * 查询报警数据
     *
     * @param id 报警数据主键
     * @return 报警数据
     */
    @Override
    public AlertData selectAlertDataById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询报警数据列表
     *
     * @param alertData 报警数据
     * @return 报警数据
     */
    @Override
    public List<AlertData> selectAlertDataList(AlertData alertData)
    {
        return alertDataMapper.selectAlertDataList(alertData);
    }

    /**
     * 新增报警数据
     *
     * @param alertData 报警数据
     * @return 结果
     */
    @Override
    public int insertAlertData(AlertData alertData)
    {
        return save(alertData)? 1 : 0;
    }

    /**
     * 修改报警数据
     *
     * @param alertData 报警数据
     * @return 结果
     */
    @Override
    public int updateAlertData(AlertData alertData)
    {
        return updateById(alertData)? 1 : 0;
    }

    /**
     * 批量删除报警数据
     *
     * @param ids 需要删除的报警数据主键
     * @return 结果
     */
    @Override
    public int deleteAlertDataByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids))? 1 : 0;
    }

    /**
     * 删除报警数据信息
     *
     * @param id 报警数据主键
     * @return 结果
     */
    @Override
    public int deleteAlertDataById(Long id)
    {
        return removeById(id)? 1 : 0;
    }

    /**
     * 处理报警数据
     *
     * @param id 报警数据主键
     * @param processingResult 处理结果
     * @param processingTime 处理时间
     */
    @Override
    public void handleAlertData(Long id, String processingResult, LocalDateTime processingTime)
    {
        AlertData alertData = getById(id);
        if (alertData == null)
        {
            throw new ServiceException("报警数据不存在，id=" + id);
        }
        alertData.setStatus(1);
        alertData.setProcessingResult(processingResult);
        alertData.setProcessingTime(processingTime);
        alertData.setProcessorId(SecurityUtils.getUserId());
        alertData.setProcessorName(SecurityUtils.getUsername());
        updateById(alertData);
    }
}
