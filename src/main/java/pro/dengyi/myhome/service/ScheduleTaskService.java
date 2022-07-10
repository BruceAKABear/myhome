package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.automation.ScheduleTask;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-10
 */
public interface ScheduleTaskService {

  void addOrUpdate(ScheduleTask scheduleTask);

  IPage<ScheduleTask> page(Integer page, Integer size, String name);
}
