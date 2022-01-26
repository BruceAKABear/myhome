package pro.dengyi.myhome.listener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.listener.KeyExpirationEventMessageListener;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.stereotype.Component;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.model.Device;


/**
 * redis过期监听器
 *
 * @author DengYi
 * @version v1.0
 */
@Component
public class RedisExpireListener extends KeyExpirationEventMessageListener {
    @Autowired
    private DeviceDao deviceDao;

    public RedisExpireListener(RedisMessageListenerContainer listenerContainer) {
        super(listenerContainer);
    }

    @Override
    public void onMessage(Message message, byte[] pattern) {
        String expiredKey = message.toString();
        // 设备离线更新数据库
        if (expiredKey.startsWith("onlineDevice:")) {
            String deviceId = expiredKey.substring(expiredKey.lastIndexOf(":") + 1);
            Device device = deviceDao.selectById(deviceId);
            device.setOnline(false);
            deviceDao.updateById(device);
            // todo 如果设备绑定家庭且家庭有用户在线则推送离线消息
            // todo 如果用户在设备页websocket推送设备离线状态
        }
    }
}
