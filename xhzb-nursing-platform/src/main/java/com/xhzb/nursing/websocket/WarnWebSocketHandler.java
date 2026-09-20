package com.xhzb.nursing.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.List;

/**
 * 报警/通知 WebSocket 端点处理类。
 * 前端连接 ws://{host}/ws/{userId}，后端维护 userId -> session 映射，
 * 通过 {@link #sendToUser(Long, String)} 向指定用户推送报警消息。
 */
@Slf4j
public class WarnWebSocketHandler extends TextWebSocketHandler {

    /** userId -> 该用户的全部在线会话 */
    private static final Map<Long, List<WebSocketSession>> USER_SESSIONS = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        Long userId = resolveUserId(session);
        if (userId != null) {
            USER_SESSIONS.computeIfAbsent(userId, k -> new CopyOnWriteArrayList<>()).add(session);
            log.info("WebSocket 连接建立: userId={}, sessionId={}", userId, session.getId());
        } else {
            log.warn("WebSocket 连接建立失败，无法解析 userId: uri={}", session.getUri());
            session.close(CloseStatus.BAD_DATA);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        Long userId = resolveUserId(session);
        if (userId != null) {
            List<WebSocketSession> sessions = USER_SESSIONS.get(userId);
            if (sessions != null) {
                sessions.remove(session);
                if (sessions.isEmpty()) {
                    USER_SESSIONS.remove(userId);
                }
            }
        }
        log.info("WebSocket 连接关闭: sessionId={}, status={}", session.getId(), status);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 服务端暂不消费客户端上行消息，只做推送
        super.handleTextMessage(session, message);
    }

    /**
     * 向指定用户的所有在线会话推送消息。
     *
     * @param userId 用户ID
     * @param payload JSON 文本，如 {"notifyType":1,"deviceDescription":"..."}
     */
    public static void sendToUser(Long userId, String payload) {
        if (userId == null) {
            return;
        }
        List<WebSocketSession> sessions = USER_SESSIONS.get(userId);
        if (sessions == null || sessions.isEmpty()) {
            return;
        }
        TextMessage message = new TextMessage(payload);
        for (WebSocketSession session : sessions) {
            if (session.isOpen()) {
                try {
                    synchronized (session) {
                        session.sendMessage(message);
                    }
                } catch (IOException e) {
                    log.error("WebSocket 推送失败: userId={}, sessionId={}, err={}",
                            userId, session.getId(), e.getMessage());
                }
            }
        }
    }

    /** 当前在线用户数（便于排查） */
    public static int onlineCount() {
        return USER_SESSIONS.values().stream().mapToInt(List::size).sum();
    }

    /** 从 ws://host/ws/{userId} 解析 userId */
    private Long resolveUserId(WebSocketSession session) {
        if (session.getUri() == null) {
            return null;
        }
        String path = session.getUri().getPath();
        if (path == null) {
            return null;
        }
        String[] parts = path.split("/");
        if (parts.length == 0) {
            return null;
        }
        String last = parts[parts.length - 1];
        try {
            return Long.parseLong(last);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
