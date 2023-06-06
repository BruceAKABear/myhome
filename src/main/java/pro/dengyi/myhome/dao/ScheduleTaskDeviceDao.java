package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.automation.ScheduleTaskDevice;
import pro.dengyi.myhome.model.device.Device;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-28
 */
@Repository
public interface ScheduleTaskDeviceDao extends BaseMapper<ScheduleTaskDevice> {

    List<Device> selectOnlineDeviceByTaskId(@Param("taskId") String taskId);
}
