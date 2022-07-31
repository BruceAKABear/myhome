package pro.dengyi.myhome.config;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.quartz.JobExecutionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import pro.dengyi.myhome.dao.DeviceLogDao;
import pro.dengyi.myhome.dao.ScheduleTaskDao;
import pro.dengyi.myhome.dao.ScheduleTaskDeviceDao;
import pro.dengyi.myhome.model.automation.ScheduleTask;
import pro.dengyi.myhome.model.device.Device;
import pro.dengyi.myhome.model.device.DeviceLog;

/**
 * quartz任务
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-10
 */
@Slf4j
public class MyScheduleJob extends QuartzJobBean {

  @Autowired
  private ScheduleTaskDao scheduleTaskDao;

  @Autowired
  private ScheduleTaskDeviceDao scheduleTaskDeviceDao;
  @Autowired
  private DeviceLogDao deviceLogDao;

  @Autowired
  private MqttClient mqttClient;


  @Override
  protected void executeInternal(JobExecutionContext context) {
    String taskId = context.getJobDetail().getKey().getName();
    ScheduleTask scheduleTask = scheduleTaskDao.selectById(taskId);
    List<Device> devices = scheduleTaskDeviceDao.selectOnlineDeviceByTaskId(taskId);
    devices.forEach(item -> {
      String controlTopic = "control/" + item.getProductId() + "/" + item.getId();
      MqttMessage message = new MqttMessage(
          scheduleTask.getControlPayload().getBytes(StandardCharsets.UTF_8));
      message.setQos(1);
      try {
        mqttClient.publish(controlTopic, message);
        DeviceLog deviceLog = new DeviceLog();
        deviceLog.setProductId(item.getProductId());
        deviceLog.setDeviceId(item.getId());
        deviceLog.setTopicName(controlTopic);
        deviceLog.setPayload(scheduleTask.getControlPayload());
        deviceLog.setDirection(1);
        deviceLog.setCreateTime(LocalDateTime.now());
        deviceLog.setUpdateTime(LocalDateTime.now());
        deviceLogDao.insert(deviceLog);
      } catch (MqttException e) {
        log.error("定时任务发送命令失败", e);
      }

    });

  }
}
