package pro.dengyi.myhome.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import pro.dengyi.myhome.interceptors.FrameworkInterceptor;

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
    registry
        .addInterceptor(frameworkInterceptor)
        .addPathPatterns("/**") ;
  }
}
