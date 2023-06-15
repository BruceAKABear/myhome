package pro.dengyi.myhome.common.aop;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import pro.dengyi.myhome.common.exception.IpRestrictException;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * 10.0.0.0 - 10.255.255.255 ; 172.16.0.0 - 172.31.255.255 ; 192.168.0.0 - 192.168.255.255 ;
 * <p>
 * 如果使用了代理才最终访问到服务器，代理需要设置 X-Forwarded-For 头
 * <p>
 * nginx的设置为： location / {  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; }
 *
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/3/13 15:28
 * @description：ip restrict aspect
 * @modified By：
 */
@Component
@Aspect
@Slf4j
public class IpRestrictAspect {

    @Pointcut("@annotation(pro.dengyi.myhome.common.aop.annotations.IpRestrict)")
    public void ipRestrictPointCut() {
    }

    @Before(value = "ipRestrictPointCut()")
    public void doRestrict(JoinPoint joinPoint) {
        // 获取RequestAttributes
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        // 从获取RequestAttributes中获取HttpServletRequest的信息
        HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference(
                RequestAttributes.REFERENCE_REQUEST);
        String sourceIp;
        if (request != null) {
            String clientIp = request.getHeader("X-Forwarded-For");
            if (ObjectUtils.isEmpty(clientIp)) {
                sourceIp = request.getRemoteAddr();
            } else {
                sourceIp = clientIp;
            }
            try {
                InetAddress inetAddress = InetAddress.getByName(sourceIp);
                if (!inetAddress.isSiteLocalAddress()) {
                    log.error("device ip:" + sourceIp + "is not private IP address");
                    throw new IpRestrictException("not private IP address");
                }
            } catch (UnknownHostException e) {
                log.error("UnknownHostException");
                throw new IpRestrictException("not private IP address");
            }
        } else {
            //使用某些测试框架或在非常低级别的HTTP服务器上运行Spring应用程序时，HttpServletRequest对象可能为空。
            log.error("特殊原因出现,request为空");
            throw new RuntimeException("request can not be null");
        }
    }
}
