package pro.dengyi.myhome.common.pubsub;

import com.lmax.disruptor.RingBuffer;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/20 15:39
 * @description：
 * @modified By：
 */
@Slf4j
@Component
public class PubAndSubService {
    @Autowired
    private RingBuffer<Event> ringBuffer;


    public void publish(EventTypeEnum type, Object param) {
        long next = ringBuffer.next();
        try {
            Event event = ringBuffer.get(next);
            event.setEventTypeEnum(type);
            event.setParams(param);
        } catch (Exception e) {
            log.error("failed to add event to messageModelRingBuffer:{}", e.getMessage());
        } finally {
            ringBuffer.publish(next);
        }
    }
}
