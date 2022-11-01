package pro.dengyi.myhome.interceptors;

import com.alibaba.fastjson.JSON;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.utils.TokenUtil;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/1 16:52
 * @description：websocket拦截器
 * @modified By：
 */
@Slf4j
@Component
public class WebsocketInterceptor implements HandshakeInterceptor {

  @Override
  public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
      WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
    if (request instanceof ServletServerHttpRequest) {
      HttpServletRequest servletRequest = ((ServletServerHttpRequest) request).getServletRequest();
      String token = servletRequest.getHeader("Sec-WebSocket-Protocol");
      if (ObjectUtils.isEmpty(token)) {
        //未带token拒绝连接
        return false;
      } else {
        try {
          User user = TokenUtil.decToken(token);
          log.info("用户登录websocket:{}", JSON.toJSONString(user));
        } catch (Exception e) {
          //token 异常，拒绝连接
          return false;
        }
      }
    }
    return true;
  }

  @Override
  public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
      WebSocketHandler wsHandler, Exception exception) {

  }
}
