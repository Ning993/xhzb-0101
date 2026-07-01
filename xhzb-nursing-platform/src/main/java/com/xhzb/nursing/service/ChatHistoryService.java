package com.xhzb.nursing.service;

import java.util.List;

public interface ChatHistoryService {
    /**
     * 保存聊天记录
     * @param userId
     * @param chatId
     */
    void saveChatHistory(Long userId, String chatId);

    /**
     * 根据用户id获取聊天记录
     * @param userId
     * @return
     */
    List<String> getChatIds(Long userId);

    /**
     * 删除聊天记录
     * @param chatId
     */
    void deleteChatHistory(String chatId);
}
