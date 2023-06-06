package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

import java.time.LocalDateTime;

/**
 * 操作日志
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-08-20
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("system_operation_log")
@ApiModel("日志")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OperationLog extends BaseModel {

    private String uId;

    private String opName;

    private String opIp;

    private String requestUri;

    private String requestMethod;

    public OperationLog(String uId, String opName, String opIp, String requestUri,
                        String requestMethod) {
        this.uId = uId;
        this.opName = opName;
        this.opIp = opIp;
        this.requestUri = requestUri;
        this.requestMethod = requestMethod;
        this.setCreateTime(LocalDateTime.now());
        this.setUpdateTime(LocalDateTime.now());
    }
}
