# -*- coding: utf-8 -*-
"""SecurityConfig 放行 WebSocket 路径 /ws/**"""
import io

f = r"D:\JavaCode\xhzb-0101\xhzb-framework\src\main\java\com\xhzb\framework\config\SecurityConfig.java"
with io.open(f, "r", encoding="utf-8") as fp:
    c = fp.read()

old = 'requests.requestMatchers("/login", "/register", "/captchaImage", "/member/**", "/ai/chat").permitAll()'
new = 'requests.requestMatchers("/login", "/register", "/captchaImage", "/member/**", "/ai/chat", "/ws/**").permitAll()'
assert old in c, "not found"
c = c.replace(old, new, 1)
with io.open(f, "w", encoding="utf-8", newline="") as fp:
    fp.write(c)
print("OK, /ws/** permitted:", "/ws/**" in c)
