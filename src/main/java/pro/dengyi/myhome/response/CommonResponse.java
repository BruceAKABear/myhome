package pro.dengyi.myhome.response;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * 通用响应类
 *
 * <p>无数据返回包装类
 *
 * @author BLab
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CommonResponse implements Response {

    private Boolean status;
    private Integer code;
    private String message;

    public CommonResponse(Response response) {
        this.status = response.getStatus();
        this.code = response.getCode();
        this.message = response.getMessage();
    }

    /**
     * 全参构造函数
     *
     * @param status  执行状态：true/false
     * @param code    执行编码：5位数字
     * @param message 执行消息：返回提示
     */
    public CommonResponse(Boolean status, Integer code, String message) {
        this.status = status;
        this.code = code;
        this.message = message;
    }

    public static CommonResponse success() {
        return new CommonResponse(true, 10000, "操作成功");
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
}
