package pro.dengyi.myhome.model.device;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/9/9 14:45
 * @description：设备设备关联
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("device_device")
@ApiModel("设备关联实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DeviceRelated extends BaseModel {

  private String mainDeviceId;

  private String relatedDeviceId;

}
