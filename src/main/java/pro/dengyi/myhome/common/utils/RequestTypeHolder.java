package pro.dengyi.myhome.common.utils;

import pro.dengyi.myhome.common.enums.RequestType;

/**
 * @author DengYi
 * @version v1.0
 */
public class RequestTypeHolder {

    private static final ThreadLocal<RequestType> LOCAL = new ThreadLocal<>();

    public static RequestType getType() {
        return LOCAL.get();
    }

    public static void setType(RequestType requestType) {
        LOCAL.set(requestType);
    }

    public static void remove() {
        LOCAL.remove();
    }
}
