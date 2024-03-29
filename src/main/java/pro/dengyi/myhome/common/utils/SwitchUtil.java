package pro.dengyi.myhome.common.utils;

import java.util.ArrayList;
import java.util.List;

public class SwitchUtil {

    public static <T> List<T> objToList(Object obj, Class<T> cla) {
        List<T> list = new ArrayList<T>();

        if (obj instanceof ArrayList<?>) {
            for (Object o : (List<?>) obj) {
                list.add(cla.cast(o));
            }
            return list;
        }
        return null;
    }
}
