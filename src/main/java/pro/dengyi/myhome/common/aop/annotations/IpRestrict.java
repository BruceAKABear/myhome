package pro.dengyi.myhome.common.aop.annotations;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * usually use in device control ,just let device in inner network can connect to MyHome system
 *
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/3/13 15:27
 * @description：ip restrict annotation
 * @modified By：
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface IpRestrict {

}
