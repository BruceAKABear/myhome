package pro.dengyi.myhome.config;

import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallbackExtended;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import pro.dengyi.myhome.properties.SystemProperties;
import pro.dengyi.myhome.threads.MqttMessageHandleThread;

/**
 * mqtt配置
 * <p>
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Slf4j
@Configuration
public class MqttConfig {

  @Autowired
  private SystemProperties systemProperties;
  @Autowired
  private MqttMessageHandleThread mqttMessageHandleThread;
  @Value("${spring.profiles.active}")
  private String active;


  @Bean
  public MqttClient mqttClient() {
    MemoryPersistence persistence = new MemoryPersistence();
    try {
      MqttClient client = null;
      if (systemProperties.getMqttOpenSsl()) {
        //todo 开启ssl
      } else {
        String clientId;
        switch (active) {
          case "dev":
            clientId = systemProperties.getMqttClientIds().get(0);
            break;
          case "prod":
            clientId = systemProperties.getMqttClientIds().get(1);
            break;
          default:
            clientId = "none";
            log.error("启动配置文件配置错误，所使用配置文件为：{}", active);
        }

        client = new MqttClient(
            "tcp://" + systemProperties.getMqttHostIp() + ":" + systemProperties.getMqttPort(),
            clientId, persistence);
      }
      // 设置回调
      MqttClient finalClient = client;
      client.setCallback(new MqttCallbackExtended() {
        @Override
        public void connectComplete(boolean reconnect, String serverURI) {
          log.info("mqtt连接完毕");
        }

        @Override
        public void connectionLost(Throwable cause) {
          log.info("连接断开,原因:{}", cause.getMessage());
        }

        @Override
        public void messageArrived(String topic, MqttMessage message) throws Exception {
          mqttMessageHandleThread.handleMessage(topic, message, finalClient);
        }

        @Override
        public void deliveryComplete(IMqttDeliveryToken token) {
          log.warn("消息发送完毕");
        }
      });
      return client;

    } catch (MqttException me) {
      log.error("初始化mqtt连接异常", me);
      return null;
    }
  }

}
