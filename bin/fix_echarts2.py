# -*- coding: utf-8 -*-
"""修复健康评估图表组件：id 冲突与 ECharts 重复 init"""
import io
import re

# --- AgeDistribution：旧写法，完整修复（同 EarningsEchart 模式） ---
f1 = r"D:\JavaCode\xhzb-0101\xhzb_ui\src\views\nursing\healthAssessment\components\AgeDistribution.vue"
with io.open(f1, "r", encoding="utf-8") as fp:
    c = io.open(f1, "r", encoding="utf-8").read()

c, n1 = re.subn(r'<div id="[^"]+" ref="EcharRef"', '<div ref="EcharRef"', c, count=1)
c, n2 = re.subn(r"const chartDom = document\.getElementById\('[^']+'\)", "const chartDom = EcharRef.value", c, count=1)
c, n3 = re.subn(r"const myChart = echarts\.init\(chartDom\)", "if (!myChart.value) {\n    myChart.value = echarts.init(chartDom)\n  }", c, count=1)
c, n4 = re.subn(r"\bmyChart\.setOption\(option\)", "myChart.value.setOption(option)", c)
c, n5 = re.subn(
    r"""onMounted\(\(\) => \{\s*baseData\.value = props\.allDateArr;\s*baseTime\.value = props\.allTimeArr;\s*setOption\(\);\s*if \(!EcharRef\.value\) return\s*// 销毁已有实例，避免内存泄漏\s*if \(myChart\.value\) \{\s*myChart\.value\.dispose\(\)\s*\}\s*myChart\.value = echarts\.init\(EcharRef\.value\)\s*// 监听窗口大小变化\s*window\.addEventListener\('resize', resizeChart\)\s*\}""",
    """onMounted(() => {
  if (!EcharRef.value) return
  myChart.value = echarts.init(EcharRef.value)
  baseData.value = props.allDateArr;
  baseTime.value = props.allTimeArr;
  setOption();
  // 监听窗口大小变化
  window.addEventListener('resize', resizeChart)
})""",
    c,
    count=1,
)
if n5 == 0:
    # 宽松匹配 onMounted（忽略分号差异）
    c, n5 = re.subn(
        r"onMounted\(\(\) => \{\s*if \(!EcharRef\.value\) return\s*myChart\.value = echarts\.init\(EcharRef\.value\)",
        "onMounted(() => {\n  if (!EcharRef.value) return\n  myChart.value = echarts.init(EcharRef.value)",
        c,
        count=1,
    )
with io.open(f1, "w", encoding="utf-8", newline="") as fp:
    fp.write(c)
print("AgeDistribution: id=%d chartDom=%d init=%d setOpt=%d mounted=%d" % (n1, n2, n3, n4, n5))

# --- AgeDistribution2：仅修 id 冲突（已有 dispose 逻辑） ---
f2 = r"D:\JavaCode\xhzb-0101\xhzb_ui\src\views\nursing\healthAssessment\components\AgeDistribution2.vue"
c = io.open(f2, "r", encoding="utf-8").read()
c, m1 = re.subn(r'<div id="[^"]+" ref="EcharRef"', '<div ref="EcharRef"', c, count=1)
c, m2 = re.subn(r"const chartDom = document\.getElementById\('main'\);", "const chartDom = EcharRef.value;", c, count=1)
io.open(f2, "w", encoding="utf-8", newline="").write(c)
print("AgeDistribution2: id=%d chartDom=%d" % (m1, m2))

# --- SystemDistribution：仅修 id 冲突 ---
f3 = r"D:\JavaCode\xhzb-0101\xhzb_ui\src\views\nursing\healthAssessment\components\SystemDistribution.vue"
c = io.open(f3, "r", encoding="utf-8").read()
c, k1 = re.subn(r'<div id="[^"]+" ref="EcharRef"', '<div ref="EcharRef"', c, count=1)
c, k2 = re.subn(r"const chartDom = document\.getElementById\('main1'\);", "const chartDom = EcharRef.value;", c, count=1)
io.open(f3, "w", encoding="utf-8", newline="").write(c)
print("SystemDistribution: id=%d chartDom=%d" % (k1, k2))
