package pro.dengyi.myhome.model.automation.dto;

import lombok.Data;
import pro.dengyi.myhome.model.automation.ScheduleTask;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-17
 */
@Data
public class ScheduleTaskPageDto extends ScheduleTask {

  private String deviceName;

}
