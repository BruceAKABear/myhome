package pro.dengyi.myhome.common.utils;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import lombok.extern.slf4j.Slf4j;
import org.checkerframework.checker.nullness.qual.NonNull;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.common.response.Response;
import pro.dengyi.myhome.model.system.User;

import java.time.Duration;
import java.util.UUID;
import java.util.concurrent.ConcurrentMap;


/**
 * 用户工具类
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Slf4j
public class UserUtil {
    //过期时间1小时
    private static final Integer LOGIN_EXPIRE_SECONDS = 60 * 60;
    static Cache<Object, Object> caffeine;

    static {
        caffeine = Caffeine.newBuilder().expireAfterAccess(Duration.ofSeconds(LOGIN_EXPIRE_SECONDS)).build();
    }

    public static String genToken(User user) {
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        caffeine.put(uuid, user);
        return uuid;
    }

    /**
     * 解析token
     *
     * @param token 用户token
     * @return
     */
    public static User decToken(String token) {
        //框架自动续命，不用人为管
        Object ifPresent = caffeine.getIfPresent(token);
        if (ifPresent == null) {
            //未登录或者登录过期
            throw new BusinessException(Response.LOGIN_EXPIRE_CODE, "system.login.expire");
        }
        return (User) ifPresent;
    }

    /**
     * 将用户提出系统
     *
     * @param userId 用户id
     */
    public static void kickOut(String userId) {
        ConcurrentMap<@NonNull Object, @NonNull Object> map = caffeine.asMap();
        for (Object key : map.keySet()) {
            User user = (User) map.get(key);
            if (user.getId().equals(userId)) {
                caffeine.invalidate(key);
            }
        }

    }
}