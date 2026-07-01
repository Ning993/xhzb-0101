package com.xhzb.nursing.controller;

import com.xhzb.common.core.domain.AjaxResult;
import com.xhzb.common.utils.SecurityUtils;
import com.xhzb.nursing.domain.vo.MessageVO;
import com.xhzb.nursing.service.ChatHistoryService;
import com.xhzb.nursing.service.impl.RedisChatMemoryService;
import org.springframework.ai.chat.messages.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ai/history")
public class ChatHistoryController {

    @Autowired
    private ChatHistoryService chatHistoryService;

    @Autowired
    private RedisChatMemoryService chatMemoryService;

    @GetMapping
    public AjaxResult getChatIds(){
        //根据用户id查询
        Long userId = SecurityUtils.getUserId();
        List<String> list = chatHistoryService.getChatIds(userId);
        return AjaxResult.success(list);
    }

    @GetMapping("/{chatId}")
    public AjaxResult getChatHistory(@PathVariable String chatId){

        //从redis获取数据
        List<Message> messages = chatMemoryService.get(chatId);
        if(!messages.isEmpty()){
            List<MessageVO> list = messages.stream().map(MessageVO::new).toList();
            return AjaxResult.success(list);
        }
        return AjaxResult.success();
    }


    @DeleteMapping("/{chatId}")
    public AjaxResult deleteChatHistory(@PathVariable String chatId){

        //删除会话记录
        chatMemoryService.clear(chatId);
        // 删除会话id
        chatHistoryService.deleteChatHistory(chatId);

        return AjaxResult.success();
    }


}
