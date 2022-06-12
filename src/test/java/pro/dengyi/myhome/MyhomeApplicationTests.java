package pro.dengyi.myhome;

import java.io.File;
import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class MyhomeApplicationTests {

  @Test
  void contextLoads() {
    MemoryMXBean bean = ManagementFactory.getMemoryMXBean();

    MemoryUsage memoryUsage = bean.getHeapMemoryUsage();
    System.out.println(memoryUsage.getUsed());

    File[] roots = File.listRoots();// 获取磁盘分区列表

    for (File file : roots) {

      System.out.println(file.getPath() + "信息如下:");

      long free = file.getFreeSpace();

      long total = file.getTotalSpace();

      long use = total - free;


      System.out.println();

    }

  }

}
