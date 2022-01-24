package pro.dengyi.myhome.callback;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttMessage;

/**
 * mqtt回调
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-22
 */
public class MyMqttCallback implements MqttCallback {

    @Override
    public void connectionLost(Throwable cause) {
        // 连接丢失后，一般在这里面进行重连
        System.out.println("连接断开，可以做重连");
    }

    @Override
    public void messageArrived(String topic, MqttMessage message) throws Exception {
        String deviceId = topic.substring(topic.indexOf("/") + 1);
        if (topic.startsWith("heartbeat/")) {
            //更新redis
            System.out.println("设备ID：" + deviceId);


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
