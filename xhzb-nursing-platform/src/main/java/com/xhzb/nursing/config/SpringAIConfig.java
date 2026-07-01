package com.xhzb.nursing.config;

import com.xhzb.nursing.constants.SystemConstants;
import com.xhzb.nursing.service.impl.RedisChatMemoryService;
import com.xhzb.nursing.tools.WeatherTools;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.MessageChatMemoryAdvisor;
import org.springframework.ai.chat.client.advisor.SimpleLoggerAdvisor;
import org.springframework.ai.chat.client.advisor.vectorstore.QuestionAnswerAdvisor;
import org.springframework.ai.deepseek.DeepSeekChatModel;
import org.springframework.ai.ollama.OllamaChatModel;
import org.springframework.ai.openai.OpenAiChatModel;
import org.springframework.ai.transformer.splitter.TextSplitter;
import org.springframework.ai.transformer.splitter.TokenTextSplitter;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringAIConfig {



    @Bean
    public ChatClient chatClientByAssessment(OpenAiChatModel openAiChatModel){

        return ChatClient
                .builder(openAiChatModel)
                .defaultSystem("你在一个健康评估专家，专门用来评估老人的健康情况")
                .defaultAdvisors(new SimpleLoggerAdvisor())
                .build();
    }


    @Bean
    public ChatClient openAiChatClient(OpenAiChatModel openAiChatModel, RedisChatMemoryService redisChatMemoryService, VectorStore vectorStore){

        QuestionAnswerAdvisor questionAnswerAdvisor = QuestionAnswerAdvisor.builder(vectorStore)
                .searchRequest(SearchRequest.builder()
                        .similarityThreshold(0.7)
                        .topK(5)
                        .build())
                .build();

        return ChatClient
                .builder(openAiChatModel)
                .defaultSystem(SystemConstants.prompt)
                .defaultAdvisors(new SimpleLoggerAdvisor(),
                        MessageChatMemoryAdvisor.builder(redisChatMemoryService).build(),
                        questionAnswerAdvisor)
                .build();
    }

    @Bean
    public ChatClient ollamaChatClient(OllamaChatModel ollamaChatModel){
        return ChatClient
                .builder(ollamaChatModel)
                .build();
    }

    @Bean
    public ChatClient deepseekChatClient(DeepSeekChatModel deepSeekChatModel, WeatherTools weatherTools, RedisChatMemoryService redisChatMemoryService){
        return ChatClient
                .builder(deepSeekChatModel)
                .defaultSystem(SystemConstants.prompt)
//                .defaultTools(weatherTools)
                .defaultAdvisors(new SimpleLoggerAdvisor(), MessageChatMemoryAdvisor.builder(redisChatMemoryService).build())
                .build();
    }

    @Bean
    public TextSplitter textSplitter() {
        return TokenTextSplitter.builder()
                .withChunkSize(500)  //目标块大小  token数
                .withMinChunkSizeChars(200) // 最小块的字符数
                .withMinChunkLengthToEmbed(10) // 最小的文本字符长度
                .withMaxNumChunks(10000)  //文档最大块数
                .withKeepSeparator(false)   //不保留换行符
                .build();
    }
}
