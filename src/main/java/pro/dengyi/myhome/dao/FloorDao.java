package pro.dengyi.myhome.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import pro.dengyi.myhome.model.Floor;
import pro.dengyi.myhome.model.dto.FloorDto;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Repository
public interface FloorDao extends BaseMapper<Floor> {
    List<FloorDto> selectFloorDto();
}
