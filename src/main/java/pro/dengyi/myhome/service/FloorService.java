package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.dto.FloorPageDto;
import pro.dengyi.myhome.model.system.Floor;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public interface FloorService {

    void addUpdate(Floor floor);

    void delete(String id);

    List<FloorPageDto> floorList();

    IPage<FloorPageDto> page(Integer pageNumber, Integer pageSize, String floorName, String familyId);
}
