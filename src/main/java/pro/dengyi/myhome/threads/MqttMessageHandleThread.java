package pro.dengyi.myhome.threads;

import com.alibaba.fastjson.JSON;
import java.time.LocalDateTime;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;

/**
 * mqtt消息处理线程
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-26
 */
@Slf4j
@Component
public class MqttMessageHandleThread {

  @Autowired
  private DeviceDao deviceDao;
  @Autowired
  private DeviceLogDao deviceLogDao;

  @Async("executor")
  @Transactional
  public void handleMessage(String topic, MqttMessage message) {
    log.info("收到消息:topic:{},消息内容:{}", topic, message.toString());
    String[] topicArray = topic.split("/");
    String productId = topicArray[1];
    String deviceId = topicArray[2];
    //1. 消息记录
    DeviceLog deviceLog = new DeviceLog();
    deviceLog.setProductId(productId);
    deviceLog.setDeviceId(deviceId);
    deviceLog.setTopicName(topic);
    deviceLog.setPayload(message.toString());
    deviceLog.setDirection(2);
    deviceLog.setCreateTime(LocalDateTime.now());
    deviceLog.setUpdateTime(LocalDateTime.now());
    deviceLogDao.insert(deviceLog);
    //更新设备固件版本
    Device device = deviceDao.selectById(deviceId);
    device.setFramewareVersion(Integer.parseInt(JSON.parseObject(message.toString()).get("version").toString()));
    deviceDao.updateById(device);
    //todo 2.条件触发

    //todo 3.websocket推动
  }

}
