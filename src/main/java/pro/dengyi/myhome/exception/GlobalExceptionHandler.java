package pro.dengyi.myhome.exception;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import java.security.SignatureException;
import java.util.HashMap;
import java.util.Map;
import javax.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.Response;

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
  public Response customException(Exception e) {
    log.error("框架异常，信息为:", e);
    return new CommonResponse(ResponseEnum.SYSTEM_ERROR);
  }

  /**
   * 业务异常处理类
   *
   * @param be 业务异常类
   * @return
   */
  @ExceptionHandler(BusinessException.class)
  public Map<String, Object> businessException(BusinessException be) {
    Map<String, Object> returnmap = new HashMap<>(4);
    returnmap.put("status", false);
    returnmap.put("code", be.getCode());
    returnmap.put("message", be.getMessage());
    return returnmap;
  }

  @ExceptionHandler(IpRestrictException.class)
  public Map<String, Object> ipRestrictException(IpRestrictException be) {
    Map<String, Object> returnmap = new HashMap<>(4);
    returnmap.put("status", false);
    returnmap.put("code", 2000);
    returnmap.put("message", be.getMessage());
    return returnmap;
  }

  /**
   * 参数异常处理类
   *
   * @param me 参数异常类
   * @return
   */
  @ExceptionHandler({
      MethodArgumentNotValidException.class,
      HttpMessageNotReadableException.class,
      IllegalArgumentException.class,
      ConstraintViolationException.class
  })
  public Map<String, Object> parametersException(Exception me) {
    log.error("请求参数异常，信息为:", me);
    Map<String, Object> returnmap = new HashMap<>(3);
    // 执行状态
    returnmap.put("status", false);
    returnmap.put("code", ResponseEnum.PARAM_ERROR.getCode());
    returnmap.put("message", ResponseEnum.PARAM_ERROR.getMessage());
    if (me instanceof ConstraintViolationException) {
      returnmap.put("message", me.getMessage());
    }

    return returnmap;
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

  /**
   * token过期处理
   *
   * @param ee
   * @return
   */
  @ExceptionHandler(ExpiredJwtException.class)
  public Response jwtExpireException(ExpiredJwtException ee) {
    log.error("jwt过期异常，信息为:", ee);
    return new CommonResponse(ResponseEnum.LOGIN_EXPIRE);
  }

  /**
   * token异常处理类
   *
   * @param ee 参数异常类
   * @return
   */
  @ExceptionHandler({MalformedJwtException.class, SignatureException.class})
  public Response tokenError(Exception ee) {
    log.error("token异常，信息为:", ee);
    return new CommonResponse(ResponseEnum.LOGIN_EXPIRE);
  }

}
