package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.dto.FloorPageDto;
import pro.dengyi.myhome.model.system.Floor;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Repository
public interface FloorDao extends BaseMapper<Floor> {

  List<FloorPageDto> selectFloorDto();

  IPage<FloorPageDto> selectCustomPage(IPage<FloorPageDto> iPage,
      @Param("floorName") String floorName);
}
