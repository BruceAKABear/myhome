package pro.dengyi.myhome.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义注解
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-27
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface Permission {

  /**
   * 是否校验登录
   *
   * @return
   */
  boolean needLogIn() default true;

  /**
   * 是否校验权限
   *
   * @return
   */
  boolean needValidate() default true;


}
