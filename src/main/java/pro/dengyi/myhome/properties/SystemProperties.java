package pro.dengyi.myhome.properties;

import java.util.List;
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

  /**
   * 服务端clientId集合
   * <p>
   * 用作同一broker环境下多服务端启动时防止冲突使用
   */
  private List<String> mqttClientIds;

  /**
   * broker ip地址
   */
  private String mqttHostIp;

  /**
   * broker端口
   */
  private String mqttPort;

  /**
   * mqtt是否开启ssl标识
   */
  private Boolean mqttOpenSsl = false;

  /**
   * emqx api key
   */

  private String mqttApiKey;
  /**
   * emqx api secret
   */
  private String mqttApiSecret;


  private String filePrefix;

}
