package pro.dengyi.myhome.threads;

import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-09-04
 */
@Slf4j
@Component
@EnableScheduling
public class MqttCheck {

  @Autowired
  private MqttClient mqttClient;

  @Scheduled(cron = "0 0/1 * * * ?")
  @Async
  public void checkTimer() throws MqttException {
    log.info("mqtt保活定时器启动,当前mqtt连接状态：{}", mqttClient.isConnected());
    if (!mqttClient.isConnected()) {
      log.warn("连接丢失，尝试重新连接");
      MqttConnectOptions connOpts = new MqttConnectOptions();
      connOpts.setKeepAliveInterval(60);
      connOpts.setUserName("admin");
      connOpts.setPassword("admin".toCharArray());
      // 保留会话
      connOpts.setCleanSession(true);
      mqttClient.connect(connOpts);
      mqttClient.subscribe("report/#", 2);
    }
  }


}
