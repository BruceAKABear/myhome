package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
@Data
@TableName("device_log")
@ApiModel("设备消息实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DeviceLog {
    private String id;

    @ApiModelProperty(value = "设备ID")
    private String deviceId;

    @ApiModelProperty(value = "数据内容")
    private String payload;

    @ApiModelProperty(value = "数据流向：1平台下发，2设备上报")
    private Integer direction;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

}
