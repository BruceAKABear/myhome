package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.time.LocalDateTime;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.config.MyScheduleJob;
import pro.dengyi.myhome.dao.DeviceDao;
import pro.dengyi.myhome.dao.ScheduleTaskDao;
import pro.dengyi.myhome.dao.ScheduleTaskDeviceDao;
import pro.dengyi.myhome.model.automation.ScheduleTask;
import pro.dengyi.myhome.model.automation.ScheduleTaskDevice;
import pro.dengyi.myhome.service.ScheduleTaskService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-10
 */
@Slf4j
@Service
public class ScheduleTaskServiceImpl implements ScheduleTaskService {

  @Autowired
  private ScheduleTaskDao scheduleTaskDao;
  @Autowired
  private ScheduleTaskDeviceDao scheduleTaskDeviceDao;
  @Autowired
  private DeviceDao deviceDao;

  @Autowired
  private Scheduler scheduler;

  @Override
  public void addOrUpdate(ScheduleTask scheduleTask) {
    if (ObjectUtils.isEmpty(scheduleTask.getId())) {
      try {
        scheduleTask.setCreateTime(LocalDateTime.now());
        scheduleTask.setUpdateTime(LocalDateTime.now());
        scheduleTask.setEnable(true);
        scheduleTaskDao.insert(scheduleTask);
        JobDetail jobDetail = JobBuilder.newJob(MyScheduleJob.class)
            .withIdentity(JobKey.jobKey(scheduleTask.getId())).build();
        Trigger jobTrigger = TriggerBuilder.newTrigger().startNow()
            .withIdentity(TriggerKey.triggerKey(scheduleTask.getId()))
            .withSchedule(CronScheduleBuilder.cronSchedule(scheduleTask.getCron())).build();
        scheduler.scheduleJob(jobDetail, jobTrigger);
        scheduleTask.getTargetDeviceIds().forEach(item -> {
          ScheduleTaskDevice scheduleTaskDevice = new ScheduleTaskDevice();
          scheduleTaskDevice.setDeviceId(item);
          scheduleTaskDevice.setTaskId(scheduleTask.getId());
          scheduleTaskDevice.setCreateTime(LocalDateTime.now());
          scheduleTaskDevice.setUpdateTime(LocalDateTime.now());
          scheduleTaskDeviceDao.insert(scheduleTaskDevice);
        });
      } catch (SchedulerException e) {
        log.error("添加定时任务失败", e);
        throw new RuntimeException(e);
      }
    } else {
      //修改
      scheduleTask.setUpdateTime(LocalDateTime.now());
      scheduleTaskDao.updateById(scheduleTask);
      scheduleTaskDeviceDao.delete(
          new LambdaQueryWrapper<ScheduleTaskDevice>().eq(ScheduleTaskDevice::getTaskId,
              scheduleTask.getId()));
      scheduleTask.getTargetDeviceIds().forEach(item -> {
        ScheduleTaskDevice scheduleTaskDevice = new ScheduleTaskDevice();
        scheduleTaskDevice.setDeviceId(item);
        scheduleTaskDevice.setTaskId(scheduleTask.getId());
        scheduleTaskDevice.setCreateTime(LocalDateTime.now());
        scheduleTaskDevice.setUpdateTime(LocalDateTime.now());
        scheduleTaskDeviceDao.insert(scheduleTaskDevice);
      });
      if (scheduleTask.getEnable()) {
        //原来如果没有启用，则新增任务
        try {
          JobDetail jobDetail = scheduler.getJobDetail(JobKey.jobKey(scheduleTask.getId()));
          if (jobDetail != null) {
            Trigger jobTrigger = TriggerBuilder.newTrigger().startNow()
                .withIdentity(TriggerKey.triggerKey(scheduleTask.getId()))
                .withSchedule(CronScheduleBuilder.cronSchedule(scheduleTask.getCron())).build();
            scheduler.scheduleJob(jobDetail, jobTrigger);
          } else {
            //以前没有启用，现在启用了，则新增任务
            JobDetail jobDetailNew = JobBuilder.newJob(MyScheduleJob.class)
                .withIdentity(JobKey.jobKey(scheduleTask.getId())).build();
            Trigger jobTrigger = TriggerBuilder.newTrigger().startNow()
                .withIdentity(TriggerKey.triggerKey(scheduleTask.getId()))
                .withSchedule(CronScheduleBuilder.cronSchedule(scheduleTask.getCron())).build();
            scheduler.scheduleJob(jobDetailNew, jobTrigger);
          }
        } catch (SchedulerException e) {
          throw new RuntimeException(e);
        }

      }
    }
  }

  @Override
  public IPage<ScheduleTask> page(Integer page, Integer size, String name) {
    IPage<ScheduleTask> pageParam = new Page<>(page == null ? 1 : page, size == null ? 10 : size);
    LambdaQueryWrapper<ScheduleTask> wrapper = new LambdaQueryWrapper<>();
    if (!ObjectUtils.isEmpty(name)) {
      wrapper.like(ScheduleTask::getName, name);
    }
    IPage<ScheduleTask> scheduleTaskPage = scheduleTaskDao.selectPage(pageParam, wrapper);
    scheduleTaskPage.getRecords().forEach(item -> {
      List<ScheduleTaskDevice> scheduleTaskDevices = scheduleTaskDeviceDao.selectList(
          new LambdaQueryWrapper<ScheduleTaskDevice>().eq(ScheduleTaskDevice::getTaskId,
              item.getId()));
      item.setTargetDeviceIds(scheduleTaskDevices.stream().map(ScheduleTaskDevice::getDeviceId)
          .collect(java.util.stream.Collectors.toList()));
      if (!CollectionUtils.isEmpty(scheduleTaskDevices)) {
        item.setProductId(
            deviceDao.selectById(scheduleTaskDevices.get(0).getDeviceId()).getProductId());
      }
    });
    return scheduleTaskPage;
  }

  @Transactional
  @Override
  public void delete(String id) {
    try {
      scheduler.pauseTrigger(TriggerKey.triggerKey(id));
      scheduler.unscheduleJob(TriggerKey.triggerKey(id));
      scheduler.deleteJob(JobKey.jobKey(id));
      scheduleTaskDao.deleteById(id);
      scheduleTaskDeviceDao.delete(
          new LambdaQueryWrapper<ScheduleTaskDevice>().eq(ScheduleTaskDevice::getTaskId, id));
    } catch (SchedulerException e) {
      log.error("删除任务失败", e);
      throw new RuntimeException(e);
    }
  }

  @Transactional
  @Override
  public void changeStatus(String id) {
    ScheduleTask scheduleTask = scheduleTaskDao.selectById(id);
    if (scheduleTask.getEnable()) {
      try {
        scheduleTask.setEnable(false);
        scheduleTask.setUpdateTime(LocalDateTime.now());
        scheduleTaskDao.updateById(scheduleTask);
        JobDetail jobDetail = scheduler.getJobDetail(JobKey.jobKey(id));
        if (jobDetail != null) {
          scheduler.pauseTrigger(TriggerKey.triggerKey(id));
        }
      } catch (Exception e) {
        log.error("更改状态失败", e);
      }
    } else {
      try {
        scheduleTask.setEnable(true);
        scheduleTask.setUpdateTime(LocalDateTime.now());
        scheduleTaskDao.updateById(scheduleTask);
        JobDetail jobDetail = scheduler.getJobDetail(JobKey.jobKey(id));
        if (jobDetail != null) {
          scheduler.resumeTrigger(TriggerKey.triggerKey(id));
        } else {
          //以前没有启用，现在启用了，则新增任务
          JobDetail jobDetailNew = JobBuilder.newJob(MyScheduleJob.class)
              .withIdentity(JobKey.jobKey(scheduleTask.getId())).build();
          Trigger jobTrigger = TriggerBuilder.newTrigger().startNow()
              .withIdentity(TriggerKey.triggerKey(scheduleTask.getId()))
              .withSchedule(CronScheduleBuilder.cronSchedule(scheduleTask.getCron())).build();
          scheduler.scheduleJob(jobDetailNew, jobTrigger);
        }
      } catch (Exception e) {
        log.error("更改状态失败", e);
      }
    }
  }

  @Override
  public void triggerImmediately(String id) {
    try {
      scheduler.triggerJob(JobKey.jobKey(id));
    } catch (SchedulerException e) {
      log.error("立即执行失败", e);
      throw new RuntimeException(e);
    }
  }
}
