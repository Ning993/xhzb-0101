package com.xhzb.nursing.service.impl;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.text.CharSequenceUtil;
import cn.hutool.core.util.NumberUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.xhzb.common.constant.CacheConstants;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.common.utils.StringUtils;
import com.xhzb.nursing.domain.AlertData;
import com.xhzb.nursing.domain.DeviceData;
import com.xhzb.nursing.service.IAlertDataService;
import com.xhzb.system.mapper.SysUserRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.mapper.AlertRuleMapper;
import com.xhzb.nursing.domain.AlertRule;
import com.xhzb.nursing.service.IAlertRuleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;

import javax.print.attribute.standard.NumberUp;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;

/**
 * 报警规则Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-04-10
 */
@Service
public class AlertRuleServiceImpl extends ServiceImpl<AlertRuleMapper, AlertRule> implements IAlertRuleService
{
    @Autowired
    private AlertRuleMapper alertRuleMapper;

    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    /**
     * 报警过滤
     */
    @Override
    public void alertFilter() {
        // 查询所有规则
        long count = count(Wrappers.<AlertRule>lambdaQuery().eq(AlertRule::getStatus, 1));
        if(count <= 0){
            return;
        }
        //查询设备上报的最新的数据  List<DeviceData>
        List<Object> values = redisTemplate.opsForHash().values(CacheConstants.IOT_DEVICE_LAST_DATA);
        if(CollUtil.isEmpty(values)){
            return;
        }

        List<DeviceData> deviceDataList = new ArrayList<>();

        //把多份list装入到同一个list
        /*for (Object value : values) {
            list.addAll(JSONUtil.toList(value.toString(), DeviceData.class));
        }*/
        values.forEach(v-> deviceDataList.addAll(JSONUtil.toList(v.toString(), DeviceData.class)));

        //分别处理某一条数据
        deviceDataList.forEach(d->alertFilter(d));

    }

    /**
     * 上报的数据报警过滤
     * @param deviceData
     */
    private void alertFilter(DeviceData deviceData) {
        // 判断是否是否超过1分钟
        LocalDateTime alarmTime = deviceData.getAlarmTime();
        long between = LocalDateTimeUtil.between(alarmTime, LocalDateTime.now(), ChronoUnit.SECONDS);
        if(between > 60){
            return;
        }

        // 查询报警规则  iotid,funtionid productid status
        List<AlertRule> iotAlertRule = list(Wrappers.<AlertRule>lambdaQuery()
                .eq(AlertRule::getIotId, deviceData.getIotId())
                .eq(AlertRule::getFunctionId, deviceData.getFunctionId())
                .eq(AlertRule::getProductKey, deviceData.getProductKey())
                .eq(AlertRule::getStatus, 1));

        List<AlertRule> allAlertRule = list(Wrappers.<AlertRule>lambdaQuery()
                .eq(AlertRule::getIotId, "-1")
                .eq(AlertRule::getFunctionId, deviceData.getFunctionId())
                .eq(AlertRule::getProductKey, deviceData.getProductKey())
                .eq(AlertRule::getStatus, 1));

        // 合并
        Collection<AlertRule> allRules = CollUtil.addAll(iotAlertRule, allAlertRule);
        if(CollUtil.isEmpty(allRules)){
            return;
        }

        // 遍历规则，匹配数据
        allRules.forEach(rule-> deviceDataAlarmHandler(rule,deviceData) );


    }

    /**
     * 设备数据报警处理
     * @param rule
     * @param deviceData
     */
    private void deviceDataAlarmHandler(AlertRule rule, DeviceData deviceData) {
        // 判断上报的时间是否在生效时段内  08:00:00 ~ 18:00:00
        String[] split = rule.getAlertEffectivePeriod().split("~");
        LocalTime startTime = LocalTime.parse(split[0]);
        LocalTime endTime = LocalTime.parse(split[1]);
        // 上报时间
        LocalTime time = deviceData.getAlarmTime().toLocalTime();
        if(time.isBefore(startTime) || time.isAfter(endTime)){
            return;
        }
        // 统计数据的key
        String triggerKey = CacheConstants.ALERT_TRIGGER_COUNT_PREFIX + deviceData.getIotId() +":"+ deviceData.getFunctionId() +":"+ rule.getId();


        // 判断上报的数据是否达到了规则内的阈值
        Double dataValue = Double.valueOf(deviceData.getDataValue());  //60
        Double value = rule.getValue(); //65
        // (x,y) x=y 返回0  x>y 返回1  x<y 返回-1
        int compare = NumberUtil.compare(dataValue, value);
        // 操作符
        if((rule.getOperator().equals(">=") && compare >= 0) || (rule.getOperator().equals("<") && compare < 0)){
            System.out.println("产生了报警数据");
        }else {
            System.out.println("正常数据");
            redisTemplate.delete(triggerKey);
        }

        // 到沉默周期查数据  iotid  functionid  ruleid
        String silentKey = CacheConstants.ALERT_SILENT_PREFIX + deviceData.getIotId() +":"+ deviceData.getFunctionId() +":"+ rule.getId();
        String silentValue = redisTemplate.opsForValue().get(silentKey);
        if(StringUtils.isNotEmpty(silentValue)){
            return;
        }

        // 持续周期，累加统计数
        String triggerCount = redisTemplate.opsForValue().get(triggerKey);
        Integer count = StringUtils.isEmpty(triggerCount) ? 1 : Integer.parseInt(triggerCount) + 1;
        //判断是否达到了持续周期，达到之后，就存储报警数据，达不到，就累加值
        if(ObjectUtil.notEqual(count,rule.getDuration())){
            redisTemplate.opsForValue().set(triggerKey, count.toString());
            return;
        }

        //存储数据了  创建沉默周期，删除统计数据，
        redisTemplate.opsForValue().set(silentKey,"1",rule.getAlertSilentPeriod(), TimeUnit.MINUTES);
        redisTemplate.delete(triggerKey);
        // 保存报警数据
        insertAlertData(rule,deviceData);

    }

    @Autowired
    private IAlertDataService alertDataService;

    @Autowired
    private SysUserRoleMapper userRoleMapper;

    @Value("${alert.deviceMaintainerRole}")
    private String deviceMaintainerRole;


    @Value("${alert.managerRole}")
    private String managerRole;

    /**
     * 保存报警数据
     * @param rule
     * @param deviceData
     */
    private void insertAlertData(AlertRule rule, DeviceData deviceData) {

        List<Long> ids = new ArrayList<>();
        //找到对应的人
        if(rule.getAlertDataType().equals(0)){
            // 老人异常数据
            if(deviceData.getLocationType().equals(0)){
                // 通过老人直接可以找到护理员
                String elderId = deviceData.getAccessLocation();
               ids = alertRuleMapper.selectUserIdByElderId(elderId);

            }else if (deviceData.getLocationType().equals(1) && deviceData.getPhysicalLocationType().equals(2)){
                // 通过床位id找老人，然后再找护理员
                ids = alertRuleMapper.selectUserIdByBedId(deviceData.getAccessLocation());
            }


        }else {
            // 设备异常数据
            ids = userRoleMapper.selectUserIdByRoleName(deviceMaintainerRole);
        }

        // 都要找超级管理员
        List<Long> managerIds = userRoleMapper.selectUserIdByRoleName(managerRole);
        // 合并
        Collection<Long> allIds = CollUtil.addAll(ids, managerIds);


        // 属性拷贝
        AlertData alertData = BeanUtil.toBean(deviceData, AlertData.class);
        alertData.setId(null);
        alertData.setCreateTime(null);
        alertData.setAlertRuleId(rule.getId());
        // 状态  跟规则进行关联  报警原因  type
        alertData.setType(rule.getAlertDataType());
        alertData.setStatus(0);
        String alertReason = CharSequenceUtil.format("{}{}{},持续{}个周期就报警", rule.getFunctionName(), rule.getOperator(), rule.getValue(), rule.getDuration());
        alertData.setAlertReason(alertReason);

        List<AlertData> list = allIds.stream().map(userId -> {
            // 属性拷贝
            AlertData data = BeanUtil.copyProperties(alertData, AlertData.class);
            data.setUserId(userId);
            return data;
        }).toList();

        alertDataService.saveBatch(list);

    }

    /**
     * 查询报警规则
     * 
     * @param id 报警规则主键
     * @return 报警规则
     */
    @Override
    public AlertRule selectAlertRuleById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询报警规则列表
     * 
     * @param alertRule 报警规则
     * @return 报警规则
     */
    @Override
    public List<AlertRule> selectAlertRuleList(AlertRule alertRule)
    {
        return alertRuleMapper.selectAlertRuleList(alertRule);
    }

    /**
     * 新增报警规则
     * 
     * @param alertRule 报警规则
     * @return 结果
     */
    @Override
    public int insertAlertRule(AlertRule alertRule)
    {
        return save(alertRule)? 1 : 0;
    }

    /**
     * 修改报警规则
     * 
     * @param alertRule 报警规则
     * @return 结果
     */
    @Override
    public int updateAlertRule(AlertRule alertRule)
    {
        return updateById(alertRule)? 1 : 0;
    }

    /**
     * 批量删除报警规则
     * 
     * @param ids 需要删除的报警规则主键
     * @return 结果
     */
    @Override
    public int deleteAlertRuleByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids))? 1 : 0;
    }

    /**
     * 删除报警规则信息
     * 
     * @param id 报警规则主键
     * @return 结果
     */
    @Override
    public int deleteAlertRuleById(Long id)
    {
        return removeById(id)? 1 : 0;
    }
}
