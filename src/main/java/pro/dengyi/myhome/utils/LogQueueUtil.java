package pro.dengyi.myhome.utils;

import java.util.concurrent.LinkedBlockingQueue;
import pro.dengyi.myhome.model.system.OperationLog;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/28 9:57
 * @description：操作日志队列
 * @modified By：
 */
public class LogQueueUtil {

  static LinkedBlockingQueue<OperationLog> queue = new LinkedBlockingQueue(1000);

  public static boolean publish(OperationLog log) {
    boolean flag;
    try {
      queue.put(log);
      flag = true;
    } catch (InterruptedException e) {
      flag = false;
    }
    return flag;
  }

  public static OperationLog consume() {
    OperationLog log;
    try {
      log = queue.take();
    } catch (InterruptedException e) {
      log = null;
    }
    return log;
  }

}
