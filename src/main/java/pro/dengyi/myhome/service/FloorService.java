package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.Floor;
import pro.dengyi.myhome.model.dto.FloorDto;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public interface FloorService {
    void addUpdate(Floor floor);

    void delete(String id);

    List<FloorDto> floorList();
}
