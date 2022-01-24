package pro.dengyi.myhome.config;

import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.persist.MemoryPersistence;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import pro.dengyi.myhome.callback.MyMqttCallback;

/**
 * mqtt配置
 *
 * 服务端下发命名在队列 control/#
 * 服务端监听队列在 report/#
 * 心跳队列在 heartbeat/#
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Slf4j
@Configuration
public class MqttConfig {
    private static final String[] SUBTOPIC = {"report/#","heartbeat/#"};
    private static final String CLIENT_ID = "server-client";
    private static final String USER_NAME = "server";
    private static final String PASS_WORD = "passwd";

    @Bean
    public MqttClient mqttClient() {
        String broker = "tcp://121.36.171.33:1883";
        MemoryPersistence persistence = new MemoryPersistence();
        try {
            MqttClient client = new MqttClient(broker, CLIENT_ID, persistence);
            // MQTT 连接选项
            MqttConnectOptions connOpts = new MqttConnectOptions();
            connOpts.setUserName(USER_NAME);
            connOpts.setPassword(PASS_WORD.toCharArray());
            // 保留会话
            connOpts.setCleanSession(true);
            // 设置回调
            client.setCallback(new MyMqttCallback());
            // 建立连
            client.connect(connOpts);
            // 订阅
            client.subscribe(SUBTOPIC);
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
