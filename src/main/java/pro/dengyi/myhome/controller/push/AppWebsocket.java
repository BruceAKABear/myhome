package pro.dengyi.myhome.controller.push;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.utils.TokenUtil;

import javax.validation.constraints.NotBlank;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/1 17:01
 * @description：app端websocket
 * @modified By：
 */
@Component
@Slf4j
@ServerEndpoint(value = "/socket/app/{token}")
public class AppWebsocket {

    public static final AtomicInteger ONLINE_DEVICES_COUNT = new AtomicInteger(0);
    private static final ConcurrentHashMap<String, AppWebsocket> devicesInfoMaps = new ConcurrentHashMap<>();

    /**
     * 与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    private Session session;


    private User user;

    /**
     * 向应用端发送消息
     *
     * @param userId
     * @param message
     * @return
     */
    public static Boolean sendMessage2Device(@NotBlank String userId, @NotBlank String message) {
        log.info("服务端给用户:" + userId + "发送消息，消息内容为:" + message);
        boolean flag = true;
        if (StringUtils.isNotBlank(userId) && devicesInfoMaps.containsKey(userId)) {
            try {
                devicesInfoMaps.get(userId).session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                log.error(
                        "服务端给用户:" + userId + "发送消息，消息内容为:" + message + ",发送时错误，错误信息为:",
                        e);
                flag = false;
            }
        } else {
            log.error("服务端给用户:" + userId + "发送消息，消息内容为:" + message
                    + ",发送时错误，错误信息为:设备不在线");
            flag = false;
        }
        return flag;
    }

    public static Boolean sendMessage2Device(@NotBlank String message) {
        log.info("服务端批量给用户发送消息，消息内容为:" + message);
        boolean flag = true;

        devicesInfoMaps.keySet().forEach(key -> {
            try {
                devicesInfoMaps.get(key).session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                log.error(
                        "服务端给用户:" + devicesInfoMaps.get(key).user.getId() + "发送消息，消息内容为:"
                                + message + ",发送时错误，错误信息为:",
                        e);
            }
        });
        return flag;
    }

    /**
     * 连接建立成 功调用的方法
     */
    @OnOpen
    public void onOpen(Session session, @PathParam("token") String token) {
        if (!ObjectUtils.isEmpty(token)) {
            this.session = session;
            User user = TokenUtil.decToken(token);
            this.user = user;

            if (devicesInfoMaps.containsKey(user.getId())) {
                devicesInfoMaps.remove(user.getId());
                devicesInfoMaps.put(user.getId(), this);
            } else {
                devicesInfoMaps.put(user.getId(), this);
                AppWebsocket.ONLINE_DEVICES_COUNT.getAndIncrement();
            }
            log.info("移动端连接websocket,当前连接用户为:{},连接后在线用户数为:{}", this.user.getId(),
                    AppWebsocket.ONLINE_DEVICES_COUNT.get());
        }
    }

    @OnClose
    public void onClose() {
        if (devicesInfoMaps.containsKey(this.user.getId())) {
            devicesInfoMaps.remove(this.user.getId());
            AppWebsocket.ONLINE_DEVICES_COUNT.getAndDecrement();
        }
        log.info("移动端断开websocket,当前连接用户为:{},断开后在线用户数为:{}", this.user.getId(),
                AppWebsocket.ONLINE_DEVICES_COUNT.get());
    }

    /**
     * 收到客户端消 息后调用的方法
     *
     * @param message 客户端发送过来的消息
     **/
    @OnMessage
    public void onMessage(String message, Session session) {
        log.info("接收到移动端发送的消息,发送人为:{},消息内容为:{}", this.user.getId(), message);
        if (StringUtils.isNotBlank(message)) {
            if (message.equals("beat")) {
                log.info("接收到手机端心跳，用户为:{}", user);
            }

        }
    }

    /**
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        log.error("当前websocket异常，异常信息为：", error);
    }


}

