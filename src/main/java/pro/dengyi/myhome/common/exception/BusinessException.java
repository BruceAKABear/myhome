package pro.dengyi.myhome.common.exception;


import pro.dengyi.myhome.common.response.Response;

/**
 * business exception class
 *
 * @author dengy
 */
public class BusinessException extends RuntimeException {

    private final Integer code;
    private final String message;


    /**
     * specific exception
     * <p>
     * inorder to return a code to frontend for the frontend hand the specific logic
     *
     * @param code
     * @param message
     */
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
        this.code = Response.ERROR_CODE;
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
