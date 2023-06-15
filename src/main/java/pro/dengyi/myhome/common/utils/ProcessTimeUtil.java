package pro.dengyi.myhome.common.utils;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/15 14:48
 * @description：接口请求时间工具类
 * @modified By：
 */
public class ProcessTimeUtil {
    private static final ThreadLocal<Long> THREAD_LOCAL = new ThreadLocal<>();


    public static void mark() {
        THREAD_LOCAL.set(System.currentTimeMillis());
    }

    public static long processTime() {
        long time = System.currentTimeMillis() - THREAD_LOCAL.get();
        THREAD_LOCAL.remove();
        return time;
    }

}
