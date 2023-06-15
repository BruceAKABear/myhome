package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/7 10:05
 * @description：系统配置
 * @modified By：
 */

@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("system_system_config")
@ApiModel("接口处理时间")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SystemConfig extends BaseModel {

    private String settingValue;
}
