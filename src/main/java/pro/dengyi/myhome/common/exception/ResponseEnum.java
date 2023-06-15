package pro.dengyi.myhome.common.exception;


import pro.dengyi.myhome.common.response.Response;

/**
 * 基础响应枚举类
 *
 * <p>此枚举类中为最基础的响应枚举，其他业务系统的枚举类均放置在自身服务中
 *
 * @author BLab
 */
public enum ResponseEnum implements Response {

    SUCCESS(false, 10000, "操作成功"),
    PARAM_ERROR(false, 10001, "参数异常"),
    LOGIN_EXPIRE(false, 10001, "参数异常"),
    SYSTEM_ERROR(false, 11111, "系统异常"),
    ;

    private Boolean status;
    private Integer code;
    private String message;

    /**
     * 全参构造
     *
     * @param status  执行状态
     * @param code    执行编码
     * @param message 执行消息
     */
    ResponseEnum(Boolean status, Integer code, String message) {
        this.status = status;
        this.code = code;
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
