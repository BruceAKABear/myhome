package pro.dengyi.myhome.config;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.utils.UserHolder;

/**
 * aop配置
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-27
 */
@Aspect
@Component
public class AopConfig {


  /**
   * 定义切点
   */
  @Pointcut("@annotation(pro.dengyi.myhome.annotations.NeedHolderPermission)")
  public void permissionPointCut() {
  }

  /**
   * 定义通知
   *
   * @param joinPoint
   */
  @Before(value = "permissionPointCut()")
  public void checkPermission(JoinPoint joinPoint) {
    Boolean houseHolder = UserHolder.getHouseHolder();
    if (!houseHolder) {
      throw new BusinessException(22222, "权限不足");
    }

  }
}
