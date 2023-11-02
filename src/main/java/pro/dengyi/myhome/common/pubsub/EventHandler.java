package pro.dengyi.myhome.common.pubsub;

import com.lmax.disruptor.WorkHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.dao.OperationLogDao;
import pro.dengyi.myhome.model.system.OperationLog;

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
        switch (event.getEventTypeEnum()) {
            case DEVICE_REPORT:
                Thread.sleep(1000);
                break;
            case OPERATION_LOG:
                OperationLogDao operationLogDao = applicationContext.getBean(OperationLogDao.class);
                OperationLog params = (OperationLog) event.getParams();
                operationLogDao.insert(params);

            case NOTIFY_USER:
                Thread.sleep(10000);

                break;
            default:
                log.error("not supported event type in event handler event is:{}", event.getEventTypeEnum());
        }


    }
}
