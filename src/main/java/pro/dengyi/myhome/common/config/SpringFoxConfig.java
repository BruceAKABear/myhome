package pro.dengyi.myhome.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
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
@Profile("dev")
@Configuration
@EnableOpenApi
public class SpringFoxConfig {
    @Value("${project.name}")
    private String name;
    @Value("${project.version}")
    private String version;

    @Bean
    public Docket api() {
        List<RequestParameter> list = new ArrayList<>();
        list.add(new RequestParameterBuilder()
                .name("token")
                .description("access token")
                .in(ParameterType.HEADER)
                .build());
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .globalRequestParameters(list)
                .select()
                .apis(RequestHandlerSelectors.any())
                //不显示错误的接口地址
                .paths(PathSelectors.regex("(?!/error.*).*"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title(name)
                .contact(new Contact("Bruce", "https://www.dengyi.pro", "dengyi@dengyi.pro"))
                .version(version)
                .description(name + " API DOCS")
                .build();
    }
}