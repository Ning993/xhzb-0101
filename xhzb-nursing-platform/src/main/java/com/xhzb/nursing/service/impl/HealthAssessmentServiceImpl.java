package com.xhzb.nursing.service.impl;

import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import cn.hutool.json.JSON;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.xhzb.common.exception.base.BaseException;
import com.xhzb.common.utils.DateUtils;
import com.xhzb.common.utils.PDFUtil;
import com.xhzb.common.utils.SecurityUtils;
import com.xhzb.common.utils.StringUtils;
import com.xhzb.nursing.domain.HealthAssessmentDataCollection;
import com.xhzb.nursing.domain.HealthAssessmentReport;
import com.xhzb.nursing.domain.dto.health.ElderAssessmentDto;
import com.xhzb.nursing.service.IHealthAssessmentDataCollectionService;
import com.xhzb.nursing.service.IHealthAssessmentReportService;
import com.xhzb.oss.client.OSSAliyunFileStorageService;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xhzb.nursing.mapper.HealthAssessmentMapper;
import com.xhzb.nursing.domain.HealthAssessment;
import com.xhzb.nursing.service.IHealthAssessmentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.Map;

/**
 * 健康评估记录Service业务层处理
 *
 * @author ruoyi
 * @date 2026-04-01
 */
@Service
public class HealthAssessmentServiceImpl extends ServiceImpl<HealthAssessmentMapper, HealthAssessment> implements IHealthAssessmentService {
    @Autowired
    private HealthAssessmentMapper healthAssessmentMapper;

    /**
     * 查询健康评估记录
     *
     * @param id 健康评估记录主键
     * @return 健康评估记录
     */
    @Override
    public HealthAssessmentDataCollection selectHealthAssessmentById(Long id) {
        return healthAssessmentDataCollectionService.getById(id);
    }

    /**
     * 查询健康评估记录列表
     *
     * @param healthAssessment 健康评估记录
     * @return 健康评估记录
     */
    @Override
    public List<HealthAssessment> selectHealthAssessmentList(HealthAssessment healthAssessment) {
        return healthAssessmentMapper.selectHealthAssessmentList(healthAssessment);
    }

    @Autowired
    private IHealthAssessmentDataCollectionService healthAssessmentDataCollectionService;

    /**
     * 新增健康评估记录
     *
     * @param dto 健康评估记录
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long insertHealthAssessment(ElderAssessmentDto dto) {
        return saveOrUpdateHealthAssessment(dto);
    }

    /**
     * 新增或修改健康评估记录
     *
     * @param dto
     * @return
     */
    private Long saveOrUpdateHealthAssessment(ElderAssessmentDto dto) {
        // health_assessment  health_assessment_data_collection  这两个表的主键是同一个
        HealthAssessment healthAssessment = new HealthAssessment();
        // 判断状态
        if (dto.getId() != null) {
            HealthAssessment ha = getById(dto.getId());
            if (!ha.getEvaluationProgress().equals(0)) {
                throw new BaseException("评估进度已完成或已取消，不能评估");
            }
            //赋值操作
            healthAssessment = ha;
        } else {
            healthAssessment.setCoreSuggestion(null);
            healthAssessment.setCheckInStatus(0);
            healthAssessment.setEvaluationProgress(0);//  0 评估中 1  已完成
        }
        healthAssessment.setElderName(dto.getBasicInfo().getElderName());
        healthAssessment.setIdCard(dto.getBasicInfo().getIdCard());

        // 保存成功之后，会主键返回
        saveOrUpdate(healthAssessment);


        // 保存采集表
        HealthAssessmentDataCollection healthAssessmentDataCollection = new HealthAssessmentDataCollection();
        healthAssessmentDataCollection.setId(healthAssessment.getId());
        healthAssessmentDataCollection.setBasicInfo(JSONUtil.toJsonStr(dto.getBasicInfo()));
        healthAssessmentDataCollection.setHealthAssessment(JSONUtil.toJsonStr(dto.getHealthAssessmentDto()));
        healthAssessmentDataCollection.setDailyLivingActivities(JSONUtil.toJsonStr(dto.getDailyLivingActivities()));
        healthAssessmentDataCollection.setMentalState(JSONUtil.toJsonStr(dto.getMentalState()));
        healthAssessmentDataCollection.setPerceptionCommunication(JSONUtil.toJsonStr(dto.getPerceptionAndCommunication()));
        healthAssessmentDataCollection.setSocialParticipation(JSONUtil.toJsonStr(dto.getSocialParticipation()));

        healthAssessmentDataCollectionService.saveOrUpdate(healthAssessmentDataCollection);

        return healthAssessment.getId();
    }

    /**
     * 修改健康评估记录
     *
     * @param dto 健康评估记录
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long updateHealthAssessment(ElderAssessmentDto dto) {
        return saveOrUpdateHealthAssessment(dto);
    }

    /**
     * 批量删除健康评估记录
     *
     * @param ids 需要删除的健康评估记录主键
     * @return 结果
     */
    @Override
    public int deleteHealthAssessmentByIds(Long[] ids) {
        return removeByIds(Arrays.asList(ids)) ? 1 : 0;
    }

    /**
     * 删除健康评估记录信息
     *
     * @param id 健康评估记录主键
     * @return 结果
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteHealthAssessmentById(Long id) {
        healthAssessmentDataCollectionService.removeById(id);
        healthAssessmentReportService.remove(Wrappers.<HealthAssessmentReport>lambdaQuery()
                .eq(HealthAssessmentReport::getHealthAssessmentId, id));
        return removeById(id) ? 1 : 0;
    }

    /**
     * 取消健康评估
     * @param id
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public int cancel(Long id) {
        HealthAssessment healthAssessment = getById(id);
        if (null == healthAssessment) {
            throw new BaseException("数据不存在，不能取消");
        }
        healthAssessment.setEvaluationProgress(2);
        return updateById(healthAssessment) ? 1 : 0;
    }

    @Autowired
    private ChatClient chatClientByAssessment;

    @Autowired
    private IHealthAssessmentReportService healthAssessmentReportService;

    /**
     * 健康评估数据
     *
     * @param dto
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Long assessmentData(ElderAssessmentDto dto) {

        //保存或修改
        Long id = saveOrUpdateHealthAssessment(dto);
        // - 日常生活活动分级：0
        String abilityRating = dto.getDailyLivingActivities().getAbilityRating();
        // - 精神状态分级：0
        String mentalStateRating = dto.getMentalState().getAbilityRating();
        // - 感知觉与沟通分级：0
        String perceptionAndCommunicationRating = dto.getPerceptionAndCommunication().getAbilityRating();
        // - 社会参与分级：1
        String socialParticipationRating = dto.getSocialParticipation().getAbilityRating();
        // - 跌倒次数：0
        Integer fall = dto.getHealthAssessmentDto().getRecent30Days().getFall();
        // - 噎食次数：0
        Integer choking = dto.getHealthAssessmentDto().getRecent30Days().getChoking();
        // - 自杀次数：0
        Integer suicide = dto.getHealthAssessmentDto().getRecent30Days().getSuicideAttempt();
        // - 走失次数：0
        Integer lost = dto.getHealthAssessmentDto().getRecent30Days().getLost();
        // - 昏迷次数：0
        Integer coma = dto.getHealthAssessmentDto().getRecent30Days().getComa();
        // - 痴呆疾病：0
        String dementia = dto.getHealthAssessmentDto().getDiseaseDiagnosis().getDementia();
        // - 精神疾病：0
        String mentalIllness = dto.getHealthAssessmentDto().getDiseaseDiagnosis().getMentalIllness();
        //- 是否确诊为认知障碍：(0 正常  1  错误   2 确诊为认知障碍)
        Integer result = dto.getMentalState().getClockDrawingTest().getResult();

        String cognitiveImpairment = "无";
        if(result == 2){
            cognitiveImpairment = "确诊为认知障碍";
        }
        //提示词
        String prompt = getAbilityPrompt(abilityRating, mentalStateRating, perceptionAndCommunicationRating, socialParticipationRating, fall, choking, suicide, lost, coma, dementia, mentalIllness, cognitiveImpairment);
        String assessmentResult = chatClientByAssessment.prompt().user(prompt).call().content();
        System.out.println(assessmentResult);
        if(StringUtils.isEmpty(assessmentResult)){
            throw new BaseException("AI分析结果为空");
        }
        //替换markdown语法
        assessmentResult = assessmentResult.replaceAll("```json","").replaceAll("```","");
        //获取解析结果
        JSONObject jsonObject = JSONUtil.parseObj(assessmentResult);
        String preLevel = jsonObject.getStr("preLevel");
        String finalLevel = jsonObject.getStr("finalLevel");
        String reason = jsonObject.getStr("reason");
        System.out.println("preLevel:" + preLevel + ", finalLevel:" + finalLevel + ", reason:" + reason);


        // 老人体检报告AI分析
        String healthPrompt = getHealthPrompt(dto.getHealthAssessmentDto().getRecent30Days().getMedicalReport());
        String healthResult = chatClientByAssessment.prompt().user(healthPrompt).call().content();
        if(StringUtils.isEmpty(healthResult)){
            throw new BaseException("AI分析结果为空");
        }
        //替换markdown语法
        healthResult = healthResult.replaceAll("```json","").replaceAll("```","");
        JSONObject healthJsonObj = JSONUtil.parseObj(healthResult);

        //保存分析后的报表信息
        HealthAssessmentReport report = new HealthAssessmentReport();
        report.setHealthAssessmentId(id);
        report.setAssessmentTime(LocalDateTime.now());
        report.setAssessorName(SecurityUtils.getUsername());
        report.setMentalStatusLevel(mentalStateRating); // 精神状态等级
        report.setPerceptionCommunicationLevel(perceptionAndCommunicationRating); // 感知觉与沟通等级
        report.setSocialParticipationLevel(socialParticipationRating); // 社会参与等级
        report.setDailyActivityLevel(abilityRating);
        report.setInitialAbilityLevel(preLevel); // 初步能力等级
        report.setFinalAbilityLevel(finalLevel);
        report.setLevelChangeReason(reason);
        report.setCheckInStatus(0);

        // 获取分值
        Double healthScore = healthJsonObj.getDouble("healthScore");
        //核心建议
        if(healthScore >= 60){
            report.setCoreSuggestion(1);
        }else {
            report.setCoreSuggestion(0);
        }
        report.setHealthScore(healthScore+"");
        report.setRiskLevel(healthJsonObj.getStr("riskLevel"));
        report.setReportSummary(healthJsonObj.getStr("summarize"));
        report.setAbnormalAnalysis(JSONUtil.toJsonStr(healthJsonObj.get("abnormalData")));
        report.setSystemScore(JSONUtil.toJsonStr(healthJsonObj.get("systemScore")));

        healthAssessmentReportService.save(report);

        //修改  healthAssessment  评估状态为已完成  核心建议
        LambdaUpdateWrapper<HealthAssessment> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.eq(HealthAssessment::getId, id);
        updateWrapper.set(HealthAssessment::getCoreSuggestion,report.getCoreSuggestion());
        updateWrapper.set(HealthAssessment::getEvaluationProgress,1);
        update(updateWrapper);


        return id;
    }

    @Autowired
    private OSSAliyunFileStorageService fileStorageService;

    /**
     * 获取老人体检报告AI分析
     * @param medicalReport
     * @return
     */
    private String getHealthPrompt(String medicalReport) {

        //下载体检报告
        InputStream inputStream = fileStorageService.download(medicalReport);
        if(inputStream == null){
            throw new BaseException("体检报告不存在");
        }
        //读取PDF内容
        String content = PDFUtil.pdfToString(inputStream);

        String prompt = """
                请以一个专业医生的视角来分析这份体检报告，报告中包含了一些异常数据，我需要您对这些数据进行解读，并给出相应的健康建议。
                体检内容如下：
                %s
                要求：
                1. 提取体检报告中的“总检日期”；
                2. 通过临床医学、疾病风险评估模型和数据智能分析，给该用户的风险等级和健康指数给出结果。风险等级分为：健康、提示、风险、危险、严重危险。健康指数范围为0至100分；
                3. 对于体检报告有异常数据，请列出（异常数据的结论、体检项目名称、检查结果、参考值、单位、异常解读、建议）这8字段。解读异常数据，解决这些数据可能代表的健康问题或风险。分析可能的原因，包括但不限于生活习惯、饮食习惯、遗传因素等。基于这些异常数据和可能的原因，请给出具体的健康建议，包括饮食调整、运动建议、生活方式改变以及是否需要进一步检查或治疗等。
                结论格式：异常数据的结论：肥胖，体检项目名称：体重指数BMI，检查结果：29.2，参考值>24，单位：-。异常解读：体重超标包括超重与肥胖。体重指数（BMI）=体重（kg）/身⾼（m）的平⽅，BMI≥24为超重，BMI≥28为肥胖；男性腰围≥90cm和⼥性腰围≥85cm为腹型肥胖。体重超标是⼀种由多因素（如遗传、进⻝油脂较多、运动少、疾病等）引起的慢性代谢性疾病，尤其是肥胖，已经被世界卫⽣组织列为导致疾病负担的⼗⼤危险因素之⼀。AI建议：采取综合措施预防和控制体重，积极改变⽣活⽅式，宜低脂、低糖、⾼纤维素膳⻝，多⻝果蔬及菌藻类⻝物，增加有氧运动。若有相关疾病（如⾎脂异常、⾼⾎压、糖尿病等）应积极治疗。
                4. 根据这个体检报告的内容，分别是给人体的8大系统打分，每项满分为100分，8大系统分别为：呼吸系统、消化系统、内分泌系统、免疫系统、循环系统、泌尿系统、运动系统、感官系统
                5. 给体检报告做一个总结，总结格式：体检报告中尿蛋⽩、癌胚抗原、⾎沉、空腹⾎糖、总胆固醇、⽢油三酯、低密度脂蛋⽩胆固醇、⾎清载脂蛋⽩B、动脉硬化指数、⽩细胞、平均红细胞体积、平均⾎红蛋⽩共12项指标提示异常，尿液常规共1项指标处于临界值，⾎脂、⾎液常规、尿液常规、糖类抗原、⾎清酶类等共43项指标提示正常，综合这些临床指标和数据分析：肾脏、肝胆、⼼脑⾎管存在隐患，其中⼼脑⾎管有“⾼危”⻛险；肾脏部位有“中危”⻛险；肝胆部位有“低危”⻛险。
                
                # 输出要求：
                最后，将以上结果输出为纯JSON格式，不要包含其他的文字说明，也不要出现Markdown语法相关的文字，所有的返回结果都是json，注意双引号的单引号的配合使用，详细格式如下：
                
                {
                  "healthScore": XX.XX,
                  "riskLevel": "健康|提示|风险|危险|严重危险",
                  "abnormalData": [
                    {
                      "conclusion": "异常数据的结论",
                      "examinationItem": "体检项目名称",
                      "result": "检查结果",
                      "referenceValue": "参考值",
                      "unit": "单位",
                      "interpret":"对于异常的结论进一步详细的说明",
                      "advice":"针对于这一项的异常，给出一些健康的建议"
                    }
                  ],
                  "systemScore": {
                    "breathingSystem": XX,
                    "digestiveSystem": XX,
                    "endocrineSystem": XX,
                    "immuneSystem": XX,
                    "circulatorySystem": XX,
                    "urinarySystem": XX,
                    "motionSystem": XX,
                    "senseSystem": XX
                  },
                  "summarize": "体检报告的总结"
                }
                """;
        return prompt.formatted(content);
    }

    private static String getAbilityPrompt(String abilityRating, String mentalStateRating, String perceptionAndCommunicationRating, String socialParticipationRating, Integer fall, Integer choking, Integer suicide, Integer lost, Integer coma, String dementia, String mentalIllness, String cognitiveImpairment) {
        String prompt = """
                ## 老人评估的的信息：
                - 日常生活活动分级：%s
                - 精神状态分级：%s
                - 感知觉与沟通分级：%s
                - 社会参与分级：%s
                - 跌倒次数：%s
                - 噎食次数：%s
                - 自杀次数：%s
                - 走失次数：%s
                - 昏迷次数：%s
                - 痴呆疾病：%s
                - 精神疾病：%s
                - 是否确诊为认知障碍：%s
                
                ## 评估规则1：
                - 能力完好：
                    日常生活活动、精神状态、感知觉与沟通分级均为0，社会参与分级为0或1
                - 轻度失能：
                    日常生活活动分级为0，但精神状态、感知觉与沟通中至少一项分级为1及以上，或社会参与的分级为2；
                    或日常生活活动分级为1，精神状态、感知觉与沟通、社会参与中至少有一项的分级为0或1
                - 中度失能：
                    日常生活活动分级为1，但精神状态、感知觉与沟通、社会参与均为2，或有一项为3；
                    或日常生活活动分级为2，且精神状态、感知觉与沟通、社会参与中有1-2项的分级为1或2
                - 重度失能：
                    日常生活活动的分级为3；
                    或日常生活活动、精神状态、感知觉与沟通、社会参与分级均为2；
                    或日常生活活动分级为2，且精神状态、感知觉与沟通、社会参与中至少有一项分级为3
                
                ## 评估原则2：
                1.有认知障碍/痴呆、精神疾病者，在原有能力级别上提高一个等级；
                2.近30天内发生过2次及以上跌倒、噎食、自杀、走失者，在原有能力级别上提高一个等级；
                3.处于昏迷状态者，直接评定为重度失能；
                4.若初步等级确定为“3重度失能”，则不考虑上述1-3中各情况对最终等级的影响，等级不再提高
                
                ## 匹配规则
                1. 请根据老人的评估信息与规则1逐条进行比对，判断老人属于哪一种能力
                2. 然后拿老人的评估信息逐条与规则2进行比对，再次判断老人属于哪一种能力。
                3. 如果两次评级不一样，升级的理由是什么，理由只需要填写评估原则2 的一条或多条内容，把内容输出到reason中，不需要说明分析理由
                4. 结合评估的原则，给出老人的两次评级，不需要输出分析过程，只需要输出json格式，不要出现markdown语法
                格式为：
                {{
                    "preLevel": "能力完好|轻度失能|中度失能|重度失能",
                    "finalLevel": "能力完好|轻度失能|中度失能|重度失能",
                    "reason":"评估原则2中一条或多条"
                }}
                
                """;

        prompt = prompt.formatted(abilityRating, mentalStateRating, perceptionAndCommunicationRating, socialParticipationRating, fall, choking, suicide, lost, coma, dementia, mentalIllness, cognitiveImpairment);
        return prompt;
    }

    /**
     * 查询老人详情
     * @param id
     * @return
     */
    @Override
    public Map<String, Object> getElderInfoById(Long id) {

        Map<String, Object> resultMap = new HashMap<>();

        // 查询主表 healthAssessment
        HealthAssessment healthAssessment = getById(id);
        resultMap.put("coreSuggestion",healthAssessment.getCoreSuggestion());
        resultMap.put("name",healthAssessment.getElderName());
        resultMap.put("idCardNo",healthAssessment.getIdCard());

        // 查询采集表 healthAssessmentDataColection
        // select basic_info from xxxx
        HealthAssessmentDataCollection healthAssessmentDataCollection = healthAssessmentDataCollectionService.getOne(Wrappers.<HealthAssessmentDataCollection>lambdaQuery()
                .eq(HealthAssessmentDataCollection::getId, id)
                .select(HealthAssessmentDataCollection::getBasicInfo)
        );
        if(healthAssessmentDataCollection != null && !healthAssessmentDataCollection.getBasicInfo().isEmpty()){
            String basicInfoStr = healthAssessmentDataCollection.getBasicInfo();
            JSONObject jsonObject = JSONUtil.parseObj(basicInfoStr);

            resultMap.put("phone",jsonObject.getStr("elderContact"));

            resultMap.put("medicalPaymentMethod",jsonObject.getStr("medicalPaymentMethod"));
            resultMap.put("nation",jsonObject.getStr("nation"));
            resultMap.put("educationLevel",jsonObject.getStr("educationLevel"));
            resultMap.put("socialSecurityCard",jsonObject.getStr("socialSecurityCard"));
            resultMap.put("livingSituation",jsonObject.getStr("livingSituation"));
            resultMap.put("religiousBelief",jsonObject.getStr("religiousBelief"));
            resultMap.put("economicSource",jsonObject.getStr("economicSource"));
            resultMap.put("maritalStatus",jsonObject.getStr("maritalStatus"));

        }

        return resultMap;
    }
}
