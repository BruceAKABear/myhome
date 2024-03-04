package pro.dengyi.myhome.mqtt;

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
import io.netty.handler.timeout.IdleStateHandler;
import org.springframework.context.ApplicationContext;

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

    private ApplicationContext applicationContext;


    public MqttServer(Integer port, ApplicationContext applicationContext) {
        this.port = port;
        this.applicationContext = applicationContext;
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
            serverBootstrap
                    .option(ChannelOption.SO_REUSEADDR, true)
                    .option(ChannelOption.SO_BACKLOG, 1024)
                    .option(ChannelOption.ALLOCATOR, ByteBufAllocator.DEFAULT)
                    .option(ChannelOption.SO_RCVBUF, 10485760);

            serverBootstrap.childHandler(
                    new ChannelInitializer<NioSocketChannel>() {
                        @Override
                        protected void initChannel(
                                NioSocketChannel ch) throws Exception {
                            ChannelPipeline channelPipeline = ch.pipeline();
                            channelPipeline.addLast(
                                    new IdleStateHandler(600, 600, 1200));
                            channelPipeline.addLast("encoder",
                                    new MyMqttEncoder());
                            channelPipeline.addLast("decoder",
                                    new MqttDecoder());
                            channelPipeline.addLast(
                                    new MqttHandler(applicationContext));
                            channelPipeline.addLast(new CustomExceptionHandler());
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
