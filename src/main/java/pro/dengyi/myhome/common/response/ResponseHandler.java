package pro.dengyi.myhome.common.response;

import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

import java.util.HashMap;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/7/28 16:12
 * @description：
 * @modified By：
 */
@RestControllerAdvice
public class ResponseHandler implements ResponseBodyAdvice<Object> {
    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        return !returnType.hasMethodAnnotation(IgnoreResponseHandler.class);
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {

        String path = request.getURI().getPath();
//        Parameter parameter = returnType.getParameter();

        if (body instanceof Response) {
            //todo 请求失败日志
            return body;
        } else {
            Map<String, Object> resMap = new HashMap<>();
            resMap.put("code", 10000);
            resMap.put("message", "success");
            resMap.put("data", body);
            return resMap;
        }


    }
}
