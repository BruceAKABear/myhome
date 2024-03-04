package pro.dengyi.myhome.mqtt;

import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.handler.codec.DecoderException;

public class CustomExceptionHandler extends ChannelInboundHandlerAdapter {

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
        if (cause instanceof DecoderException) {
            // Handle DecoderException here
            System.err.println("Decoder Exception occurred");
            // You can take appropriate actions or send a response to the client
        } else {
            // If it's not a DecoderException, propagate the exception to the next handler
            ctx.fireExceptionCaught(cause);
        }
    }
}