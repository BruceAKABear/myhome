package pro.dengyi.myhome.common.utils;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import lombok.extern.slf4j.Slf4j;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.model.system.User;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.UUID;

/**
 * token工具类
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Slf4j
public class TokenUtil {
    static Cache<Object, Object> caffeine;

    static {
        caffeine = Caffeine.newBuilder().build();
    }

    private static final Integer LOGIN_EXPIRE_SECONDS = 60 * 60;


    public static String genToken(User user) {
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        HashMap<String, Object> map = new HashMap<>();
        map.put("userData", user);
        map.put("loginDateTime", LocalDateTime.now());
        caffeine.put(uuid, map);
        return uuid;
    }

    /**
     * 解析token
     *
     * @param token
     * @return
     */
    public static User decToken(String token) {
        Object ifPresent = caffeine.getIfPresent(token);
        if (ifPresent == null) {
            throw new BusinessException(1, "not login");
        }
        HashMap<String, Object> map = (HashMap<String, Object>) ifPresent;
        LocalDateTime loginDateTime = (LocalDateTime) map.get("loginDateTime");
        if (LocalDateTime.now().isAfter(loginDateTime.plusSeconds(LOGIN_EXPIRE_SECONDS))) {
            throw new BusinessException(1, "login expire");
        }
        return (User) map.get("userData");
    }
}
