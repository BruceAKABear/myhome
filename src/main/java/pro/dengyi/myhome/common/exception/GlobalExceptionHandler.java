package pro.dengyi.myhome.common.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import pro.dengyi.myhome.common.response.Response;
import pro.dengyi.myhome.common.utils.I18nMessageUtil;

import javax.validation.ConstraintViolationException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 全局异常处理器
 *
 * @author dengy
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * 统一处理未特殊定义的异常
     *
     * @param e
     * @return
     */
    @ExceptionHandler(Exception.class)
    public Response commonException(Exception e) {
        log.error("框架异常，信息为:", e);
        return new Response() {
            @Override
            public Boolean getStatus() {
                return false;
            }

            @Override
            public Integer getCode() {
                return 11111;
            }

            @Override
            public String getMessage() {
                return "system error";
            }

            @Override
            public Object getData() {
                return null;
            }
        };
    }

    /**
     * 业务异常处理类
     *
     * @param be 业务异常类
     * @return
     */
    @ExceptionHandler(BusinessException.class)
    public Response businessException(BusinessException be) {
        return new Response() {
            @Override
            public Boolean getStatus() {
                return false;
            }

            @Override
            public Integer getCode() {
                return be.getCode();
            }

            @Override
            public String getMessage() {
                return I18nMessageUtil.get(be.getMessage());
            }

            @Override
            public Object getData() {
                return null;
            }
        };
    }

    @ExceptionHandler(IpRestrictException.class)
    public Map<String, Object> ipRestrictException(IpRestrictException be) {
        Map<String, Object> returnmap = new HashMap<>(4);
        returnmap.put("status", false);
        returnmap.put("code", 2000);
        returnmap.put("message", be.getMessage());
        return returnmap;
    }

    @ExceptionHandler({
            MethodArgumentNotValidException.class,
            HttpMessageNotReadableException.class,
            IllegalArgumentException.class,
            ConstraintViolationException.class
    })
    public Response parametersException(Exception me) {
        log.error("请求参数异常，信息为:", me);
        String message = null;

        //get request param error
        if (me instanceof ConstraintViolationException) {
            ConstraintViolationException cve = (ConstraintViolationException) me;
            message = cve.getMessage();
        }
        //post request body param error
        if (me instanceof MethodArgumentNotValidException) {
            MethodArgumentNotValidException methodArgumentNotValidException = (MethodArgumentNotValidException) me;
            BindingResult bindingResult = methodArgumentNotValidException.getBindingResult();
            List<ObjectError> allErrors = bindingResult.getAllErrors();
            StringBuilder sb = new StringBuilder();
            for (ObjectError oneError : allErrors) {
                String messageIn = oneError.getDefaultMessage();
                sb.append(messageIn);
                sb.append(",");
            }
            message = sb.substring(0, sb.lastIndexOf(","));
        }


        Map<String, Object> returnmap = new HashMap<>(3);
        // 执行状态
        returnmap.put("status", false);
        returnmap.put("code", ResponseEnum.PARAM_ERROR.getCode());
        returnmap.put("message", ResponseEnum.PARAM_ERROR.getMessage());
        if (me instanceof ConstraintViolationException) {
            returnmap.put("message", me.getMessage());
        }

        String finalMessage = message;
        return new Response() {
            @Override
            public Boolean getStatus() {
                return false;
            }

            @Override
            public Integer getCode() {
                return ERROR_CODE;
            }

            @Override
            public String getMessage() {
                return finalMessage;
            }

            @Override
            public Object getData() {
                return null;
            }
        };
    }

    /**
     * 请求方式异常
     *
     * @param me 参数异常类
     * @return
     */
    @ExceptionHandler({HttpRequestMethodNotSupportedException.class})
    public Map<String, Object> methodException(Exception me) {
        log.error("请求方式异常，信息为:", me);
        Map<String, Object> returnmap = new HashMap<>(3);
        // 执行状态
        returnmap.put("status", false);
        returnmap.put("code", ResponseEnum.PARAM_ERROR.getCode());
        returnmap.put("message", "请求方式异常");
        return returnmap;
    }


}
