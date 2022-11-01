package pro.dengyi.myhome.config;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import java.util.concurrent.TimeUnit;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 缓存配置
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-27
 */
@Configuration
public class CaffeineConfig {

  @Bean
  public Cache<String, Object> caffeineCache() {
    return Caffeine.newBuilder()
        // 设置最后一次写入或访问后经过固定时间过期
        .expireAfterWrite(60, TimeUnit.SECONDS)
        // 初始的缓存空间大小
        .initialCapacity(100)
        // 缓存的最大条数
        .maximumSize(10000).build();
  }

}