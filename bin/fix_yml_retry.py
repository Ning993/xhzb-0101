# -*- coding: utf-8 -*-
"""给 application-dev.yml 添加 spring.ai.retry 限制"""
import io

f = r"D:\JavaCode\xhzb-0101\xhzb-admin\src\main\resources\application-dev.yml"
with io.open(f, "r", encoding="utf-8") as fp:
    c = fp.read()

old = (
    "    deepseek:\n"
    "      base-url: https://api.deepseek.com\n"
    "      api-key: ${DEEPSEEK_API_KEY}\n"
    "      chat:\n"
    "        options:\n"
    "          model: deepseek-chat\n"
)
add = (
    "    retry:\n"
    "      # AI 调用失败最多重试 1 次，避免占位 Key 下 401 重试风暴拖垮服务\n"
    "      max-attempts: 1\n"
)
assert old in c, "old not found"
c2 = c.replace(old, old + add, 1)
with io.open(f, "w", encoding="utf-8", newline="") as fp:
    fp.write(c2)
print("OK, retry added:", "max-attempts: 1" in c2)
