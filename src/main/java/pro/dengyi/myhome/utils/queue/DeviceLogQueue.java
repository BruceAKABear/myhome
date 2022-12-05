package pro.dengyi.myhome.utils.queue;

import java.util.concurrent.LinkedBlockingQueue;
import pro.dengyi.myhome.model.device.DeviceLog;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/28 9:57
 * @description：操作日志队列
 * @modified By：
 */
public class DeviceLogQueue {

  static LinkedBlockingQueue<DeviceLog> queue = new LinkedBlockingQueue(1000);

  public static boolean publish(DeviceLog log) {
    boolean flag;
    try {
      queue.put(log);
      flag = true;
    } catch (InterruptedException e) {
      flag = false;
    }
    return flag;
  }

  public static DeviceLog consume() {
    DeviceLog log;
    try {
      log = queue.take();
    } catch (InterruptedException e) {
      log = null;
    }
    return log;
  }

}
