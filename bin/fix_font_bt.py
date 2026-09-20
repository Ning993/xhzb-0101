# -*- coding: utf-8 -*-
"""提高 .font-bt focus/hover 特异性，覆盖 Element Plus is-link 的变浅样式"""
import io

f = r"D:\JavaCode\xhzb-0101\xhzb_ui\src\assets\styles\index.scss"
with io.open(f, "r", encoding="utf-8") as fp:
    c = fp.read()

old = """  // 点击后的状态
  &:hover,&:active,&:visited{
    color: $--color-main;
  }
  // 弹窗关闭后焦点会还原到该按钮，保持主色避免变淡
  &:focus {
    color: $--color-main;
  }"""
assert old in c, "anchor not found"
new = """  // 点击后的状态
  &:hover,&:active,&:visited{
    color: $--color-main;
  }
  // 弹窗关闭后焦点会还原到该按钮，保持主色避免变淡；
  // 需提高特异性覆盖 Element Plus is-link 的 hover/focus 变浅样式
  &.el-button.is-link:hover,
  &.el-button.is-link:focus {
    color: $--color-main;
  }"""
c2 = c.replace(old, new, 1)
with io.open(f, "w", encoding="utf-8", newline="") as fp:
    fp.write(c2)

i = c2.find(".font-bt")
seg = c2[i : i + 420]
print("fixed:", "&.el-button.is-link:hover" in seg and "&.el-button.is-link:focus" in seg)
