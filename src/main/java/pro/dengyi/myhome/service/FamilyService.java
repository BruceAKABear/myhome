package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.model.system.Family;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public interface FamilyService {

    void addUpdate(Family family);

    Boolean checkIsFirst();

    List<FamilyDto> infoList();

    FamilyDto infoById(String familyId);
}
