package pro.dengyi.myhome.common.utils;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/28 8:47
 * @description：推送工具类
 * @modified By：
 */
@Component
public class PushUtil {


    /**
     * 设备状态推送
     *
     * @param deviceId      设备id
     * @param currentStatus 当前设备状态
     */
    public static void deviceStatusChangePush(String deviceId, String roomId, Object currentStatus) {
        Map<String, Object> pushParams = new HashMap<>(3);
        pushParams.put("type", "deviceStatusChange");
        pushParams.put("deviceId", deviceId);
        pushParams.put("roomId", roomId);
        pushParams.put("currentStatus", currentStatus);
//        //推送至前端
//        AppWebsocket.sendMessage2Device(JSON.toJSONString(pushParams));
//        //推送至管理后台
//        BackendWebsocket.sendMessage2Device(JSON.toJSONString(pushParams));
    }

    /**
     * 设备在离线状态推送
     *
     * @param deviceId  设备id
     * @param onOffLine 在离线装填
     */
    public static void onOffLinePush(String deviceId, String deviceName, boolean onOffLine) {
        Map<String, Object> pushParams = new HashMap<>(3);
        pushParams.put("type", "deviceOnOffLine");
        pushParams.put("deviceId", deviceId);
        pushParams.put("deviceName", deviceName);
        pushParams.put("onOff", onOffLine);
//        //推送至前端
//        AppWebsocket.sendMessage2Device(JSON.toJSONString(pushParams));
//        //推送至管理后台
//        BackendWebsocket.sendMessage2Device(JSON.toJSONString(pushParams));
    }

    public static void positionPush(String userId, String floorId, String roomId) {
        Map<String, Object> pushParams = new HashMap<>(3);
        pushParams.put("type", "positionChange");
        pushParams.put("floorId", floorId);
        pushParams.put("roomId", roomId);
        //推送至前端
//        AppWebsocket.sendMessage2Device(userId, JSON.toJSONString(pushParams));
    }

}
