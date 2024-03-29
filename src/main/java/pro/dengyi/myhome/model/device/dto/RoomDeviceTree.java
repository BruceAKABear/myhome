package pro.dengyi.myhome.model.device.dto;

import lombok.Data;

import java.util.List;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/11/4 10:31
 * @description：
 * @modified By：
 */
@Data
public class RoomDeviceTree {

    private String floorId;
    private String id;
    private String name;
    private String type;

    private List<RoomDeviceTree> children;

}
