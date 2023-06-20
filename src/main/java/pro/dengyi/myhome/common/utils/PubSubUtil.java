package pro.dengyi.myhome.common.utils;

import com.lmax.disruptor.RingBuffer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.common.pubsub.Event;
import pro.dengyi.myhome.common.pubsub.EventType;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/20 15:39
 * @description：
 * @modified By：
 */
@Slf4j
@Component
public class PubSubUtil {
    @Autowired
    private RingBuffer<Event> ringBuffer;


    public void publish(EventType type, String message) {
        long next = ringBuffer.next();
        try {
            Event event = ringBuffer.get(next);
            event.setEventType(type);
            event.setMessage(message);
        } catch (Exception e) {
            log.error("failed to add event to messageModelRingBuffer:{}", e.getMessage());
        } finally {
            ringBuffer.publish(next);
        }
    }
}
