package pro.dengyi.myhome.common.config;

import com.lmax.disruptor.BlockingWaitStrategy;
import com.lmax.disruptor.RingBuffer;
import com.lmax.disruptor.dsl.Disruptor;
import com.lmax.disruptor.dsl.ProducerType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.CustomizableThreadFactory;
import pro.dengyi.myhome.common.pubsub.Event;
import pro.dengyi.myhome.common.pubsub.EventFactory;
import pro.dengyi.myhome.common.pubsub.EventHandler;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/20 15:19
 * @description：
 * @modified By：
 */
@Configuration
public class PubSubConfig {

    @Bean
    public RingBuffer<Event> ringBuffer() {
        Disruptor<Event> disruptor = new Disruptor<>(new EventFactory(), 8,
                new CustomizableThreadFactory("disruptor-thread-"), ProducerType.SINGLE,
                new BlockingWaitStrategy());
        int availableProcessors = Runtime.getRuntime().availableProcessors();
        EventHandler[] eventHandlers = new EventHandler[availableProcessors];
        for (int i = 0; i < availableProcessors; i++) {
            eventHandlers[i] = new EventHandler();
        }
        disruptor.handleEventsWithWorkerPool(eventHandlers);
        disruptor.start();
        return disruptor.getRingBuffer();
    }
}
