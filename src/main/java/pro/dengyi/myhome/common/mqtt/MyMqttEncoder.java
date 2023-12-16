package pro.dengyi.myhome.common.mqtt;

import io.netty.channel.ChannelHandler;
import io.netty.handler.codec.mqtt.MqttEncoder;

@ChannelHandler.Sharable
public class MyMqttEncoder extends MqttEncoder {

}