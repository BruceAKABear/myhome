package pro.dengyi.myhome.common.interceptors;

import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import pro.dengyi.myhome.common.aop.annotations.NoLog;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.common.config.properties.SystemProperties;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.common.pubsub.EventType;
import pro.dengyi.myhome.common.utils.*;
import pro.dengyi.myhome.common.utils.queue.OperationLogQueue;
import pro.dengyi.myhome.dao.PermissionFunctionDao;
import pro.dengyi.myhome.model.system.OperationLog;
import pro.dengyi.myhome.model.system.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.*;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/8/30 16:08
 * @description：this is the main myhome framework intercepter, in order to control main permission
 * and
 * @modified By：
 */
@Slf4j
@Component
public class FrameworkInterceptor implements HandlerInterceptor {

    @Autowired
    private PermissionFunctionDao permissionFunctionDao;
    @Autowired
    private SystemProperties systemProperties;
    @Autowired
    private PubSubUtil pubSubUtil;


    private final String[] EXCLUDE_URIS = {"/device/deviceLogin","/device/emqHook"};


    /**
     * 1. 通用参数封装
     * <p>
     * 2. 登录状态校验
     * <p>
     * 3. 权限校验
     *
     * @param request  current HTTP request
     * @param response current HTTP response
     * @param handler  chosen handler to execute, for type and/or instance evaluation
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        //限流  排除掉不需要限流的URI
        if (!Arrays.asList(EXCLUDE_URIS).contains(request.getRequestURI())) {
            Boolean acquireFlag = IpRateLimiter.tryAcquire(IpUtil.remoteIP(request), request.getRequestURI());
            if (!acquireFlag) {
                throw new BusinessException(100, "rete limit");
            }
        }

        //通过状态
        boolean throughFlag = true;
        if (handler instanceof HandlerMethod) {
            //封装开始请求时间
            ProcessTimeUtil.mark();
            //封装语言选项
            handleLanguage(request);
            String token = request.getHeader("token");
            Method method = ((HandlerMethod) handler).getMethod();
            Permission permissionInMethod = method.getAnnotation(Permission.class);
            Permission permissionInClass = method.getDeclaringClass().getAnnotation(Permission.class);
            if (permissionInMethod != null || permissionInClass != null) {
                validatePermission(token,
                        permissionInMethod == null ? permissionInClass : permissionInMethod, method, request);
            }

        }
        return throughFlag;
    }


    /**
     * 操作日志方法
     *
     * @param method
     * @param token
     * @param request
     */
    private void handleOpLog(Method method, String token, HttpServletRequest request) {
        ApiOperation apiOperation = method.getAnnotation(ApiOperation.class);
        NoLog noLogOnMethod = method.getAnnotation(NoLog.class);
        NoLog noLogOnClass = method.getDeclaringClass().getAnnotation(NoLog.class);
        //if no swagger annotation or hava no log annotation do need to do real log logic
        if (apiOperation == null || noLogOnMethod != null || noLogOnClass != null) {
            return;
        }

        String requestURI = request.getRequestURI();
        String requestMethod = request.getMethod();
        String opName = null;
        if (apiOperation != null) {
            opName = apiOperation.value();
        }
        String uIP = IpUtil.remoteIP(request);
        String uId = null;
        if (!ObjectUtils.isEmpty(token)) {
            try {
                User user = TokenUtil.decToken(token);
                uId = user.getId();
            } catch (Exception e) {
                //token异常了
                log.error("日记记录时用户token异常");
            }
        }
        OperationLog operationLog = new OperationLog(uId, opName, uIP, requestURI, requestMethod);
        OperationLogQueue.publish(operationLog);
    }

    /**
     * 封装多语言
     *
     * @param request
     */
    private void handleLanguage(HttpServletRequest request) {
        String lang = request.getHeader("lang");
        if (ObjectUtils.isEmpty(lang)) {
            LocaleContextHolder.setLocale(Locale.CHINESE);
        } else {
            LocaleContextHolder.setLocale(new Locale(lang.toLowerCase()));
        }
    }

    /**
     * 校验权限方法
     *
     * @param token   登录token
     * @param method
     * @param request
     */
    private void validatePermission(String token, Permission permission, Method method,
                                    HttpServletRequest request) {
        //do log logic
        handleOpLog(method, token, request);
        String requestURI = request.getRequestURI();
        if (permission.needLogIn()) {
            //校验登录
            if (ObjectUtils.isEmpty(token)) {
                log.error("permission module>>>>>> user not login!,uri:{}", requestURI);
                throw new BusinessException(1, "未登录");
            }
            //校验token
            User user;
            try {
                user = TokenUtil.decToken(token);
            } catch (Exception e) {
                log.error("try to decode login token error,the error is:{}", e);
                throw new BusinessException(1, "token异常");
            }
            UserHolder.setUser(user);
            if (permission.needValidate()) {
                if (!user.isSuperAdmin()) {
                    //非超管，校验权限
                    List<String> permURIs = permissionFunctionDao.selecAllPermUris(user);
                    Set<String> realPermURIs = new HashSet<>();
                    permURIs.forEach(item -> {
                        realPermURIs.addAll(Arrays.asList(item.split(",")));
                    });
                    if (!realPermURIs.contains(requestURI)) {
                        //无权限
                        throw new BusinessException(1, "无权限");
                    }
                }

            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
                                Object handler, Exception ex) throws Exception {
        long processTime = ProcessTimeUtil.processTime();
        Map<String, Object> param = new HashMap<>();
        param.put("requestURI", request.getRequestURI());
        param.put("timems", processTime);
        //if open log
        if (systemProperties.getOpenProcessTimeLog()) {
            pubSubUtil.publish(EventType.API_PROCESS_TIME, param);
        }

        //todo 超时预警 一定时间内只发一条
        if (processTime >= systemProperties.getApiProcessLimitation()) {
            log.error("请求时间超过阈值");
        }
        LocaleContextHolder.resetLocaleContext();
        UserHolder.remove();
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {

        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
}
