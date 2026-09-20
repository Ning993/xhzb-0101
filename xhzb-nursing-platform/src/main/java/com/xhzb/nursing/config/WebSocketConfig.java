package com.xhzb.nursing.config;

import com.xhzb.nursing.websocket.WarnWebSocketHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * WebSocket 配置：注册报警推送端点 ws://{host}/ws/{userId}。
 */
@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(warnWebSocketHandler(), "/ws/{userId}")
                .setAllowedOriginPatterns("*");
    }

    @Bean
    public WarnWebSocketHandler warnWebSocketHandler() {
        return new WarnWebSocketHandler();
    }
}
