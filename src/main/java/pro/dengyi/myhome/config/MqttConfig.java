package pro.dengyi.myhome.config;

import java.util.concurrent.Executor;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallbackExtended;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.springframework.beans.factory.annotation.Autowired;
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
  private Executor executor;

  @Autowired
  private MqttMessageHandleThread mqttMessageHandleThread;


  @Bean
  public MqttClient mqttClient() {
    MemoryPersistence persistence = new MemoryPersistence();
    try {
      MqttClient client = new MqttClient(systemProperties.getServerMqttHost(),
          systemProperties.getServerMqttClientId(), persistence);

      // 设置回调
      client.setCallback(new MqttCallbackExtended() {
        @Override
        public void connectComplete(boolean reconnect, String serverURI) {
          log.info("连接完毕");
        }

        @Override
        public void connectionLost(Throwable cause) {
          log.info("连接断开,原因:{},30秒后重连", cause.getMessage());
          executor.execute(() -> {
            try {
              Thread.sleep(30000);
              MqttConnectOptions connOpts = new MqttConnectOptions();
              connOpts.setKeepAliveInterval(60);
              connOpts.setUserName("admin");
              connOpts.setPassword("admin".toCharArray());
              // 保留会话
              connOpts.setCleanSession(true);
              client.connect(connOpts);
              client.subscribe("report/#", 1);
            } catch (Exception e) {
              log.error("重连失败", e);
            }
          });
        }

        @Override
        public void messageArrived(String topic, MqttMessage message) throws Exception {
          mqttMessageHandleThread.handleMessage(topic, message);
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
