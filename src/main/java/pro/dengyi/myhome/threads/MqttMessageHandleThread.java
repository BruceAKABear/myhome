package pro.dengyi.myhome.threads;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.CategoryFieldDao;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.model.CategoryField;
import pro.dengyi.myhome.model.Device;
import pro.dengyi.myhome.model.DeviceLog;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * mqtt消息处理线程
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-26
 */
@Slf4j
public class MqttMessageHandleThread implements Runnable {

    private StringRedisTemplate stringRedisTemplate;
    private DeviceDao deviceDao;
    private CategoryFieldDao categoryFieldDao;
    private String topic;
    private MqttMessage message;
    private DeviceLogDao deviceLogDao;

    private static final String TOPIC_HEARTBEAT = "heartbeat/";

    public MqttMessageHandleThread(StringRedisTemplate stringRedisTemplate, DeviceDao deviceDao, CategoryFieldDao categoryFieldDao, DeviceLogDao deviceLogDao, String topic, MqttMessage message) {
        this.stringRedisTemplate = stringRedisTemplate;
        this.deviceDao = deviceDao;
        this.categoryFieldDao = categoryFieldDao;
        this.topic = topic;
        this.message = message;
        this.deviceLogDao = deviceLogDao;
    }

    @Override
    public void run() {
        String deviceId = topic.substring(topic.indexOf("/") + 1);
        if (topic.startsWith(TOPIC_HEARTBEAT)) {
            log.info("接收到设备心跳数据，开始更新缓存");
            //第一次设备上线，设置数据库
            if (ObjectUtils.isEmpty(stringRedisTemplate.opsForValue().get("onlineDevice:" + deviceId))) {
                Device device = deviceDao.selectById(deviceId);
                device.setOnline(true);
                deviceDao.updateById(device);

            }
            //35秒没接收到设备上报心跳视为设备离线
            stringRedisTemplate.opsForValue().set("onlineDevice:" + deviceId, "online", 35, TimeUnit.SECONDS);
        } else {
            log.info("设备状态上报:消息为{}", message);
            DeviceLog deviceLog = new DeviceLog();
            deviceLog.setDeviceId(deviceId);
            deviceLog.setDirection(2);
            deviceLog.setPayload(new String(message.getPayload()));
            deviceLog.setCreateTime(new Date());
            deviceLogDao.insert(deviceLog);
            Object parseObjectMap = JSON.parseObject(message.getPayload(), Map.class);
            //获取设备所有控制字段
            List<CategoryField> fields = categoryFieldDao.selectListByDeviceId(deviceId);
            if (!CollectionUtils.isEmpty(fields)) {
                for (CategoryField field : fields) {
                    System.out.println(field);

                }

            }
        }
    }
}
