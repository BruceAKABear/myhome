package pro.dengyi.myhome;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * 启动类
 *
 * @author BLab
 */
@SpringBootApplication
@MapperScan("pro.dengyi.myhome.dao")
@EnableAsync
@EnableScheduling
public class MyhomeApplication {

    public static void main(String[] args) {
        SpringApplication.run(MyhomeApplication.class, args);
    }

}
