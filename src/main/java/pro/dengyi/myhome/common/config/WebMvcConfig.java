package pro.dengyi.myhome.common.config;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import pro.dengyi.myhome.common.interceptors.FrameworkInterceptor;

import java.util.List;

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

    //for response handler string type of response
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        WebMvcConfigurer.super.configureMessageConverters(converters);
        //为了方便，必须在这里全局设置json非空字段，在yml中设置已失效，如果有这个配置存在
        ObjectMapper build = Jackson2ObjectMapperBuilder.json()
                .serializationInclusion(JsonInclude.Include.NON_NULL).build();
        converters.add(0, new MappingJackson2HttpMessageConverter(build));
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
