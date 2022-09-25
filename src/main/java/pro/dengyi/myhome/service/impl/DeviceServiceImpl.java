package pro.dengyi.myhome.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.FramewareDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.Frameware;
import pro.dengyi.myhome.model.device.dto.OtaParam;
import pro.dengyi.myhome.model.dto.DeviceDto;
import pro.dengyi.myhome.properties.SystemProperties;
import pro.dengyi.myhome.service.DeviceService;

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
  private MqttClient mqttClient;
  @Autowired
  private DeviceLogDao deviceLogDao;
  @Autowired
  private SystemProperties systemProperties;
  @Autowired
  private FramewareDao framewareDao;


  @Override
  public Device selectById(String deviceId) {
    return deviceDao.selectById(deviceId);
  }

  @Transactional
  @Override
  public void addUpdate(Device device) {
    if (ObjectUtils.isEmpty(device.getId())) {
      //如果芯片ID存在，则芯片ID为设备id
      if (!ObjectUtils.isEmpty(device.getChipId())) {
        device.setId(device.getChipId());
      }
      //新增，默认离线，默认启用,固件版本为1
      device.setEnable(true);
      device.setOnline(false);
      device.setFramewareVersion(1);
      device.setCreateTime(LocalDateTime.now());
      device.setUpdateTime(LocalDateTime.now());
      deviceDao.insert(device);
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
  public List<Device> debugDeviceList(String productId) {

    LambdaQueryWrapper<Device> wrapper = new LambdaQueryWrapper<>();
    if (!ObjectUtils.isEmpty(productId)) {
      wrapper.eq(Device::getProductId, productId);
    }
    return deviceDao.selectList(wrapper);
  }

  @Transactional
  @Override
  public void sendDebug(Map<String, Object> orderMap) {

    String deviceId = (String) orderMap.get("deviceId");
    String cmdContent = JSON.toJSONString(orderMap);
    Device device = deviceDao.selectById(deviceId);
    if (device.getOnline()) {

      String controlTopic = "control/" + device.getProductId() + "/" + device.getId();
      MqttMessage message = new MqttMessage(
          JSON.toJSONString(orderMap).getBytes(StandardCharsets.UTF_8));
      message.setQos(1);
      try {
        mqttClient.publish(controlTopic, message);
        DeviceLog deviceLog = new DeviceLog();
        deviceLog.setProductId(device.getProductId());
        deviceLog.setDeviceId(deviceId);
        deviceLog.setTopicName(controlTopic);
        deviceLog.setPayload(cmdContent);
        deviceLog.setDirection(1);
        deviceLog.setCreateTime(LocalDateTime.now());
        deviceLog.setUpdateTime(LocalDateTime.now());
        deviceLogDao.insert(deviceLog);
      } catch (MqttException e) {
        log.error("发送命令失败", e);
      }
    } else {
      throw new BusinessException(18002, "设备离线不能发送命令");
    }
  }

  @Override
  public void emqHook(Map<String, Object> params) {
    log.warn("设备状态发生改变，数据为:{}", params);
    String clientId = (String) params.get("clientid");
    //排除掉后台
    if ("916295934".equals(clientId)) {
      return;
    }
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

  @Override
  public void deviceOnline(String clientId) {
    Device device = deviceDao.selectById(clientId);
    device.setOnline(true);
    deviceDao.updateById(device);
  }

  @Override
  public void singleDeviceFirmwareUpdate(DeviceDto deviceDto) {
    String otaTopic = "ota/" + deviceDto.getProductId() + "/" + deviceDto.getId();
    //查询最新的固件
    Frameware frameware = framewareDao.selectOne(
        new LambdaQueryWrapper<Frameware>().eq(Frameware::getProductId, deviceDto.getProductId())
            .orderByDesc(Frameware::getVersion).last("limit 1"));

    OtaParam otaParam = new OtaParam();
    otaParam.setDeviceId(deviceDto.getId());
    otaParam.setTargetVersion(frameware.getVersion());
    otaParam.setTargetUrl(frameware.getUrl());

    String otaString = JSON.toJSONString(otaParam);

    MqttMessage message = new MqttMessage(
        otaString.getBytes(StandardCharsets.UTF_8));
    message.setQos(1);
    try {
      mqttClient.publish(otaTopic, message);
      DeviceLog deviceLog = new DeviceLog();
      deviceLog.setProductId(deviceDto.getProductId());
      deviceLog.setDeviceId(deviceDto.getId());
      deviceLog.setTopicName(otaTopic);
      deviceLog.setPayload(otaString);
      deviceLog.setDirection(1);
      deviceLog.setCreateTime(LocalDateTime.now());
      deviceLog.setUpdateTime(LocalDateTime.now());
      deviceLogDao.insert(deviceLog);
    } catch (MqttException e) {
      log.error("发送命令失败", e);
    }

  }

  @Override
  public void sendCmd(Map<String, Object> orderMap) {

  }
}
