package pro.dengyi.myhome.common.config.properties;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "user")
public class UserProperties {

    /**
     * 默认用户密码
     */
    private String defaultPassword = "12345678";


}
