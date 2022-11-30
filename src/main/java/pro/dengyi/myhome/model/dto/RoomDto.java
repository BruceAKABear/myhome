package pro.dengyi.myhome.model.dto;

import lombok.Data;
import pro.dengyi.myhome.model.system.Room;

/**
 * 房间数据传输实体
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-02-03
 */
@Data
public class RoomDto extends Room {

  private String floorName;
  private String floorId;
  private Integer deviceCount;
}
