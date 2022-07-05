package pro.dengyi.myhome.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 初始化配置
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Data
@Component
@ConfigurationProperties(prefix = "system")
public class SystemProperties {


  private String defaultName;
  private String defaultAvatar;
  private String defaultEmail;
  private String defaultPassword;

  private String defaultSalt;

  private String serverMqttClientId;

  /**
   * 服务端mqtt clientId
   */
  private String mqttUserName;
  /**
   * 服务端mqtt 连接密码
   */
  private String mqttPassword;
  /**
   * mqtt订阅队列
   */
  private String[] mqttTopics;
}
