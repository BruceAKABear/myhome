package pro.dengyi.myhome.threads;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.github.benmanes.caffeine.cache.Cache;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.FramewareDao;
import pro.dengyi.myhome.dao.ProductDao;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.Frameware;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.utils.PushUtil;

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
  private ProductDao productDao;
  @Autowired
  private DeviceLogDao deviceLogDao;
  @Autowired
  private FramewareDao framewareDao;
  @Autowired
  private Cache cache;


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
    //todo mq日志
    String[] topicArray = topic.split("/");
    String productId = topicArray[1];
    Product product = (Product) cache.get("product:" + productId,
        k -> productDao.selectById(productId));
    switch (product.getType()) {
      case "normal":
        break;
      case "gateway":
        break;
      default:
        log.error("设备上报时，根据产品查出错误产品类型。topic为:{}，消息为:{}", topic, message);
    }
    String deviceId = topicArray[2];
    //1. 消息记录
    DeviceLog deviceLog = DeviceLog.builder().productId(productId).deviceId(deviceId)
        .topicName(topic).payload(message.toString()).direction("up").build();
    deviceLog.setCreateTime(LocalDateTime.now());
    deviceLog.setUpdateTime(LocalDateTime.now());
    deviceLogDao.insert(deviceLog);
    //2. 更新设备固件版本
    Frameware frameware = (Frameware) cache.get("frameware:" + product.getId(),
        key -> framewareDao.selectOne(
            new LambdaQueryWrapper<Frameware>().eq(Frameware::getProductId, product.getId())
                .orderByDesc(Frameware::getVersion).last("limit 1")));
    Device device = deviceDao.selectById(deviceId);
    device.setFramewareVersion(
        Integer.parseInt(JSON.parseObject(message.toString()).get("version").toString()));
    deviceDao.updateById(device);

    if (frameware != null && frameware.getVersion() > device.getFramewareVersion()) {

      try {
        Map<String, Object> otaParams = new HashMap<>();
        //todo 这个url需要动态
        otaParams.put("url", frameware.getUrl());
        String otaTopic = "ota/" + device.getProductId() + "/" + device.getId();
        MqttMessage otaMessage = new MqttMessage(
            JSON.toJSONString(otaParams).getBytes(StandardCharsets.UTF_8));
        otaMessage.setQos(1);
        mqttClient.publish(otaTopic, otaMessage);
        DeviceLog otaLog = new DeviceLog(device.getProductId(), device.getId(), otaTopic,
            JSON.toJSONString(otaParams), "down");
        deviceLogDao.insert(otaLog);

      } catch (Exception e) {
        log.error("下发固件更新时异常:", e);
      }

    }
    PushUtil.deviceStatusChangePush(deviceId, JSON.parse(message.toString()));
    //todo 2.条件触发

  }

}
