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
    //手机端登录永不过期
    static Cache<Object, Object> cacheNoExpire;
    static Cache<Object, Object> cacheExpire;

    static {
        cacheExpire = Caffeine.newBuilder()
                .expireAfterAccess(Duration.ofSeconds(LOGIN_EXPIRE_SECONDS))
                .build();
        cacheNoExpire = Caffeine.newBuilder().build();
    }

    /**
     * 根据请求来源获取用户所存储的位置
     *
     * @return
     */
    private static Cache<Object, Object> getSession() {
        switch (RequestSourceHolder.getSource()) {
            case PC:
                return cacheExpire;
            case PHONE:
                return cacheNoExpire;
        }
        return null;
    }

    public static String genToken(User user) {
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        getSession().put(uuid, user);
        return uuid;
    }

    /**
     * 解析token，为空则用户登录过期
     *
     * @param token 用户token
     * @return
     */
    public static User decToken(String token) {
        Object ifPresent = getSession().getIfPresent(token);
        if (ifPresent == null) {
            //未登录或者登录过期
            throw new BusinessException(Response.LOGIN_EXPIRE_CODE,
                    "system.login.expire");
        }
        return (User) ifPresent;
    }

    /**
     * 将用户踢出缓存
     * <p>
     * 1.意味着用户退出系统
     * 2.自己可以踢自己，意味着自己主动退出
     *
     * @param userId 用户id
     */
    public static void kickOut(String userId) {
        Cache<Object, Object> cache = getSession();
        ConcurrentMap<@NonNull Object, @NonNull Object> map = cache.asMap();
        for (Object key : map.keySet()) {
            User user = (User) map.get(key);
            if (user.getId().equals(userId)) {
                cache.invalidate(key);
            }
        }

    }
}
