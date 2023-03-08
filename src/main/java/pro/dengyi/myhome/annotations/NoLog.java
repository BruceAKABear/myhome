package pro.dengyi.myhome.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * log开启级别为全swagger接口，如果想不记录日志需使用当前注解
 *
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/17 16:22
 * @description：忽略日志注解
 * @modified By：
 */

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface NoLog {

}
