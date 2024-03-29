package pro.dengyi.myhome.mqtt;

import io.netty.channel.Channel;
import io.netty.handler.codec.mqtt.*;
import lombok.extern.slf4j.Slf4j;
import pro.dengyi.myhome.model.device.Device;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
public class MqttMsgBack {

    /**
     * 确认连接请求
     *
     * @param channel
     * @param mqttMessage
     */
    public static void connack(Channel channel, MqttMessage mqttMessage) {
        MqttConnectMessage mqttConnectMessage = (MqttConnectMessage) mqttMessage;
        MqttConnAckVariableHeader mqttConnAckVariableHeaderBack = getMqttConnAckVariableHeader(mqttConnectMessage);
        MqttFixedHeader mqttFixedHeaderInfo = mqttConnectMessage.fixedHeader();
        //	构建返回报文， 固定报头
        MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(MqttMessageType.CONNACK, mqttFixedHeaderInfo.isDup(), MqttQoS.AT_MOST_ONCE, mqttFixedHeaderInfo.isRetain(), 0x02);
        //	构建CONNACK消息体
        MqttConnAckMessage connAck = new MqttConnAckMessage(mqttFixedHeaderBack, mqttConnAckVariableHeaderBack);
        channel.writeAndFlush(connAck);

    }

    private static MqttConnAckVariableHeader getMqttConnAckVariableHeader(MqttConnectMessage mqttConnectMessage) {
        MqttConnectPayload mqttConnectPayload = mqttConnectMessage.payload();
        String clientId = mqttConnectPayload.clientIdentifier();
        MqttConnAckVariableHeader mqttConnAckVariableHeaderBack = new MqttConnAckVariableHeader(MqttConnectReturnCode.CONNECTION_REFUSED_IDENTIFIER_REJECTED);
        //to get all client identifiers and judgment
        // whether the device can connect or not
        ArrayList<Device> devices = new ArrayList<>();
        Device device2 = new Device();
        device2.setId("mqttx_0466bd74");
        devices.add(device2);
        for (Device device : devices) {
            if (device.getId().equals(clientId)) {
                mqttConnAckVariableHeaderBack = new MqttConnAckVariableHeader(MqttConnectReturnCode.CONNECTION_ACCEPTED);
                MqttHandler.cache.put(clientId,clientId);
                MqttHandler.cache.get(clientId,(key)->{
                    MqttHandler.cache.put(clientId,clientId);
                    return null;
                });

                Object o = MqttHandler.cache.getIfPresent(clientId);
            }
        }
        return mqttConnAckVariableHeaderBack;
    }

    /**
     * 根据qos发布确认
     *
     * @param channel
     * @param mqttMessage
     */
    public static void puback(Channel channel, MqttMessage mqttMessage) {
        MqttPublishMessage mqttPublishMessage = (MqttPublishMessage) mqttMessage;
        MqttFixedHeader mqttFixedHeaderInfo = mqttPublishMessage.fixedHeader();
        MqttQoS qos = mqttFixedHeaderInfo.qosLevel();
        byte[] headBytes = new byte[mqttPublishMessage.payload().readableBytes()];
        mqttPublishMessage.payload().readBytes(headBytes);
        String data = new String(headBytes);
        System.out.println("publish data--" + data);

        switch (qos) {
            case AT_MOST_ONCE:        //	至多一次
                //QOS0
                break;
            case AT_LEAST_ONCE:        //	至少一次
                //QOS1
                //	构建返回报文， 可变报头
                MqttMessageIdVariableHeader mqttMessageIdVariableHeaderBack =
                        MqttMessageIdVariableHeader.from(mqttPublishMessage.variableHeader().messageId());
                //	构建返回报文， 固定报头
                MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(MqttMessageType.PUBACK, mqttFixedHeaderInfo.isDup(), MqttQoS.AT_MOST_ONCE, mqttFixedHeaderInfo.isRetain(), 0x02);
                //	构建PUBACK消息体
                MqttPubAckMessage pubAck = new MqttPubAckMessage(mqttFixedHeaderBack, mqttMessageIdVariableHeaderBack);
                log.debug("back--" + pubAck.toString());
                channel.writeAndFlush(pubAck);
                break;
            case EXACTLY_ONCE:
                log.error("we don't support qos2 right now");


//                //	刚好一次
//                //	构建返回报文， 固定报头
//                MqttFixedHeader mqttFixedHeaderBack2 = new MqttFixedHeader(MqttMessageType.PUBREC, false, MqttQoS.AT_LEAST_ONCE, false, 0x02);
//                //	构建返回报文， 可变报头
//                MqttMessageIdVariableHeader mqttMessageIdVariableHeaderBack2 =
//                        MqttMessageIdVariableHeader.from(mqttPublishMessage.variableHeader().messageId());
//                MqttMessage mqttMessageBack = new MqttMessage(mqttFixedHeaderBack2, mqttMessageIdVariableHeaderBack2);
//                log.debug("back--" + mqttMessageBack.toString());
//                channel.writeAndFlush(mqttMessageBack);
                break;
            default:
                log.error("not supported fixed header type");
                break;
        }
    }

    /**
     * 发布完成 qos2
     *
     * @param channel
     * @param mqttMessage
     */
    public static void pubcomp(Channel channel, MqttMessage mqttMessage) {
        MqttMessageIdVariableHeader messageIdVariableHeader = (MqttMessageIdVariableHeader) mqttMessage.variableHeader();
        //	构建返回报文， 固定报头
        MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(MqttMessageType.PUBCOMP, false, MqttQoS.AT_MOST_ONCE, false, 0x02);
        //	构建返回报文， 可变报头
        MqttMessageIdVariableHeader mqttMessageIdVariableHeaderBack = MqttMessageIdVariableHeader.from(messageIdVariableHeader.messageId());
        MqttMessage mqttMessageBack = new MqttMessage(mqttFixedHeaderBack, mqttMessageIdVariableHeaderBack);
        log.debug("back--" + mqttMessageBack);
        channel.writeAndFlush(mqttMessageBack);
    }

    /**
     * 订阅确认
     *
     * @param channel
     * @param mqttMessage
     */
    public static void suback(Channel channel, MqttMessage mqttMessage) {
        MqttSubscribeMessage mqttSubscribeMessage = (MqttSubscribeMessage) mqttMessage;
        MqttMessageIdVariableHeader messageIdVariableHeader = mqttSubscribeMessage.variableHeader();
        //	构建返回报文， 可变报头
        MqttMessageIdVariableHeader variableHeaderBack = MqttMessageIdVariableHeader.from(messageIdVariableHeader.messageId());
        Set<String> topics = mqttSubscribeMessage.payload().topicSubscriptions().stream().map(mqttTopicSubscription -> mqttTopicSubscription.topicName()).collect(Collectors.toSet());
        //log.info(topics.toString());
        List<Integer> grantedQoSLevels = new ArrayList<>(topics.size());
        for (int i = 0; i < topics.size(); i++) {
            grantedQoSLevels.add(mqttSubscribeMessage.payload().topicSubscriptions().get(i).qualityOfService().value());
        }
        //	构建返回报文	有效负载
        MqttSubAckPayload payloadBack = new MqttSubAckPayload(grantedQoSLevels);
        //	构建返回报文	固定报头
        MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(MqttMessageType.SUBACK, false, MqttQoS.AT_MOST_ONCE, false, 2 + topics.size());
        //	构建返回报文	订阅确认
        MqttSubAckMessage subAck = new MqttSubAckMessage(mqttFixedHeaderBack, variableHeaderBack, payloadBack);
        log.debug("back--" + subAck);
        channel.writeAndFlush(subAck);
    }

    /**
     * 取消订阅确认
     *
     * @param channel
     * @param mqttMessage
     */
    public static void unsuback(Channel channel, MqttMessage mqttMessage) {


        MqttMessageIdVariableHeader messageIdVariableHeader = (MqttMessageIdVariableHeader) mqttMessage.variableHeader();
        //	构建返回报文	可变报头
        MqttMessageIdVariableHeader variableHeaderBack = MqttMessageIdVariableHeader.from(messageIdVariableHeader.messageId());
        //	构建返回报文	固定报头
        MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(MqttMessageType.UNSUBACK, false, MqttQoS.AT_MOST_ONCE, false, 2);
        //	构建返回报文	取消订阅确认
        MqttUnsubAckMessage unSubAck = new MqttUnsubAckMessage(mqttFixedHeaderBack, variableHeaderBack);
        log.debug("back--" + unSubAck);
        channel.writeAndFlush(unSubAck);
    }

    /**
     * 心跳响应
     *
     * @param channel
     * @param mqttMessage
     */
    public static void pingresp(Channel channel, MqttMessage mqttMessage) {
        //	心跳响应报文	11010000 00000000  固定报文
        MqttFixedHeader fixedHeader = new MqttFixedHeader(MqttMessageType.PINGRESP, false, MqttQoS.AT_MOST_ONCE, false, 0);
        MqttMessage mqttMessageBack = new MqttMessage(fixedHeader);
        log.debug("back--" + mqttMessageBack);
        channel.writeAndFlush(mqttMessageBack);
    }


}