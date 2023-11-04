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
import pro.dengyi.myhome.common.pubsub.EventTypeEnum;
import pro.dengyi.myhome.common.utils.I18nMessageUtil;
import pro.dengyi.myhome.common.utils.IpUtil;
import pro.dengyi.myhome.common.pubsub.PubAndSubService;
import pro.dengyi.myhome.common.utils.UserHolder;
import pro.dengyi.myhome.model.system.OperationLog;

import javax.servlet.http.HttpServletRequest;

@Component
@Aspect
@Slf4j
public class LogAspect {
    @Autowired
    private PubAndSubService pubAndSubService;

    private final ThreadLocal<Long> startTime = new ThreadLocal<>();

    @Pointcut("@annotation(io.swagger.annotations.ApiOperation)")
    public void apiOperationPointCut() {
    }


    @Before(value = "apiOperationPointCut()")
    public void beforeLog(JoinPoint joinPoint) {
        startTime.set(System.currentTimeMillis());
    }


    /**
     * the exception can enter this function is the business exception or basic code exception
     * the param exception is outer the function it will be handler by spring framework ,so it can not enter the
     * function
     *
     * @param joinPoint
     * @param e
     */
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
        String message = e.getMessage();
        if (message.contains(".")) {
            message = I18nMessageUtil.get(message);
        }
        OperationLog operationLog = new OperationLog(uId, opName, uIP, requestURI, requestMethod, false, message, System.currentTimeMillis() - startTime.get());
        pubAndSubService.publish(EventTypeEnum.OPERATION_LOG, operationLog);


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
        pubAndSubService.publish(EventTypeEnum.OPERATION_LOG, operationLog);
    }

}
