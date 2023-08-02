package pro.dengyi.myhome.common.response;

import java.lang.annotation.*;

@Documented
@Inherited
@Target({ElementType.ANNOTATION_TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface IgnoreResponseHandler {

}