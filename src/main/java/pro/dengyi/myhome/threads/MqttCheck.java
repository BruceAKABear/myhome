package pro.dengyi.myhome.threads;

import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-09-04
 */
@Slf4j
@Component
//@EnableScheduling
public class MqttCheck {

  @Autowired
  private MqttClient mqttClient;

  @Scheduled(cron = "0 0/1 * * * ?")
  @Async
  public void checkTimer() throws MqttException {
    if (!mqttClient.isConnected()) {
      log.warn("连接丢失，尝试重新连接");
      mqttClient.connect();
    }
  }


}
