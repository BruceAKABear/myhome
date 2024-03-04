package pro.dengyi.myhome.common.init;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.ApplicationContext;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.mqtt.MqttServer;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/12/13 15:12
 * @description：
 * @modified By：
 */
@Component
public class MqttInitialize {
    @Autowired
    private ApplicationContext applicationContext;


    @EventListener(ApplicationReadyEvent.class)
    @Async
    public void initCache() {
        MqttServer mqttServer = new MqttServer(1883, applicationContext);
        mqttServer.startUp();
    }
}
