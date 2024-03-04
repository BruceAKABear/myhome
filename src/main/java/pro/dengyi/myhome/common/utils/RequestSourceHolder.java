package pro.dengyi.myhome.common.utils;

import pro.dengyi.myhome.common.enums.RequestSourceEnum;

/**
 * @author DengYi
 * @version v1.0
 */
public class RequestSourceHolder {

    private static final ThreadLocal<RequestSourceEnum> LOCAL = new ThreadLocal<>();

    public static RequestSourceEnum getSource() {
        return LOCAL.get();
    }

    public static void setSource(RequestSourceEnum requestSourceEnum) {
        LOCAL.set(requestSourceEnum);
    }

    public static void remove() {
        LOCAL.remove();
    }
}
