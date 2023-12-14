package pro.dengyi.myhome.common.mqtt;

import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerAdapter;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.mqtt.MqttFixedHeader;
import io.netty.handler.codec.mqtt.MqttMessage;
import lombok.extern.slf4j.Slf4j;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/11/13 10:48
 * @description：
 * @modified By：
 */
@Slf4j
public class MqttHandler extends ChannelHandlerAdapter {


    @Override
    public void channelRead(ChannelHandlerContext ctx, Object msg) {
        if (msg == null) {
            log.error("mqtt client connect server error,message is null");
            return;
        }
        MqttMessage mqttMessage = (MqttMessage) msg;
        log.info("receive message from device,message is:{}", mqttMessage);
        MqttFixedHeader mqttFixedHeader = mqttMessage.fixedHeader();
        Channel channel = ctx.channel();

        switch (mqttFixedHeader.messageType()) {
            case CONNECT:
                //todo do auth control in this type of message


                //	在一个网络连接上，客户端只能发送一次CONNECT报文。服务端必须将客户端发送的第二个CONNECT报文当作协议违规处理并断开客户端的连接
                //	to do 建议connect消息单独处理，用来对客户端进行认证管理等 这里直接返回一个CONNACK消息
                MqttMsgBack.connack(channel, mqttMessage);

            case PUBLISH:        //	客户端发布消息
                //	PUBACK报文是对QoS 1等级的PUBLISH报文的响应
                System.out.println("123");
                MqttMsgBack.puback(channel, mqttMessage);
                break;
            case PUBREL:        //	发布释放
                //	PUBREL报文是对PUBREC报文的响应
                //	to do
                MqttMsgBack.pubcomp(channel, mqttMessage);
                break;
            case SUBSCRIBE:        //	客户端订阅主题
                //	客户端向服务端发送SUBSCRIBE报文用于创建一个或多个订阅，每个订阅注册客户端关心的一个或多个主题。
                //	为了将应用消息转发给与那些订阅匹配的主题，服务端发送PUBLISH报文给客户端。
                //	SUBSCRIBE报文也（为每个订阅）指定了最大的QoS等级，服务端根据这个发送应用消息给客户端
                // 	to do
                MqttMsgBack.suback(channel, mqttMessage);
                break;
            case UNSUBSCRIBE:    //	客户端取消订阅
                //	客户端发送UNSUBSCRIBE报文给服务端，用于取消订阅主题
                //	to do
                MqttMsgBack.unsuback(channel, mqttMessage);
                break;
            case PINGREQ:        //	客户端发起心跳
                //	客户端发送PINGREQ报文给服务端的
                //	在没有任何其它控制报文从客户端发给服务的时，告知服务端客户端还活着
                //	请求服务端发送 响应确认它还活着，使用网络以确认网络连接没有断开
                MqttMsgBack.pingresp(channel, mqttMessage);
                break;
            case DISCONNECT:    //	客户端主动断开连接
                //	DISCONNECT报文是客户端发给服务端的最后一个控制报文， 服务端必须验证所有的保留位都被设置为0
                //	to do
                break;
            default:
                break;
        }

    }

}