package pro.dengyi.myhome.model;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 倒计时实际
 *
 * @author DengYi
 * @version v1.0
 */
@Data
@ApiModel("倒计时实体")
@TableName("countdown_task")
public class CountdownTask {

  @ApiModelProperty("主键")
  private String id;

  @ApiModelProperty("家庭ID")
  @NotBlank
  private String familyId;

  @ApiModelProperty("名称")
  @NotBlank
  private String name;

  @ApiModelProperty("截止时间")
  @NotNull
  private Date expireAt;

  @ApiModelProperty("动作类型：1.控制，2.通知")
  // 通知：通知谁、以什么方式通知、通知什么内容
  // 控制：控制哪台设备、控制什么字段、控制的值是什么
  private Integer actionType;

  @ApiModelProperty("扩展内容，实际内容以json字符串的形式存")
  //设备id 控制字段 控制字段值
  private String extendContent;
}
