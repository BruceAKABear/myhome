package pro.dengyi.myhome.common.mqtt;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.buffer.ByteBufAllocator;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.codec.mqtt.MqttDecoder;
import io.netty.handler.codec.mqtt.MqttEncoder;
import io.netty.handler.timeout.IdleStateHandler;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/11/13 10:36
 * @description：
 * @modified By：
 */
public class MqttServer {

    private NioEventLoopGroup bossGroup;
    private NioEventLoopGroup workerGroup;
    private final Integer port;


    public MqttServer(Integer port) {
        this.port = port;
    }

    public void startUp() {
        //默认情况下线程大小是核心数乘以2
        bossGroup = new NioEventLoopGroup();
        workerGroup = new NioEventLoopGroup();
        ServerBootstrap serverBootstrap = new ServerBootstrap();
        serverBootstrap.group(bossGroup, workerGroup);
        serverBootstrap.channel(NioServerSocketChannel.class);


        try {
            //tcp参数配置
            serverBootstrap.option(ChannelOption.SO_REUSEADDR, true).option(ChannelOption.SO_BACKLOG, 1024).option(ChannelOption.ALLOCATOR, ByteBufAllocator.DEFAULT).option(ChannelOption.SO_RCVBUF, 10485760);
            serverBootstrap.childHandler(new ChannelInitializer<NioSocketChannel>() {
                @Override
                protected void initChannel(NioSocketChannel ch) throws Exception {
                    ChannelPipeline channelPipeline = ch.pipeline();
                    channelPipeline.addLast(new IdleStateHandler(600, 600, 1200));
                    channelPipeline.addLast("encoder", MqttEncoder.DEFAUL_ENCODER);
                    channelPipeline.addLast("decoder", new MqttDecoder());
                    channelPipeline.addLast(new MqttHandler());
                }
            });
            ChannelFuture channelFuture = serverBootstrap.bind(port).sync();
            if (channelFuture.isSuccess()) {
                channelFuture.channel().closeFuture().sync();
            } else {
                System.out.println("startup fail port = " + port);
            }
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }


    }

    public void shoutDown() {
        if (bossGroup != null && workerGroup != null) {
            try {
                bossGroup.shutdownGracefully().sync();
                workerGroup.shutdownGracefully().sync();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
