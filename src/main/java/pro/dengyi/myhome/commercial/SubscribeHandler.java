package pro.dengyi.myhome.commercial;

import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * the handler for control plan
 *
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/11/2 15:01
 * @description：
 * @modified By：
 */

@Component
public class SubscribeHandler {
    @PostConstruct
    public void getSubscribePlan() {
        String deviceMac = "abccd";
    }


    /**
     * an async timer to check online  subscribe plan to control how many devices the hardware can connect
     * <p>
     * every 5 min
     */
    @Scheduled(cron = "0 0/5 * * * ? ")
    @Async
    public void subscribePlanCheck() {
        getSubscribePlan();
    }


}
