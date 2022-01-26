package pro.dengyi.myhome.callback;

import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.service.DeviceService;

/**
 * mqtt回调
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
@Slf4j
@Component
public class MyMqttCallback implements MqttCallback {
    @Autowired
    private DeviceService deviceService;
    @Autowired
    private RedisTemplate redisTemplate;


    @Override
    public void connectionLost(Throwable cause) {
        // 连接丢失后，一般在这里面进行重连
        System.out.println("连接断开，可以做重连");
    }

    @Override
    public void messageArrived(String topic, MqttMessage message) throws Exception {
        String deviceId = topic.substring(topic.indexOf("/") + 1);
        //查询设备的信息
//        Device device = deviceService.selectById(deviceId);
        if (topic.startsWith("heartbeat/")) {
            log.info("接收到设备心跳数据，开始更新缓存");
            //35秒没接收到设备上报心跳视为设备离线
            redisTemplate.opsForValue().set("onlineDevice:" + deviceId, true, 35);
        } else {
            System.out.println("设备ID：" + deviceId);
        }
        // subscribe后得到的消息会执行到这里面
        System.out.println("接收消息主题:" + topic);
        System.out.println("接收消息Qos:" + message.getQos());
        System.out.println("接收消息内容:" + new String(message.getPayload()));
    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken token) {
        System.out.println("deliveryComplete---------" + token.isComplete());
    }
}
