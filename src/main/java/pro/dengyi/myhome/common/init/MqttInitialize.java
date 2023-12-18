package pro.dengyi.myhome.common.init;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.common.mqtt.MqttServer;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/12/13 15:12
 * @description：
 * @modified By：
 */
//@Component
public class MqttInitialize {


    @EventListener(ApplicationReadyEvent.class)
    public void initCache() {
        MqttServer mqttServer = new MqttServer(1883);
        mqttServer.startUp();
    }
}
