# -*- coding: utf-8 -*-
"""修正 AgeDistribution onMounted 顺序：先 init 再 setOption"""
import io
import re

f = r"D:\JavaCode\xhzb-0101\xhzb_ui\src\views\nursing\healthAssessment\components\AgeDistribution.vue"
c = io.open(f, "r", encoding="utf-8").read()

old = """onMounted(() => {
  //   baseData.value = props.allDateArr;
  //   baseTime.value = props.allTimeArr;
  setOption();
  if (!EcharRef.value) return
  // 销毁已有实例，避免内存泄漏
  if (myChart.value) {
    myChart.value.dispose()
  }
  myChart.value = echarts.init(EcharRef.value)
  // 监听窗口大小变化
  window.addEventListener('resize', resizeChart)
});"""
new = """onMounted(() => {
  if (!EcharRef.value) return
  myChart.value = echarts.init(EcharRef.value)
  //   baseData.value = props.allDateArr;
  //   baseTime.value = props.allTimeArr;
  setOption();
  // 监听窗口大小变化
  window.addEventListener('resize', resizeChart)
});"""
assert old in c, "onMounted block not found"
c = c.replace(old, new, 1)
io.open(f, "w", encoding="utf-8", newline="").write(c)
print("OK, onMounted fixed:", "myChart.value = echarts.init(EcharRef.value)\n  //   baseData" in c)
