package pro.dengyi.myhome.common.exception;


import pro.dengyi.myhome.common.response.Response;

/**
 * 业务异常类
 *
 * @author dengy
 */
public class BusinessException extends RuntimeException implements Response {

    private Integer code;
    private Boolean status;
    private String message;

    public BusinessException(Integer code, String message) {
        super(message);
        this.code = code;
        this.status = false;
        this.message = message;
    }


    @Override
    public Boolean getStatus() {
        return status;
    }

    @Override
    public Integer getCode() {
        return code;
    }

    @Override
    public String getMessage() {
        return message;
    }

    @Override
    public Object getData() {
        return null;
    }

}
