package pro.dengyi.myhome.utils.queue;

import java.util.Map;
import java.util.concurrent.LinkedBlockingQueue;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/28 9:57
 * @description：操作日志队列
 * @modified By：
 */
public class RoomSelectQueue {

  static LinkedBlockingQueue<Map<String, String>> queue = new LinkedBlockingQueue(1000);

  public static boolean publish(Map<String, String> param) {
    boolean flag;
    try {
      queue.put(param);
      flag = true;
    } catch (InterruptedException e) {
      flag = false;
    }
    return flag;
  }

  public static Map<String, String> consume() {
    Map<String, String> param;
    try {
      param = queue.take();
    } catch (InterruptedException e) {
      param = null;
    }
    return param;
  }

}
