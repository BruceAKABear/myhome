package pro.dengyi.myhome.model.dto;

import lombok.Data;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-27
 */
@Data
public class DashboardDto {

    private Integer familyCount;
    private Integer userCount;
    private Integer onlineUserCount;
    private Integer floorCount;
    private Integer roomCount;
    private Integer deviceCount;
    private Integer onlineDeviceCount;
    private Integer offlineDeviceCount;
}
