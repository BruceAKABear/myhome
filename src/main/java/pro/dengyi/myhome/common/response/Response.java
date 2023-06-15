package pro.dengyi.myhome.common.response;

/**
 * 基础响应接口
 *
 * <p>一切响应都必须实现此接口
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2021-01-01
 */
public interface Response {

    /**
     * 响应状态
     *
     * @return Boolean
     */
    Boolean getStatus();

    /**
     * 响应code
     *
     * @return Integer
     */
    Integer getCode();

    /**
     * 响应消息
     *
     * @return String
     */
    String getMessage();

    /**
     * 响应数据
     *
     * @return
     */
    Object getData();
}
