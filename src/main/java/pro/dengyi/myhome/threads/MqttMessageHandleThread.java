package pro.dengyi.myhome.threads;

import com.alibaba.fastjson.JSON;
import com.github.benmanes.caffeine.cache.Cache;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.ProductDao;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.Product;

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
  private Cache cache;

  @Async("executor")
  @Transactional
  public void handleMessage(String topic, MqttMessage message) {
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
    DeviceLog.builder().productId(productId).deviceId(deviceId).topicName(topic).payload(message.toString()).direction("up");
//    DeviceLog deviceLog = new DeviceLog();
//    deviceLog.setProductId(productId);
//    deviceLog.setDeviceId(deviceId);
//    deviceLog.setTopicName(topic);
//    deviceLog.setPayload(message.toString());
//    deviceLog.setDirection(2);
//    deviceLog.setCreateTime(LocalDateTime.now());
//    deviceLog.setUpdateTime(LocalDateTime.now());
//    deviceLogDao.insert(deviceLog);
    //更新设备固件版本
    Device device = deviceDao.selectById(deviceId);
    device.setFramewareVersion(
        Integer.parseInt(JSON.parseObject(message.toString()).get("version").toString()));
    deviceDao.updateById(device);
    //todo 2.条件触发



    //todo 3.websocket推动
  }

}
