package pro.dengyi.myhome.response;

import com.fasterxml.jackson.annotation.JsonInclude;

/**
 * 数据响应类
 *
 * <p>当需要响应数据时使用此类进行返回
 *
 * @author BLab
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DataResponse<T> implements Response {

    private Boolean status;
    private Integer code;
    private String message;
    private T data;


    public DataResponse(T data) {
        this.status = true;
        this.code = 10000;
        this.message = "操作成功";
        this.data = data;
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


    public T getData() {
        return data;
    }
}
