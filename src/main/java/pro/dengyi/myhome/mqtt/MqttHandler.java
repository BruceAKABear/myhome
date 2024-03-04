package pro.dengyi.myhome.mqtt;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.Scheduler;
import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerAdapter;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import pro.dengyi.myhome.model.device.Device;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/11/13 10:48
 * @description：
 * @modified By：
 */
@Slf4j
public class MqttHandler extends ChannelHandlerAdapter {
    //supported version
    public static final String PROTOCOL_VERSION = "4";
    ObjectMapper objectMapper = new ObjectMapper();


    static Cache<String, Object> cache;
    private ApplicationContext applicationContext;

    static {
        cache = Caffeine.newBuilder().scheduler(
                        Scheduler.forScheduledExecutorService(
                                Executors.newScheduledThreadPool(1)))
                .expireAfterAccess(60, TimeUnit.SECONDS).removalListener(
                        (key, value, cause) -> System.err.println(
                                "过期" + key + ":" + value + ":" + cause))
                .build();
    }


    public MqttHandler(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }

    /**
     * we validate all message for safe,the first thing is do validate
     *
     * @param ctx
     * @param msg
     */
    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) {
        //safe validate
        if (!safeCheck(ctx, msg)) {
            return;
        }
        MqttMessage mqttMessage = (MqttMessage) msg;
        MqttFixedHeader mqttFixedHeader = mqttMessage.fixedHeader();
        Object variableHeader = mqttMessage.variableHeader();
        Channel channel = ctx.channel();

        switch (mqttFixedHeader.messageType()) {
            case CONNECT:
                handleConnect(channel, mqttMessage);
                break;
            case PUBLISH:
                handlePublish(channel,mqttMessage);
                //	客户端发布消息
                //	PUBACK报文是对QoS 1等级的PUBLISH报文的响应
                System.out.println(mqttMessage);
                MqttMsgBack.puback(channel, mqttMessage);
                break;
            case PUBREL:        //	发布释放
                //	PUBREL报文是对PUBREC报文的响应
                //	to do
                MqttMsgBack.pubcomp(channel, mqttMessage);
                break;
            case SUBSCRIBE:
                handleSubscribe(channel, mqttMessage);
                break;
            case UNSUBSCRIBE:    //	客户端取消订阅
                //	客户端发送UNSUBSCRIBE报文给服务端，用于取消订阅主题
                //	to do
                MqttMsgBack.unsuback(channel, mqttMessage);
                break;
            case PINGREQ:
                handlePing(channel);
                break;
            case DISCONNECT:
                handleDiscount(channel);
                break;
            default:
                log.error("unsupported type of mqtt header");
                break;
        }

    }

    private void handlePublish(Channel channel, MqttMessage mqttMessage) {

        MqttPublishMessage mqttPublishMessage = (MqttPublishMessage) mqttMessage;
        MqttFixedHeader mqttFixedHeaderInfo = mqttPublishMessage.fixedHeader();
        MqttQoS qos = mqttFixedHeaderInfo.qosLevel();
        byte[] headBytes = new byte[mqttPublishMessage.payload().readableBytes()];
        mqttPublishMessage.payload().readBytes(headBytes);
        String data = new String(headBytes);


    }

    /**
     * judgement
     *
     * @param channel
     * @param mqttMessage
     */
    private void handleSubscribe(Channel channel, MqttMessage mqttMessage) {

        MqttSubscribeMessage mqttSubscribeMessage = (MqttSubscribeMessage) mqttMessage;
        MqttMessageIdVariableHeader messageIdVariableHeader = mqttSubscribeMessage.variableHeader();
        //	构建返回报文， 可变报头
        MqttMessageIdVariableHeader variableHeaderBack = MqttMessageIdVariableHeader.from(
                messageIdVariableHeader.messageId());
        Set<String> topics = mqttSubscribeMessage.payload().topicSubscriptions()
                .stream()
                .map(mqttTopicSubscription -> mqttTopicSubscription.topicName())
                .collect(Collectors.toSet());
        //log.info(topics.toString());
        List<Integer> grantedQoSLevels = new ArrayList<>(topics.size());
        for (int i = 0; i < topics.size(); i++) {
            grantedQoSLevels.add(
                    mqttSubscribeMessage.payload().topicSubscriptions().get(i)
                            .qualityOfService().value());
        }
        //	构建返回报文	有效负载
        MqttSubAckPayload payloadBack = new MqttSubAckPayload(grantedQoSLevels);
        //	构建返回报文	固定报头
        MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(
                MqttMessageType.SUBACK, false, MqttQoS.AT_MOST_ONCE, false,
                2 + topics.size());
        //	构建返回报文	订阅确认
        MqttSubAckMessage subAck = new MqttSubAckMessage(mqttFixedHeaderBack,
                variableHeaderBack, payloadBack);
        log.debug("back--" + subAck);
        channel.writeAndFlush(subAck);


    }

    private void handlePing(Channel channel) {
        String deviceAddress = channel.remoteAddress().toString();
        Device device = (Device) cache.getIfPresent(deviceAddress);
        log.info("ping from device:{}", device.getId());
        MqttFixedHeader fixedHeader = new MqttFixedHeader(
                MqttMessageType.PINGRESP, false, MqttQoS.AT_MOST_ONCE, false,
                0);
        MqttMessage mqttMessageBack = new MqttMessage(fixedHeader);
        channel.writeAndFlush(mqttMessageBack);
    }

    /**
     * 1. check ip
     * 2. check  mqtt version
     *
     * @param ctx
     * @param msg
     * @return
     */
    private boolean safeCheck(ChannelHandlerContext ctx, Object msg) {
        //we need to escape connect
        boolean trough = true;
        MqttMessage mqttMessage = (MqttMessage) msg;
        MqttFixedHeader mqttFixedHeader = mqttMessage.fixedHeader();
        if (!mqttFixedHeader.messageType().equals(MqttMessageType.CONNECT)) {
            //todo msg validate
            Channel channel = ctx.channel();
            String deviceAddress = channel.remoteAddress().toString();
            Object deviceLogin = cache.getIfPresent(deviceAddress);
            if (deviceLogin == null) {
                MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(
                        MqttMessageType.CONNACK, false, MqttQoS.AT_MOST_ONCE,
                        false, 0x02);
                MqttConnAckVariableHeader mqttConnAckVariableHeaderBack = new MqttConnAckVariableHeader(
                        MqttConnectReturnCode.CONNECTION_REFUSED_NOT_AUTHORIZED);
                MqttConnAckMessage connAck = new MqttConnAckMessage(
                        mqttFixedHeaderBack, mqttConnAckVariableHeaderBack);
                channel.writeAndFlush(connAck);
                trough = false;
            }
        }


        return trough;

    }

    private void versionControl(ChannelHandlerContext ctx) {
        Channel channel = ctx.channel();
        String deviceAddress = channel.remoteAddress().toString();
        Object deviceLogin = cache.getIfPresent(deviceAddress);
    }

    /**
     * 处理mqtt连接逻辑
     * <p>
     * ip认证权重最高，基于DHCP租期到时ip会改变，基于clientID 进行第二重验证
     * <p>
     * 1.校验mqtt版本
     *
     * @param channel
     * @param mqttMessage
     */
    private void handleConnect(Channel channel, MqttMessage mqttMessage) {
        String deviceAddress = channel.remoteAddress().toString();
        Object deviceLogin = cache.getIfPresent(deviceAddress);
        MqttConnectMessage mqttConnectMessage = (MqttConnectMessage) mqttMessage;
        if (deviceLogin == null) {
            //查询设备clientid不在系统中，不允许连接，走缓存加速
            String clientId = mqttConnectMessage.payload().clientIdentifier();
            Cache deviceCache = (Cache) applicationContext.getBean(
                    "deviceCache");
            Object device = deviceCache.getIfPresent(clientId);
            if (device == null) {
                MqttFixedHeader fixedHeader = mqttConnectMessage.fixedHeader();
                MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(
                        MqttMessageType.CONNACK, fixedHeader.isDup(),
                        MqttQoS.AT_MOST_ONCE, fixedHeader.isRetain(), 0x02);
                MqttConnAckVariableHeader mqttConnAckVariableHeaderBack = new MqttConnAckVariableHeader(
                        MqttConnectReturnCode.CONNECTION_REFUSED_IDENTIFIER_REJECTED);
                MqttConnAckMessage connAck = new MqttConnAckMessage(
                        mqttFixedHeaderBack, mqttConnAckVariableHeaderBack);
                channel.writeAndFlush(connAck);
            } else {
                MqttFixedHeader fixedHeader = mqttConnectMessage.fixedHeader();
                MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(
                        MqttMessageType.CONNACK, fixedHeader.isDup(),
                        MqttQoS.AT_MOST_ONCE, fixedHeader.isRetain(), 0x02);
                MqttConnAckVariableHeader mqttConnAckVariableHeaderBack = new MqttConnAckVariableHeader(
                        MqttConnectReturnCode.CONNECTION_ACCEPTED);
                MqttConnAckMessage connAck = new MqttConnAckMessage(
                        mqttFixedHeaderBack, mqttConnAckVariableHeaderBack);
                channel.writeAndFlush(connAck);
                cache.put(deviceAddress, device);
            }
        } else {
            //why?
            //在一个网络连接上，客户端只能发送一次CONNECT报文。服务端必须将客户端发送的第二个CONNECT报文当作协议违规处理并断开客户端的连接
            //已经登录过，再次登录，踢掉
            MqttFixedHeader fixedHeader = mqttConnectMessage.fixedHeader();
            MqttFixedHeader mqttFixedHeaderBack = new MqttFixedHeader(
                    MqttMessageType.CONNACK, fixedHeader.isDup(),
                    MqttQoS.AT_MOST_ONCE, fixedHeader.isRetain(), 0x02);
            MqttConnAckVariableHeader mqttConnAckVariableHeaderBack = new MqttConnAckVariableHeader(
                    MqttConnectReturnCode.CONNECTION_ACCEPTED);
            MqttConnAckMessage connAck = new MqttConnAckMessage(
                    mqttFixedHeaderBack, mqttConnAckVariableHeaderBack);
            channel.writeAndFlush(connAck);
        }
    }

    private void handleDiscount(Channel channel) {
        String deviceAddress = channel.remoteAddress().toString();
        cache.invalidate(deviceAddress);
    }

}
