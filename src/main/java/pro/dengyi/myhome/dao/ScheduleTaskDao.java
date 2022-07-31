package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.automation.ScheduleTask;
import pro.dengyi.myhome.model.automation.dto.ScheduleTaskPageDto;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-10
 */
@Repository
public interface ScheduleTaskDao extends BaseMapper<ScheduleTask> {

  IPage<ScheduleTaskPageDto> selectCustomPage(IPage<ScheduleTaskPageDto> pageParam, @Param("name") String name);
}
