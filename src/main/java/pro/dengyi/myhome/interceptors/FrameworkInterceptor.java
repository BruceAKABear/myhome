package pro.dengyi.myhome.interceptors;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.dao.PermissionFunctionDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.utils.TokenUtil;
import pro.dengyi.myhome.utils.UserHolder;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/8/30 16:08
 * @description：框架拦截器
 * @modified By：
 */
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
      //封装语言选项
      handleLanguage(request);
      String token = request.getHeader("token");
      Method method = ((HandlerMethod) handler).getMethod();
      String requestURI = request.getRequestURI();
      Permission permissionInMethod = method.getAnnotation(Permission.class);
      Permission permissionInClass = method.getDeclaringClass().getAnnotation(Permission.class);
      if (permissionInMethod != null || permissionInClass != null) {
        //需要进行权限校验
        validatePermission(token, requestURI);
      }
    }
    return throughFlag;
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
   * @param token      登录token
   * @param requestURI 接口路径
   */
  private void validatePermission(String token, String requestURI) {
    if (ObjectUtils.isEmpty(token)) {
      throw new BusinessException(1, "未登录");
    }
    User user = TokenUtil.decToken(token);
    if (!user.isSuperAdmin()) {
      //非超管，校验权限
      List<String> permURIs = permissionFunctionDao.selecAllPermSymbol(user);
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

  @Override
  public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
      Object handler, Exception ex) throws Exception {
    LocaleContextHolder.resetLocaleContext();
    UserHolder.remove();
  }
}
