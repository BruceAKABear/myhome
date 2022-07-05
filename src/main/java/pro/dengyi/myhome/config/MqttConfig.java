package pro.dengyi.myhome.config;

import java.util.concurrent.Executor;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallbackExtended;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.StringRedisTemplate;
import pro.dengyi.myhome.dao.CategoryFieldDao;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.properties.SystemProperties;
import pro.dengyi.myhome.threads.MqttMessageHandleThread;

/**
 * mqtt配置
 * <p>
 * 服务端下发命名在队列 control/# 服务端监听队列在 report/# 心跳队列在 heartbeat/#
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Slf4j
@Configuration
public class MqttConfig {

  private static final String[] SUBTOPIC = {"report/#", "heartbeat/#"};
  private static final String CLIENT_ID = "server-client";

  @Autowired
  private SystemProperties systemProperties;
  @Autowired
  private DeviceDao deviceDao;
  @Autowired
  private StringRedisTemplate stringRedisTemplate;
  @Autowired
  private Executor executor;
  @Autowired
  private CategoryFieldDao categoryFieldDao;
  @Autowired
  private DeviceLogDao deviceLogDao;


  @Bean("mqttClient")
  public MqttClient mqttClient() {
    String broker = "tcp://192.168.1.56:1883";
    MemoryPersistence persistence = new MemoryPersistence();
    try {
      MqttClient client = new MqttClient(broker, CLIENT_ID, persistence);

      // 设置回调
      client.setCallback(new MqttCallbackExtended() {
        @Override
        public void connectComplete(boolean reconnect, String serverURI) {
          log.info("连接完毕");
        }

        @Override
        public void connectionLost(Throwable cause) {
          log.error("连接失去");
        }

        @Override
        public void messageArrived(String topic, MqttMessage message) throws Exception {
          executor.execute(
              new MqttMessageHandleThread(stringRedisTemplate, deviceDao, categoryFieldDao,
                  deviceLogDao, topic, message));
        }

        @Override
        public void deliveryComplete(IMqttDeliveryToken token) {
          log.warn("消息发送完毕");
        }
      });

      // 订阅
      // 消息发布所需参数
//            MqttMessage message = new MqttMessage(content.getBytes());
//            message.setQos(qos);
//            client.publish(pubTopic, message);
//            System.out.println("Message published");
      return client;

    } catch (MqttException me) {
      log.error("初始化mqtt连接异常", me);
      return null;
    }
  }

}
