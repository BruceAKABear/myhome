package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.time.LocalDateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.ScheduleTaskDao;
import pro.dengyi.myhome.model.automation.ScheduleTask;
import pro.dengyi.myhome.service.ScheduleTaskService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-10
 */
@Service
public class ScheduleTaskServiceImpl implements ScheduleTaskService {

  @Autowired
  private ScheduleTaskDao scheduleTaskDao;

  @Override
  public void addOrUpdate(ScheduleTask scheduleTask) {
    if (ObjectUtils.isEmpty(scheduleTask.getId())) {
      //新增
      scheduleTask.setCreateTime(LocalDateTime.now());
      scheduleTask.setUpdateTime(LocalDateTime.now());
      scheduleTaskDao.insert(scheduleTask);
    } else {
      //修改
      scheduleTask.setUpdateTime(LocalDateTime.now());
      scheduleTaskDao.updateById(scheduleTask);
    }
  }

  @Override
  public IPage<ScheduleTask> page(Integer page, Integer size, String name) {
    IPage<ScheduleTask> pageParam = new Page<>(page == null ? 1 : page, size == null ? 10 : size);
    return null;
  }
}
