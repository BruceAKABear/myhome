package pro.dengyi.myhome.common.aop;

import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import pro.dengyi.myhome.common.aop.annotations.NoLog;
import pro.dengyi.myhome.common.pubsub.EventType;
import pro.dengyi.myhome.common.utils.IpUtil;
import pro.dengyi.myhome.common.utils.PubSubUtil;
import pro.dengyi.myhome.common.utils.UserHolder;
import pro.dengyi.myhome.model.system.OperationLog;

import javax.servlet.http.HttpServletRequest;

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
public class LogAspect {
    @Autowired
    private PubSubUtil pubSubUtil;

    private ThreadLocal<Long> startTime = new ThreadLocal<>();

    @Pointcut("@annotation(io.swagger.annotations.ApiOperation)")
    public void apiOperationPointCut() {
    }


    @Before(value = "apiOperationPointCut()")
    public void beforeLog(JoinPoint joinPoint) {
        startTime.set(System.currentTimeMillis());
    }

    @AfterThrowing(value = "apiOperationPointCut()", throwing = "e")
    public void errorLog(JoinPoint joinPoint, Exception e) {
        ApiOperation apiOperation = ((MethodSignature) joinPoint.getSignature()).getMethod().getAnnotation(ApiOperation.class);
        NoLog noLogOnMethod = ((MethodSignature) joinPoint.getSignature()).getMethod().getAnnotation(NoLog.class);
        NoLog noLogOnClass = ((MethodSignature) joinPoint.getSignature()).getMethod().getAnnotation(NoLog.class);
        if (noLogOnMethod != null || noLogOnClass != null) {
            return;
        }

        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        String requestURI = request.getRequestURI();
        String requestMethod = request.getMethod();
        String opName = null;
        if (apiOperation != null) {
            opName = apiOperation.value();
        }
        String uIP = IpUtil.remoteIP(request);
        String uId = null;
        if (UserHolder.getUser() != null) {
            uId = UserHolder.getUser().getId();
        }
        OperationLog operationLog = new OperationLog(uId, opName, uIP, requestURI, requestMethod, false, e.getMessage(), System.currentTimeMillis() - startTime.get());
        pubSubUtil.publish(EventType.OPERATION_LOG, operationLog);


    }

    @AfterReturning(value = "apiOperationPointCut()")
    public void successLog(JoinPoint joinPoint) {
        ApiOperation apiOperation = ((MethodSignature) joinPoint.getSignature()).getMethod().getAnnotation(ApiOperation.class);
        NoLog noLogOnMethod = ((MethodSignature) joinPoint.getSignature()).getMethod().getAnnotation(NoLog.class);
        NoLog noLogOnClass = ((MethodSignature) joinPoint.getSignature()).getMethod().getAnnotation(NoLog.class);
        if (noLogOnMethod != null || noLogOnClass != null) {
            return;
        }
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        String requestURI = request.getRequestURI();
        String requestMethod = request.getMethod();
        String opName = null;
        if (apiOperation != null) {
            opName = apiOperation.value();
        }
        String uIP = IpUtil.remoteIP(request);
        String uId = null;
        if (UserHolder.getUser() != null) {
            uId = UserHolder.getUser().getId();
        }
        OperationLog operationLog = new OperationLog(uId, opName, uIP, requestURI, requestMethod, true, System.currentTimeMillis() - startTime.get());
        pubSubUtil.publish(EventType.OPERATION_LOG, operationLog);
    }

}
