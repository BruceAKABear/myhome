package pro.dengyi.myhome.common.utils;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.concurrent.TimeUnit;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/8/8 15:28
 * @description：
 * @modified By：
 */
public class IpRateLimiter {

    private static final Cache<Object, Object> caffeine;

    //限制多少秒可以请求一次
    private static final Integer ONCE_PER_MILLION = 10;

    static {
        caffeine = Caffeine.newBuilder().expireAfterAccess(30, TimeUnit.MINUTES).initialCapacity(100).build();
    }


    public static Boolean tryAcquire(String clientIp, String requestUri) {
        Object ifPresent = caffeine.getIfPresent(clientIp + ":" + requestUri);
        if (ifPresent == null) {
            caffeine.put(clientIp + ":" + requestUri, LocalDateTime.now());
            return true;
        }
        LocalDateTime timeSave = (LocalDateTime) ifPresent;
        LocalDateTime timePlus = timeSave.plus(ONCE_PER_MILLION, ChronoUnit.MILLIS);
        if (timePlus.isAfter(timeSave)) {
            caffeine.put(clientIp + requestUri, LocalDateTime.now());
            return true;
        }

        return false;
    }


}
