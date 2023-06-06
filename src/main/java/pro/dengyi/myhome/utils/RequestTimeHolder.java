package pro.dengyi.myhome.utils;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/20 9:08
 * @description：请求时间缓存
 * @modified By：
 */
public class RequestTimeHolder {

    private static final ThreadLocal<Long> LOCAL = new ThreadLocal<>();

    public static void setStartTime() {
        LOCAL.set(System.currentTimeMillis());
    }

    public static Long getTimeDifference() {
        return System.currentTimeMillis() - LOCAL.get();
    }


    public static void remove() {
        LOCAL.remove();

    }

}
