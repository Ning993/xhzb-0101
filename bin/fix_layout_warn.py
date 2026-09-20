# -*- coding: utf-8 -*-
"""修复 layout/index.vue 未定义 time/handleSubmit 的 Vue 报错"""
import io

f = r"D:\JavaCode\xhzb-0101\xhzb_ui\src\layout\index.vue"
with io.open(f, "r", encoding="utf-8") as fp:
    c = fp.read()

# 1. 模板：删除 :time 绑定（Warn 组件内部有自己的倒计时）
old1 = """  <Warn
    :visible="visibleWarn"
    :data="warnData"
    :time="time"
    @handleSubmit="handleSubmit"
    @handleClose="handleWarnClose"
  ></Warn>"""
new1 = """  <Warn
    :visible="visibleWarn"
    :data="warnData"
    @handleSubmit="handleSubmit"
    @handleClose="handleWarnClose"
  ></Warn>"""
assert old1 in c, "template warn block not found"
c = c.replace(old1, new1, 1)

# 2. script：引入 useRouter
old2 = "import useUserStore from '@/store/modules/user';"
new2 = "import useUserStore from '@/store/modules/user';\nimport { useRouter } from 'vue-router';"
assert old2 in c, "import anchor not found"
c = c.replace(old2, new2, 1)

# 3. script：补 handleSubmit（查看报警 → 关闭弹层并跳转报警数据页）
old3 = """const handleWarnClose = () => {
  visibleWarn.value = false;
};"""
new3 = """const handleWarnClose = () => {
  visibleWarn.value = false;
};
// 报警弹层"查看"：关闭弹层并跳转到报警数据页
const router = useRouter();
const handleSubmit = () => {
  visibleWarn.value = false;
  router.push('/nursing/alertData');
};"""
assert old3 in c, "handleWarnClose anchor not found"
c = c.replace(old3, new3, 1)

with io.open(f, "w", encoding="utf-8", newline="") as fp:
    fp.write(c)
print("OK: time绑定已删=%s, useRouter=%s, handleSubmit=%s" % (
    ":time=\"time\"" not in c, "useRouter" in c, "const handleSubmit" in c))
