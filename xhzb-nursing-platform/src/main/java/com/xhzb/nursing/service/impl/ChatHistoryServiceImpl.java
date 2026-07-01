package com.xhzb.nursing.service.impl;

import com.xhzb.common.utils.SecurityUtils;
import com.xhzb.nursing.service.ChatHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;
import java.util.Set;

@Service
public class ChatHistoryServiceImpl implements ChatHistoryService {

    @Autowired
    private RedisTemplate<String,String> redisTemplate;

    private static final String PREFIX = "chat:history:";

    /**
     * 保存聊天记录
     * @param userId
     * @param chatId
     */
    @Override
    public void saveChatHistory(Long userId, String chatId) {
        redisTemplate.opsForSet().add(PREFIX+userId,chatId);
    }

    /**
     * 根据用户id获取聊天记录
     * @param userId
     * @return
     */
    @Override
    public List<String> getChatIds(Long userId) {
        // 从redis中获取数据
        Set<String> members = redisTemplate.opsForSet().members(PREFIX + userId);
        return members.stream()
                .sorted(Comparator.comparing(String::toString))
                .toList();
    }

    /**
     * 删除聊天记录
     * @param chatId
     */
    @Override
    public void deleteChatHistory(String chatId) {
        redisTemplate.opsForSet().remove(PREFIX + SecurityUtils.getUserId(), chatId);
    }
}
