package pro.dengyi.myhome.common.utils;

/**
 * @author DengYi
 * @version v1.0
 */
public class FamilyHolder {

    private static final ThreadLocal<String> LOCAL = new ThreadLocal<>();

    public static String familyId() {
        return LOCAL.get();
    }

    public static void setFamilyId(String familyId) {
        LOCAL.set(familyId);
    }

    public static void remove() {
        LOCAL.remove();
    }
}
