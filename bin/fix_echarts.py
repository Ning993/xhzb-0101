# -*- coding: utf-8 -*-
"""修复 dashboard 图表组件：id 冲突 / ECharts 重复 init / props 类型"""
import io
import re

files = [
    r"D:\JavaCode\xhzb-0101\xhzb_ui\src\views\dashboard\components\EarningsEchart.vue",
    r"D:\JavaCode\xhzb-0101\xhzb_ui\src\views\dashboard\components\EnterEchart.vue",
    r"D:\JavaCode\xhzb-0101\xhzb_ui\src\views\dashboard\components\ServeEchart.vue",
]

for f in files:
    with io.open(f, "r", encoding="utf-8") as fp:
        c = fp.read()
    name = f.split("\\")[-1]

    # A. 模板：移除 id（保留 ref）
    c, n1 = re.subn(r'<div id="[^"]+" ref="EcharRef"', '<div ref="EcharRef"', c, count=1)

    # B. chartDom 改用组件 ref
    c, n2 = re.subn(
        r"const chartDom = document\.getElementById\('[^']+'\)",
        "const chartDom = EcharRef.value",
        c,
        count=1,
    )

    # C. setOption 内复用 myChart.value，不重复 init
    c, n3 = re.subn(
        r"const myChart = echarts\.init\(chartDom\)",
        "if (!myChart.value) {\n    myChart.value = echarts.init(chartDom)\n  }",
        c,
        count=1,
    )

    # D. setOption 内调用改 myChart.value
    c, n4 = re.subn(r"\bmyChart\.setOption\(option\)", "myChart.value.setOption(option)", c)

    # E. onMounted 重排：先 init 再 setOption
    # EarningsEchart 版（带分号与 dispose 分支）
    c, n5 = re.subn(
        r"""onMounted\(\(\)=>\{\s*baseData\.value = props\.allDateArr;\s*baseTime\.value = props\.allTimeArr;\s*setOption\(\);\s*if \(!EcharRef\.value\) return\s*// 销毁已有实例，避免内存泄漏\s*if \(myChart\.value\) \{\s*myChart\.value\.dispose\(\)\s*\}\s*myChart\.value = echarts\.init\(EcharRef\.value\)\s*// 监听窗口大小变化\s*window\.addEventListener\('resize', resizeChart\)\s*\}""",
        """onMounted(()=>{
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
    # 通用版（无分号/无 dispose 注释）
    if n5 == 0:
        c, n5 = re.subn(
            r"""onMounted\(\(\)=>\{\s*baseData\.value = props\.allDateArr;\s*baseTime\.value = props\.allTimeArr;\s*setOption\(\);\s*if \(!EcharRef\.value\) return\s*myChart\.value = echarts\.init\(EcharRef\.value\)\s*// 监听窗口大小变化\s*window\.addEventListener\('resize', resizeChart\)\s*\}""",
            """onMounted(()=>{
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

    # F. props allDateArr 类型兼容对象
    c, n6 = re.subn(
        r"allDateArr: \{\s*type: Array,\s*default: \(\) => \[\]\s*\}",
        "allDateArr: {\n    type: [Array, Object],\n    default: () => []\n  }",
        c,
        count=1,
    )
    # 分号版
    c, n7 = re.subn(
        r"allDateArr: \{\s*type: Array,\s*default: \(\) => \[\],\s*\}",
        "allDateArr: {\n    type: [Array, Object],\n    default: () => [],\n  }",
        c,
        count=1,
    )

    with io.open(f, "w", encoding="utf-8", newline="") as fp:
        fp.write(c)
    print("%s: id=%d chartDom=%d initReuse=%d setOption=%d mounted=%d props=%d/%d" % (
        name, n1, n2, n3, n4, n5, n6, n7))
