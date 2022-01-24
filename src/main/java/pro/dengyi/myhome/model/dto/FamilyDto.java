package pro.dengyi.myhome.model.dto;

import lombok.Data;
import pro.dengyi.myhome.model.Family;

/**
 * 家庭dto
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Data
public class FamilyDto extends Family {

    private Integer floorCount;
    private Integer roomCount;
    private Integer deviceCount;
}
