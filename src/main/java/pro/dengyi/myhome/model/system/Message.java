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
 * @date ：Created in 2022/12/28 16:45
 * @description：消息
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("message_message")
@ApiModel("消息")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Message extends BaseModel {

  //消息类型 onOff设备在离线 、security安防
  private String type;


  private String fromUserId;

  private String userId;

  private Boolean readed;

  private String content;

}
