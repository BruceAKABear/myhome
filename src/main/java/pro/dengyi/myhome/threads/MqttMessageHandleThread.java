package pro.dengyi.myhome.threads;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.FramewareDao;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.Frameware;
import pro.dengyi.myhome.utils.IpUtil;
import pro.dengyi.myhome.utils.PushUtil;
import pro.dengyi.myhome.utils.queue.DeviceLogQueue;

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
  private FramewareDao framewareDao;
  @Autowired
  private Cache cache;

  @Value("${server.port}")
  private Integer serverPort;


  /**
   * the basic message for device upload must like this: {productId:xxxxxx,deviceId:xxxxx,...}
   *
   * @param topic
   * @param message
   * @param mqttClient
   */
  @Async("executor")
  @Transactional
  public void handleMessage(String topic, MqttMessage message, MqttClient mqttClient) {
    log.info("收到消息:topic:{},消息内容:{}", topic, message.toString());
    String[] topicArray = topic.split("/");
    String productId = topicArray[1];
    String deviceId = topicArray[2];

    Device device = (Device) cache.get("device:" + deviceId, pa -> deviceDao.selectById(deviceId));
    //设备日志
    DeviceLog deviceLog = new DeviceLog(productId, deviceId, topic, message.toString(), "up");
    DeviceLogQueue.publish(deviceLog);
    //设备固件版本控制
    deviceVersionControl(productId, deviceId, message.toString(), mqttClient);
    //推送设备状态
    PushUtil.deviceStatusChangePush(deviceId, device.getRoomId(), JSON.parse(message.toString()));
    //todo 2.条件触发

  }

  private void deviceVersionControl(String productId, String deviceId, String message,
      MqttClient mqttClient) {
    //判断固件版本更新
    Frameware frameware = (Frameware) cache.get("frameware:" + productId,
        key -> framewareDao.selectOne(
            new LambdaQueryWrapper<Frameware>().eq(Frameware::getProductId, productId)
                .orderByDesc(Frameware::getVersion).last("limit 1")));
    Device device = deviceDao.selectById(deviceId);
    Integer reportDeviceVersion = Integer.parseInt(
        JSON.parseObject(message).get("version").toString());
    if (!device.getFramewareVersion().equals(reportDeviceVersion)) {
      //不相等进行更新
      device.setFramewareVersion(reportDeviceVersion);
      deviceDao.updateById(device);
    }
    if (frameware != null && frameware.getVersion() > device.getFramewareVersion()) {
      try {
        Map<String, Object> otaParams = new HashMap<>();
        String ip = IpUtil.getIp();
        otaParams.put("url", "http://" + ip + ":" + serverPort + frameware.getUrl());
        String otaTopic = "ota/" + device.getProductId() + "/" + device.getId();
        MqttMessage otaMessage = new MqttMessage(
            JSON.toJSONString(otaParams).getBytes(StandardCharsets.UTF_8));
        otaMessage.setQos(1);
        mqttClient.publish(otaTopic, otaMessage);
        DeviceLog otaLog = new DeviceLog(device.getProductId(), device.getId(), otaTopic,
            JSON.toJSONString(otaParams), "down");
        DeviceLogQueue.publish(otaLog);
      } catch (Exception e) {
        log.error("下发固件更新时异常:", e);
      }

    }

  }

}
