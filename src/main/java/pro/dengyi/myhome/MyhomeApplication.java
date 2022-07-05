package pro.dengyi.myhome;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * 启动类
 *
 * @author BLab
 */
@SpringBootApplication
@MapperScan("pro.dengyi.myhome.dao")
@EnableAsync
public class MyhomeApplication {

  public static void main(String[] args) {
    SpringApplication.run(MyhomeApplication.class, args);
  }

}
