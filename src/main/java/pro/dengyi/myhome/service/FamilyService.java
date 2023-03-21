package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.model.system.Family;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public interface FamilyService {

  void addUpdate(Family family);

  FamilyDto info();

  Boolean checkIsFirst();

}
