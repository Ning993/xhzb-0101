# -*- coding: utf-8 -*-
"""为 HealthAssessmentServiceImpl 增加 AI 调用降级保护"""
import io

f = r"D:\JavaCode\xhzb-0101\xhzb-nursing-platform\src\main\java\com\xhzb\nursing\service\impl\HealthAssessmentServiceImpl.java"
with io.open(f, "r", encoding="utf-8") as fp:
    c = fp.read()

# 1. import 加 Slf4j
c = c.replace(
    "import org.springframework.ai.chat.client.ChatClient;",
    "import lombok.extern.slf4j.Slf4j;\nimport org.springframework.ai.chat.client.ChatClient;",
    1,
)
c = c.replace(
    "@Service\npublic class HealthAssessmentServiceImpl",
    "@Slf4j\n@Service\npublic class HealthAssessmentServiceImpl",
    1,
)

# 2. 能力评估 AI 调用 + 解析 降级
old1 = """        String assessmentResult = chatClientByAssessment.prompt().user(prompt).call().content();
        System.out.println(assessmentResult);
        if(StringUtils.isEmpty(assessmentResult)){
            throw new BaseException("AI分析结果为空");
        }
        //替换markdown语法
        assessmentResult = assessmentResult.replaceAll("```json","").replaceAll("```","");
        //获取解析结果
        JSONObject jsonObject = JSONUtil.parseObj(assessmentResult);"""

new1 = """        String assessmentResult;
        try {
            assessmentResult = chatClientByAssessment.prompt().user(prompt).call().content();
            log.info("AI能力评估结果: {}", assessmentResult);
            if(StringUtils.isEmpty(assessmentResult)){
                assessmentResult = null;
            }
        } catch (Exception e) {
            log.error("AI能力评估调用失败，使用兜底评估结果", e);
            assessmentResult = null;
        }
        //替换markdown语法
        if (assessmentResult != null) {
            assessmentResult = assessmentResult.replaceAll("```json","").replaceAll("```","");
        }
        //获取解析结果
        JSONObject jsonObject;
        try {
            jsonObject = JSONUtil.parseObj(assessmentResult);
        } catch (Exception e) {
            log.error("AI能力评估结果解析失败，使用兜底评估结果", e);
            jsonObject = null;
        }
        if (jsonObject == null) {
            String fallbackLevel = abilityLevelToName(abilityRating);
            jsonObject = JSONUtil.parseObj(String.format("{\\"preLevel\\":\\"%s\\",\\"finalLevel\\":\\"%s\\",\\"reason\\":\\"AI评估服务暂不可用，采用基础能力等级\\"}", fallbackLevel, fallbackLevel));
        }"""
assert old1 in c, "old1 not found"
c = c.replace(old1, new1, 1)

# 3. 体检报告 AI 调用 + 解析 降级
old2 = """        String healthResult = chatClientByAssessment.prompt().user(healthPrompt).call().content();
        if(StringUtils.isEmpty(healthResult)){
            throw new BaseException("AI分析结果为空");
        }
        //替换markdown语法
        healthResult = healthResult.replaceAll("```json","").replaceAll("```","");
        JSONObject healthJsonObj = JSONUtil.parseObj(healthResult);"""

new2 = """        String healthResult;
        try {
            healthResult = chatClientByAssessment.prompt().user(healthPrompt).call().content();
            log.info("AI体检报告分析结果: {}", healthResult);
            if(StringUtils.isEmpty(healthResult)){
                healthResult = null;
            }
        } catch (Exception e) {
            log.error("AI体检报告分析调用失败，使用兜底结果", e);
            healthResult = null;
        }
        //替换markdown语法
        if (healthResult != null) {
            healthResult = healthResult.replaceAll("```json","").replaceAll("```","");
        }
        JSONObject healthJsonObj;
        try {
            healthJsonObj = JSONUtil.parseObj(healthResult);
        } catch (Exception e) {
            log.error("AI体检报告分析结果解析失败，使用兜底结果", e);
            healthJsonObj = null;
        }
        if (healthJsonObj == null) {
            healthJsonObj = JSONUtil.parseObj("{\\"healthScore\\":0,\\"riskLevel\\":\\"健康\\",\\"abnormalData\\":[],\\"systemScore\\":{\\"breathingSystem\\":0,\\"digestiveSystem\\":0,\\"endocrineSystem\\":0,\\"immuneSystem\\":0,\\"circulatorySystem\\":0,\\"urinarySystem\\":0,\\"motionSystem\\":0,\\"senseSystem\\":0},\\"summarize\\":\\"AI体检报告分析服务暂不可用，未生成具体分析结果\\"}");
        }"""
assert old2 in c, "old2 not found"
c = c.replace(old2, new2, 1)

# 4. 添加能力等级映射辅助方法（放在 getAbilityPrompt 前）
anchor = "    private static String getAbilityPrompt("
helper = """    private static String abilityLevelToName(String rating) {
        switch (rating == null ? "" : rating.trim()) {
            case "0": return "能力完好";
            case "1": return "轻度失能";
            case "2": return "中度失能";
            case "3": return "重度失能";
            default: return "能力完好";
        }
    }

"""
assert anchor in c, "anchor not found"
c = c.replace(anchor, helper + anchor, 1)

with io.open(f, "w", encoding="utf-8", newline="\n") as fp:
    fp.write(c)

print("OK: Slf4j=%s tryCatch1=%s tryCatch2=%s helper=%s" % (
    "lombok.extern.slf4j.Slf4j" in c,
    "AI能力评估调用失败" in c,
    "AI体检报告分析调用失败" in c,
    "abilityLevelToName" in c,
))
