package pro.dengyi.myhome.interceptors;

import io.swagger.annotations.ApiOperation;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.dao.PermissionFunctionDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.system.OperationLog;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.utils.IpUtil;
import pro.dengyi.myhome.utils.TokenUtil;
import pro.dengyi.myhome.utils.UserHolder;
import pro.dengyi.myhome.utils.queue.OperationLogQueue;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/8/30 16:08
 * @description：框架拦截器
 * @modified By：
 */
@Slf4j
@Component
public class FrameworkInterceptor implements HandlerInterceptor {

  @Autowired
  private PermissionFunctionDao permissionFunctionDao;


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
    //通过状态
    boolean throughFlag = true;
    if (handler instanceof HandlerMethod) {

      long startTime = System.currentTimeMillis();

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

  private void handleOpLog(Method method, String token, HttpServletRequest request) {
    ApiOperation apiOperation = method.getAnnotation(ApiOperation.class);
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
    handleOpLog(method, token, request);
    String requestURI = request.getRequestURI();
    if (permission.needLogIn()) {
      //校验登录
      if (ObjectUtils.isEmpty(token)) {
        log.error("permission module>>>>>> user not login!,uri:{}", requestURI);
        throw new BusinessException(1, "未登录");
      }
      //校验token
      User user = null;
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
    long endTime = System.currentTimeMillis();
    //todo 超时预警

    LocaleContextHolder.resetLocaleContext();
    UserHolder.remove();
  }
}
