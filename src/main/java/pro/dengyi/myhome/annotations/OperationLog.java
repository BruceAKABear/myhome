package pro.dengyi.myhome.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/17 16:22
 * @description：日志记录注解
 * @modified By：
 */

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface OperationLog {

}
