package pro.dengyi.myhome.common.pubsub;

import com.lmax.disruptor.WorkHandler;
import lombok.extern.slf4j.Slf4j;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/20 15:18
 * @description：
 * @modified By：
 */
@Slf4j
public class EventHandler implements WorkHandler<Event> {
    @Override
    public void onEvent(Event event) throws Exception {
        System.err.println("thread is:" + Thread.currentThread().getName());

        switch (event.getEventType()) {
            case DEVICE_REPORT:
                break;
            default:
                log.error("not supported event type in event handler:{}", event.getEventType());
        }


    }
}
