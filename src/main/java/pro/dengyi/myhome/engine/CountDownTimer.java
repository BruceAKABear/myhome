package pro.dengyi.myhome.engine;

import java.util.TimerTask;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/3/1 15:04
 * @description：倒计时计时器
 * @modified By：
 */
public class CountDownTimer {

  private TimerTask timerTask;
  private long time;

  public CountDownTimer(long time) {
    this.time = time;
  }

  public void start() {
    timerTask = new TimerTask() {
      @Override
      public void run() {
        if (time == 0) {
          System.out.println("倒计时结束");
          cancel();
        } else {
          System.out.println("倒计时：" + time + "s");
          time--;
        }
      }
    };
    java.util.Timer timer = new java.util.Timer();
    timer.schedule(timerTask, 0, 1000);
  }

}
