package pro.dengyi.myhome;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import springfox.documentation.swagger2.annotations.EnableSwagger2WebMvc;

/**
 * 启动类
 *
 * @author BLab
 */
@SpringBootApplication
@MapperScan("pro.dengyi.myhome.dao")

public class MyhomeApplication {

    public static void main(String[] args) {
        SpringApplication.run(MyhomeApplication.class, args);
    }

}
