package pro.dengyi.myhome.common.pubsub;

import com.lmax.disruptor.WorkHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.dao.ApiProcessingTimeDao;
import pro.dengyi.myhome.model.system.ApiProcessingTime;

import java.time.LocalDateTime;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/20 15:18
 * @description：
 * @modified By：
 */
@Slf4j
@Component
public class EventHandler implements WorkHandler<Event> {
    private ApplicationContext applicationContext;

    public EventHandler(ApplicationContext applicationContext) {
        this.applicationContext = applicationContext;
    }


    @Override
    public void onEvent(Event event) throws Exception {
        System.err.println("thread is:" + Thread.currentThread().getName() + ":" + event.getEventType());

        switch (event.getEventType()) {
            case DEVICE_REPORT:
                Thread.sleep(1000);
                break;
            case API_PROCESS_TIME:
                ApiProcessingTime processingTime = new ApiProcessingTime();
                processingTime.setUri((String) event.getParams().get("requestURI"));
                processingTime.setTimes(Integer.parseInt(String.valueOf(event.getParams().get("timems"))));
                processingTime.setCreateTime(LocalDateTime.now());
                processingTime.setUpdateTime(LocalDateTime.now());
                ApiProcessingTimeDao apiProcessingTimeDao = (ApiProcessingTimeDao) applicationContext.getBean("apiProcessingTimeDao");
                apiProcessingTimeDao.insert(processingTime);
                break;
            case NOTIFY_USER:
                Thread.sleep(10000);

                break;
            default:
                log.error("not supported event type in event handler:{}", event.getEventType());
        }


    }
}
