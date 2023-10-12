package pro.dengyi.myhome.common.interceptors;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.common.enums.RequestType;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.common.response.Response;
import pro.dengyi.myhome.common.utils.*;
import pro.dengyi.myhome.dao.PermissionFunctionDao;
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
    private final String[] EXCLUDE_URIS = {"/device/deviceLogin", "/device/emqHook"};


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
        rateLimit(request);
        //通过状态
        boolean throughFlag = true;
        if (handler instanceof HandlerMethod) {
            //封装语言选项
            handleLanguage(request);
            //handle request type
            handleRequestType(request);
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

    private void handleRequestType(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        RequestType requestType = RequestType.PC;
        if (userAgent != null && userAgent.contains("Mobile")) {
            requestType = RequestType.PHONE;
        }
        RequestTypeHolder.setType(requestType);
    }

    private void rateLimit(HttpServletRequest request) {
        if (!Arrays.asList(EXCLUDE_URIS).contains(request.getRequestURI())) {
            Boolean acquireFlag = IpRateLimiter.tryAcquire(IpUtil.remoteIP(request), request.getRequestURI());
            if (!acquireFlag) {
                throw new BusinessException(Response.RATE_LIMIT_CODE, "system.rate.limit");
            }
        }
    }


    /**
     * 封装多语言
     *
     * @param request
     */
    private void handleLanguage(HttpServletRequest request) {
        String lang = request.getHeader("lang");
        if (ObjectUtils.isEmpty(lang)) {
            LocaleContextHolder.setLocale(Locale.SIMPLIFIED_CHINESE);
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
        String requestURI = request.getRequestURI();
        if (permission.needLogIn()) {
            //校验登录
            if (ObjectUtils.isEmpty(token)) {
                log.error("permission module>>>>>> user not login!,uri:{}", requestURI);
                throw new BusinessException(1, "未登录");
            }
            //校验token
            User user = UserUtil.decToken(token);

            UserHolder.setUser(user);
            if (permission.needValidate()) {
                if (!user.getSuperAdmin()) {
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
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        UserHolder.remove();
        LocaleContextHolder.resetLocaleContext();
        RequestTypeHolder.remove();
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
}
