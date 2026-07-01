package com.xhzb.nursing.service.impl;

import cn.hutool.json.JSONUtil;
import com.xhzb.nursing.domain.vo.Msg;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.messages.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Component
public class RedisChatMemoryService implements ChatMemory {

    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    private static final String PREFIX = "chat:memory:";

    @Override
    public void add(String conversationId, List<Message> messages) {
        //非空校验
        if(null == messages || messages.isEmpty()){
            return;
        }

        List<String> list = new ArrayList<>();

        //数据转换
        for (Message message : messages) {
            Msg msg = new Msg(message);
            list.add(JSONUtil.toJsonStr(msg));
        }

        // 存储到redis中
        redisTemplate.opsForList().leftPushAll(PREFIX+conversationId,list);
    }

    @Override
    public List<Message> get(String conversationId) {
        // 从redis中获取数据
        List<String> resultList = redisTemplate.opsForList().range(PREFIX + conversationId, 0, Integer.MAX_VALUE);
        if(null == resultList || resultList.isEmpty()){
            return new ArrayList<>();
        }

        //转换为Message  把字符串转换为Msg  把Msg转换为Message   按照日期排序
        return resultList.stream()
                .map(msg -> JSONUtil.toBean(msg, Msg.class))
                .sorted(Comparator.comparing(Msg::getCreateTime))
                .map(Msg::toMessage)
                .toList();
    }

    @Override
    public void clear(String conversationId) {
        redisTemplate.delete(PREFIX + conversationId);
    }
}
