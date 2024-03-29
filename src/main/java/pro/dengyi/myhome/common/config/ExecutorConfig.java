package pro.dengyi.myhome.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;
import java.util.concurrent.ThreadPoolExecutor;

/**
 * 线程池配置
 *
 * @author dengyi
 */
@Configuration
public class ExecutorConfig {

    @Bean
    public Executor executor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        // 配置核心线程数
        executor.setCorePoolSize(Runtime.getRuntime().availableProcessors());
        // 配置最大线程数
        executor.setMaxPoolSize(100);
        // 配置队列大小
        executor.setQueueCapacity(100);
        // 配置线程池中的线程的名称前缀
        executor.setThreadNamePrefix("service-thread-");
        // CALLER_RUNS：不在新线程中执行任务，而是有调用者所在的线程来执行
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
        // 执行初始化
        executor.initialize();
        return executor;
    }
}
