package pro.dengyi.myhome.model.dto;

import lombok.Data;
import pro.dengyi.myhome.model.system.Floor;

/**
 * 家庭dto
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Data
public class FloorPageDto extends Floor {

    private Integer roomCount;
    private Integer deviceCount;

    private String familyName;
}
