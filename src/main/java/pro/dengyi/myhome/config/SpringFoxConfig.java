package pro.dengyi.myhome.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.RequestParameterBuilder;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.service.ParameterType;
import springfox.documentation.service.RequestParameter;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

import java.util.ArrayList;
import java.util.List;

/**
 * swagger配置
 *
 * @author BLab
 */
@Configuration
@EnableOpenApi
public class SpringFoxConfig {
    @Bean
    public Docket api() {
        List<RequestParameter> list = new ArrayList<>();
        list.add(new RequestParameterBuilder()
                .name("token")
                .description("认证token")
                .in(ParameterType.HEADER)
                .build());
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .globalRequestParameters(list)
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                // 页面标题
                .title("MyHome-API文档")
                // 创建人
                .contact(new Contact("邓艺", "https://www.dengyi.pro", "dengyi@dengyi.pro"))
                // 版本号
                .version("0.0.1")
                // 描述
                .description("MyHome-API文档")
                .build();
    }
}