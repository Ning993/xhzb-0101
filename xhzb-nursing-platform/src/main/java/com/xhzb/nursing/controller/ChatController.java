package com.xhzb.nursing.controller;


import com.xhzb.common.utils.SecurityUtils;
import com.xhzb.nursing.service.ChatHistoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@Slf4j
@RestController
@RequestMapping("/ai")
public class ChatController {

    @Autowired
    private ChatClient openAiChatClient;


    @Autowired
    private ChatHistoryService chatHistoryService;


    @RequestMapping(value = "/chat",produces = "text/html;charset=utf-8")
    public Flux<String> chat(String prompt,String chatId){

        //保存会话id  根据用户保存
        Long userId = SecurityUtils.getUserId();
        log.info("当前登录人的Id:{}",userId);

        chatHistoryService.saveChatHistory(userId, chatId);

        return openAiChatClient
                .prompt()
                .user(prompt)
                .advisors(a->a.param(ChatMemory.CONVERSATION_ID,chatId))
                .stream()
                .content()
                .onErrorResume(e -> {
                    log.error("AI对话调用失败，已降级返回: {}", e.getMessage());
                    return Flux.just("【AI服务暂不可用】当前 AI 服务调用失败（可能是未配置有效的 API Key 或网络异常），请检查配置后重试。");
                });
    }
}
