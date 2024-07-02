package com.www.config.websocket;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @Author Alin
 * @date 2024/5/25 025 10:23
 * @Description:
 */
@ServerEndpoint(value = "/im/{username}")
@Component
public class WebSocketServer {

    private static final Logger log = LoggerFactory.getLogger(WebSocketServer.class);
    public static final Map<String, Session> sessionMap = new ConcurrentHashMap<>();
    private static final Timer heartbeatTimer = new Timer();

    static {
        // 每隔5秒执行一次心跳检测任务
        heartbeatTimer.scheduleAtFixedRate(new HeartbeatTask(), 5000, 1000 * 60);
    }


    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) {
        sessionMap.put(username, session);
        log.info("有新用户加入，username={}, 当前在线人数为：{}", username, sessionMap.size());
        sendAllUsers();
    }

    @OnClose
    public void onClose(Session session, @PathParam("username") String username) {
        sessionMap.remove(username);
        log.info("有一连接关闭，移除username={}的用户session, 当前在线人数为：{}", username, sessionMap.size());
        sendAllUsers();
    }

    @OnMessage
    public void onMessage(String message, Session session, @PathParam("username") String username) {
        log.info("服务端收到用户username={}的消息:{}", username, message);
        if ("heartbeat".equals(message)) {
            log.info("收到用户{}的心跳消息", username);
            return;
        }

        JSONObject obj = JSONUtil.parseObj(message);
        String toUsername = obj.getStr("to");
        String text = obj.getStr("text");
        Session toSession = sessionMap.get(toUsername);
        if (toSession != null) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.set("from", username);
            jsonObject.set("text", text);
            sendMessage(jsonObject.toString(), toSession);
            log.info("发送给用户username={}，消息：{}", toUsername, jsonObject.toString());
        } else {
            log.info("发送失败，未找到用户username={}的session", toUsername);
        }
    }

    @OnError
    public void onError(Session session, Throwable error) {
        log.error("发生错误");
        error.printStackTrace();
    }

    private void sendMessage(String message, Session toSession) {
        try {
            log.info("服务端给客户端[{}]发送消息{}", toSession.getId(), message);
            toSession.getBasicRemote().sendText(message);
        } catch (Exception e) {
            log.error("服务端发送消息给客户端失败", e);
        }
    }

    private void sendAllUsers() {
        JSONObject result = new JSONObject();
        JSONArray array = new JSONArray();
        result.set("users", array);
        // result.set("onlineUsers", array);
        for (String key : sessionMap.keySet()) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.set("username", key);
            array.add(jsonObject);
        }
        sendAllMessage(JSONUtil.toJsonStr(result));
    }

    private void sendAllMessage(String message) {
        try {
            for (Session session : sessionMap.values()) {
                log.info("服务端给客户端[{}]发送消息{}", session.getId(), message);
                session.getBasicRemote().sendText(message);
            }
        } catch (Exception e) {
            log.error("服务端发送消息给客户端失败", e);
        }
    }

    private static class HeartbeatTask extends TimerTask {
        @Override
        public void run() {
            for (Session session : sessionMap.values()) {
                try {
                    session.getBasicRemote().sendText("heartbeat");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

}

