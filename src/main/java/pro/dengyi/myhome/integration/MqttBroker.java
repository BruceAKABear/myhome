package pro.dengyi.myhome.integration;

import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/3/7 16:52
 * @description：mqttbroker整合接口
 * @modified By：
 */
public interface MqttBroker {


    /**
     * 设备登录
     *
     * @return true auth pass,false auth fail
     */
    Boolean deviceLogin(Map<String, String> params);


    /**
     * broker设备状态改变回调
     *
     * @return
     */
    Boolean callBack(Map<String, String> params);

}
