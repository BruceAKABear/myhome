package pro.dengyi.myhome.common.config;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

/**
 * 缓存配置
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-27
 */
@Configuration
public class CacheConfig {

    @Bean("cache")
    public Cache<String, Object> cache() {
        return Caffeine.newBuilder()
                //最后一次访问7天后过期
                .expireAfterAccess(7, TimeUnit.DAYS)
                // 初始的缓存空间大小
                .initialCapacity(100)
                // 缓存的最大条数
                .maximumSize(10000).build();
    }


    /**
     * 系统缓存不过期
     *
     * @return
     */
    @Bean("systemCache")
    public Cache<String, Object> systemCache() {
        return Caffeine.newBuilder()
                // 初始的缓存空间大小
                .initialCapacity(100)
                // 缓存的最大条数
                .maximumSize(10000).build();
    }


//    @Bean("sceneCaches")
//    public Cache<String, Object> sceneCaches() {
//        return Caffeine.newBuilder()
//                //最后一次访问7天后过期
//                .expireAfterAccess(7, TimeUnit.DAYS)
//                // 初始的缓存空间大小
//                .initialCapacity(100)
//                // 缓存的最大条数
//                .maximumSize(10000).build();
//    }

}