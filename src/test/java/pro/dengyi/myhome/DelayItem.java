package pro.dengyi.myhome;

import java.util.concurrent.Delayed;
import java.util.concurrent.TimeUnit;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/9/6 13:10
 * @description：
 * @modified By：
 */
public class DelayItem implements Delayed {

    private long expireTime;

    public String getOrderCode() {
        return orderCode;
    }

    private String orderCode;


    public DelayItem(long expireTime, String orderCode) {
        this.expireTime = TimeUnit.MILLISECONDS.convert(expireTime, TimeUnit.SECONDS) + System.currentTimeMillis();
        this.orderCode = orderCode;
    }

    @Override
    public long getDelay(TimeUnit unit) {
        return expireTime - System.currentTimeMillis();
    }

    @Override
    public int compareTo(Delayed o) {
        return Long.valueOf(expireTime).compareTo(Long.valueOf(((DelayItem) o).expireTime));
    }
}
