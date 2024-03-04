package pro.dengyi.myhome.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.model.system.Family;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public interface FamilyService {

    void addUpdate(Family family);

    Boolean checkIsFirst();


    FamilyDto infoById(String familyId);

    IPage<FamilyDto> page(Integer page, Integer size, String name);

    void delete(String id);
}
