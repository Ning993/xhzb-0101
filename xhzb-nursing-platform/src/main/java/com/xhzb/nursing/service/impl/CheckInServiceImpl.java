package com.xhzb.nursing.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.xhzb.common.exception.base.BaseException;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.nursing.domain.*;
import com.xhzb.nursing.domain.dto.CheckInApplyDto;
import com.xhzb.nursing.domain.dto.CheckInElderDto;
import com.xhzb.nursing.domain.vo.CheckInConfigVo;
import com.xhzb.nursing.domain.vo.CheckInDetailVo;
import com.xhzb.nursing.domain.vo.CheckInElderVo;
import com.xhzb.nursing.domain.vo.ElderFamilyVo;
import com.xhzb.nursing.mapper.*;
import com.xhzb.nursing.service.IHealthAssessmentService;
import com.xhzb.nursing.util.CodeGenerator;
import com.xhzb.nursing.util.IDCardUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.service.ICheckInService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;

/**
 * 入住Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-04-02
 */
@Service
public class CheckInServiceImpl extends ServiceImpl<CheckInMapper, CheckIn> implements ICheckInService
{
    @Autowired
    private CheckInMapper checkInMapper;

    @Autowired
    private IHealthAssessmentService healthAssessmentService;

    @Autowired
    private ElderMapper elderMapper;

    @Autowired
    private BedMapper bedMapper;

    /**
     * 入住详情
     * @param id
     * @return
     */
    @Override
    public CheckInDetailVo detail(Long id) {
        CheckInDetailVo vo = new CheckInDetailVo();
        //老人相关的
        //通过id找到入住配置   拿到老人id
        CheckIn checkIn = checkInMapper.selectCheckInById(id);

        Elder elder = elderMapper.selectById(checkIn.getElderId());
        if(ObjectUtil.isNotEmpty(elder)){
            //属性拷贝
            CheckInElderVo checkInElderVo = BeanUtil.toBean(elder, CheckInElderVo.class);
            //补全年龄属性,通过身份证号来计算老人的年龄，工具类可以使用AI协助创建
            checkInElderVo.setAge(IDCardUtils.getAgeByIdCard(elder.getIdCardNo()));
            vo.setCheckInElderVo(checkInElderVo);
        }


        //入住配置
        LambdaQueryWrapper<CheckInConfig> checkInConfigWrapper = new LambdaQueryWrapper<>();
        checkInConfigWrapper.eq(CheckInConfig::getCheckInId,checkIn.getId());
        CheckInConfig checkInConfig = checkInConfigMapper.selectOne(checkInConfigWrapper);
        //属性拷贝，BeanUtil.toBean：拷贝数据并创建对象（糊涂工具提供）
        CheckInConfigVo checkInConfigVo = BeanUtil.toBean(checkInConfig, CheckInConfigVo.class);

        //补全其他属性
        checkInConfigVo.setBedNumber(checkIn.getBedNumber());
        checkInConfigVo.setStartDate(checkIn.getStartDate());
        checkInConfigVo.setEndDate(checkIn.getEndDate());

        vo.setCheckInConfigVo(checkInConfigVo);

        //合同
        LambdaQueryWrapper<Contract> contractWrapper = new LambdaQueryWrapper<>();
        contractWrapper.eq(Contract::getElderId,elder.getId());
        Contract contract = contractMapper.selectOne(contractWrapper);
        vo.setContract(contract);

        //家属列表
        String otherApplyInfo = checkIn.getRemark();
        List<ElderFamilyVo> elderFamilyVos = JSONUtil.toList(otherApplyInfo, ElderFamilyVo.class);
        vo.setElderFamilyVoList(elderFamilyVos);

        return vo;
    }

    /**
     * 入住申请
     * @param dto
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void apply(CheckInApplyDto dto) {
        // 校验老人是否做过评估
        HealthAssessment healthAssessment = healthAssessmentService.getById(dto.getHealthAssessmentId());
        if(healthAssessment == null || !healthAssessment.getEvaluationProgress().equals(1)){
            throw new BaseException("老人未做过评估或评估未完成");
        }

        // 校验老人是否已入住
        Elder elder = elderMapper.selectOne(Wrappers.<Elder>lambdaQuery()
                .eq(Elder::getIdCardNo, dto.getCheckInElderDto().getIdCardNo())
                .eq(Elder::getStatus, 1));
        if(elder != null){
            throw new BaseException("老人已入住");
        }

        // 更新床位状态
        Bed bed = bedMapper.selectBedById(dto.getCheckInConfigDto().getBedId());
        bed.setBedStatus(1);
        bedMapper.updateById(bed);

        // 新增或更新老人
        elder = saveOrUpdateElder(dto.getCheckInElderDto(), bed);

        // 新增合同
        String contractNo = "HT"+CodeGenerator.generateContractNumber();
        insertContract(elder,dto,contractNo);

        // 新增入住
        CheckIn checkIn = insertCheckIn(elder,dto);

        // 新增入住配置
        insertCheckInConfig(checkIn,dto);

        // 更新评估状态
       /* healthAssessmentService.update(Wrappers.<HealthAssessment>lambdaUpdate()
                .eq(HealthAssessment::getId, dto.getHealthAssessmentId())
                .set(HealthAssessment::getCheckInStatus,1));*/
        healthAssessment.setCheckInStatus(1);
        healthAssessment.setElderId(elder.getId());
        healthAssessmentService.updateById(healthAssessment);

    }

    @Autowired
    private CheckInConfigMapper checkInConfigMapper;

    /**
     * 新增入住配置
     * @param checkIn
     * @param dto
     */
    private void insertCheckInConfig(CheckIn checkIn, CheckInApplyDto dto) {
        //属性拷贝
        CheckInConfig checkInConfig = BeanUtil.toBean(dto.getCheckInConfigDto(), CheckInConfig.class);
        checkInConfig.setCheckInId(checkIn.getId());
        checkInConfigMapper.insert(checkInConfig);

    }

    /**
     * 新增入住
     * @param elder
     * @param dto
     * @return
     */
    private CheckIn insertCheckIn(Elder elder, CheckInApplyDto dto) {

        CheckIn checkIn = new CheckIn();
        checkIn.setElderName(elder.getName());
        checkIn.setElderId(elder.getId());
        checkIn.setIdCardNo(elder.getIdCardNo());
        checkIn.setStartDate(dto.getCheckInConfigDto().getStartDate());
        checkIn.setEndDate(dto.getCheckInConfigDto().getEndDate());
        checkIn.setStatus(0);
        checkIn.setBedNumber(elder.getBedNumber());
        checkIn.setNursingLevelName(dto.getCheckInConfigDto().getNursingLevelName());

        //家属列表，需要转换为json,装入到remark中
        checkIn.setRemark(JSONUtil.toJsonStr(dto.getElderFamilyDtoList()));

        save(checkIn);
        return checkIn;

    }

    @Autowired
    private ContractMapper contractMapper;

    private void insertContract(Elder elder, CheckInApplyDto dto, String contractNo) {
        //属性拷贝
        Contract contract = BeanUtil.toBean(dto.getCheckInContractDto(), Contract.class);
        contract.setContractNumber(contractNo);
        contract.setElderId(elder.getId());
        contract.setElderName(elder.getName());
        LocalDateTime startDate = dto.getCheckInConfigDto().getStartDate();
        LocalDateTime endDate = dto.getCheckInConfigDto().getEndDate();
        // 计算状态是否生效
        Integer status = startDate.isAfter(LocalDateTime.now()) ? 0 : 1;
        contract.setStatus(status);
        contract.setStartDate(startDate);
        contract.setEndDate(endDate);
        contractMapper.insert(contract);
    }

    /**
     *  新增或更新老人
     * @param checkInElderDto
     * @param bed
     */
    private Elder saveOrUpdateElder(CheckInElderDto checkInElderDto, Bed bed) {

        /*Elder elder = new Elder();
        BeanUtils.copyProperties(checkInElderDto,elder);*/
        Elder elder = BeanUtil.toBean(checkInElderDto, Elder.class);
        elder.setStatus(1);
        elder.setBedNumber(bed.getBedNumber());
        elder.setBedId(bed.getId());
        //查询老人
        Elder elderDb = elderMapper.selectOne(Wrappers.<Elder>lambdaQuery()
                .eq(Elder::getIdCardNo, checkInElderDto.getIdCardNo())
                .eq(Elder::getStatus, 0));
        if(elderDb != null){
            elder.setId(elderDb.getId());
            // 更新
            elderMapper.updateById(elder);
        }else {
            // 新增
            elderMapper.insert(elder);
        }

        return elder;
    }

    /**
     * 查询入住
     * 
     * @param id 入住主键
     * @return 入住
     */
    @Override
    public CheckIn selectCheckInById(Long id)
    {
        return getById(id);
    }

    /**
     * 查询入住列表
     * 
     * @param checkIn 入住
     * @return 入住
     */
    @Override
    public List<CheckIn> selectCheckInList(CheckIn checkIn)
    {
        return checkInMapper.selectCheckInList(checkIn);
    }

    /**
     * 新增入住
     * 
     * @param checkIn 入住
     * @return 结果
     */
    @Override
    public int insertCheckIn(CheckIn checkIn)
    {
        return save(checkIn)? 1 : 0;
    }

    /**
     * 修改入住
     * 
     * @param checkIn 入住
     * @return 结果
     */
    @Override
    public int updateCheckIn(CheckIn checkIn)
    {
        return updateById(checkIn)? 1 : 0;
    }

    /**
     * 批量删除入住
     * 
     * @param ids 需要删除的入住主键
     * @return 结果
     */
    @Override
    public int deleteCheckInByIds(Long[] ids)
    {
        return removeByIds(Arrays.asList(ids))? 1 : 0;
    }

    /**
     * 删除入住信息
     * 
     * @param id 入住主键
     * @return 结果
     */
    @Override
    public int deleteCheckInById(Long id)
    {
        return removeById(id)? 1 : 0;
    }
}
