package pro.dengyi.myhome.common.response;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/7/28 16:12
 * @description：
 * @modified By：
 */
@RestControllerAdvice(basePackages ="pro.dengyi" )
public class ResponseHandler implements ResponseBodyAdvice<Object> {
    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return !returnType.hasMethodAnnotation(IgnoreResponseHandler.class);
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        if (body instanceof Response) {
            return body;
        } else {
            return new Response() {
                @Override
                public Boolean getStatus() {
                    return true;
                }

                @Override
                public Integer getCode() {
                    return 10000;
                }

                @Override
                public String getMessage() {
                    return "success";
                }

                @Override
                public Object getData() {
                    return body;
                }
            };
        }


    }
}
