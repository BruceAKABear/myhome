package pro.dengyi.myhome.common.exception;


/**
 * 业务异常类
 *
 * @author dengy
 */
public class BusinessException extends RuntimeException {

    private Integer code;
    private String message;

    public BusinessException(Integer code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    /**
     * 标准错误，无需前端特殊处理的情况就不用传code
     *
     * @param message
     */
    public BusinessException(String message) {
        super(message);
        this.code = 1;
        this.message = message;
    }

    public Integer getCode() {
        return code;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
