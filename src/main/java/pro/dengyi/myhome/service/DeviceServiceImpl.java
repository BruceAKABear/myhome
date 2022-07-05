package pro.dengyi.myhome.service;

import cn.hutool.crypto.digest.MD5;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.ProductDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.Product;
import pro.dengyi.myhome.model.dto.DeviceDto;
import pro.dengyi.myhome.properties.SystemProperties;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
@Slf4j
@Service
public class DeviceServiceImpl implements DeviceService {

  @Autowired
  private DeviceDao deviceDao;
  @Autowired
  private StringRedisTemplate stringRedisTemplate;
  //  @Autowired
//  private MqttClient mqttClient;
  @Autowired
  private DeviceLogDao deviceLogDao;
  @Autowired
  private ProductDao productDao;
  @Autowired
  private SystemProperties systemProperties;


  @Override
  public Device selectById(String deviceId) {
    return deviceDao.selectById(deviceId);
  }

  @Transactional
  @Override
  public void addUpdate(Device device) {
    //todo 其他什么处理？
    if (ObjectUtils.isEmpty(device.getId())) {
      //如果芯片ID存在，则芯片ID为设备id
      if (!ObjectUtils.isEmpty(device.getChipId())) {
        device.setId(device.getChipId());
      }
      //新增，默认离线，默认启用
      device.setEnable(true);
      device.setOnline(false);
      device.setCreateTime(LocalDateTime.now());
      device.setUpdateTime(LocalDateTime.now());
      deviceDao.insert(device);

//      Product product = productDao.selectById(device.getProductId());
//      String defaultSalt = systemProperties.getDefaultSalt();
//      String pass;
//      if (product.getEncryptionType() == 1) {
//        //一机一密码
//        pass = MD5.create().digestHex(device.getId() + defaultSalt);
//      } else {
//        //一型一密
//        pass = MD5.create().digestHex(product.getId() + defaultSalt);
//      }
//      device.setLoginPassword(pass);
//      deviceDao.updateById(device);


    } else {
      //更新
      device.setUpdateTime(LocalDateTime.now());
      deviceDao.updateById(device);
    }

  }

  @Transactional
  @Override
  public void delete(String id) {
    //todo 做其他判断
    deviceDao.deleteById(id);
  }

  @Override
  public IPage<DeviceDto> page(Integer pageNumber, Integer pageSize, String floorId, String roomId,
      String categoryId) {
    IPage<DeviceDto> pageParam = new Page<>(pageNumber == null ? 1 : pageNumber,
        pageSize == null ? 10 : pageSize);
    return deviceDao.selectCustomPage(pageParam, floorId, roomId, categoryId);
  }

  @Override
  public List<Device> debugDeviceList() {
    return deviceDao.selectList(new LambdaQueryWrapper<>());
  }

  @Transactional
  @Override
  public void sendDebug(Map<String, Object> orderMap) {

    String deviceId = (String) orderMap.get("deviceId");
    //判断设备是否在线
    String onlineStatus = stringRedisTemplate.opsForValue().get("onlineDevice:" + deviceId);
    if (!ObjectUtils.isEmpty(onlineStatus)) {
      String pubTopic = "control/" + deviceId;
      String content = (String) orderMap.get("content");
      //todo 有问题
      JSONObject jsonObject = JSON.parseObject(content);
      MqttMessage message = new MqttMessage(
          JSON.toJSONString(jsonObject).getBytes(StandardCharsets.UTF_8));
      message.setQos(1);
//      try {
////        mqttClient.publish(pubTopic, message);
//        DeviceLog deviceLog = new DeviceLog();
//        deviceLog.setDeviceId(deviceId);
//        deviceLog.setDirection(1);
//        deviceLog.setPayload(content);
//        deviceLog.setCreateTime(new Date());
//        deviceLogDao.insert(deviceLog);
//      } catch (MqttException e) {
//        throw new BusinessException(18001, "下发debug命令异常");
//      }
    } else {
      throw new BusinessException(18002, "设备离线不能发送命令");
    }

  }

  @Override
  public void emqHook(Map<String, Object> params) {
    log.warn("设备状态发生改变，数据为:{}", params);
    String clientId = (String) params.get("clientid");
    String eventType = (String) params.get("event");
    Device device = deviceDao.selectById(clientId);
    if ("client.connected".equals(eventType)) {
      device.setOnline(true);
    } else {
      device.setOnline(false);
    }
    device.setUpdateTime(LocalDateTime.now());
    deviceDao.updateById(device);
  }
}
