package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.device.DeviceLog;
import pro.dengyi.myhome.model.device.dto.LogByConditionDto;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-05
 */
@Repository
public interface DeviceLogDao extends BaseMapper<DeviceLog> {

    List<LogByConditionDto> logByCondition(@Param("deviceId") String deviceId,
                                           @Param("startDateTime") LocalDateTime startDateTime,
                                           @Param("endDateTime") LocalDateTime endDateTime, @Param("step") Integer step);

}
