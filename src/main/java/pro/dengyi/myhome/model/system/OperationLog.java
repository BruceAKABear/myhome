package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * 操作日志
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-08-20
 */

@Builder
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

}
