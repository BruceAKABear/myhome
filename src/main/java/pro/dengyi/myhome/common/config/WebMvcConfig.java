package pro.dengyi.myhome.common.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import pro.dengyi.myhome.common.interceptors.FrameworkInterceptor;

/**
 * web基础配置
 *
 * <p>网关中统一进行了跨域配置，单个项目中千万不要配置，否则会导致跨域
 *
 * @author BLab
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private FrameworkInterceptor frameworkInterceptor;
    @Value("${spring.profiles.active}")
    private String profileActive;

    private static final String PROFILE_DEV = "dev";


    /**
     * 跨域配置，注意这只是针对基础配置，如果涉及到自定义拦截器自行处理
     *
     * @param registry
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedMethods("*")
                .allowCredentials(true)
                .maxAge(3600)
                .allowedHeaders("*");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        if (PROFILE_DEV.equals(profileActive)) {
            registry
                    .addInterceptor(frameworkInterceptor)
                    .addPathPatterns("/**")
                    .excludePathPatterns("/swagger-resources/**")
                    .excludePathPatterns("/v2/api-docs");
        } else {
            registry
                    .addInterceptor(frameworkInterceptor)
                    .addPathPatterns("/**");
        }
    }
}
