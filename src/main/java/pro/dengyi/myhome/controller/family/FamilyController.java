package pro.dengyi.myhome.controller.family;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.common.aop.annotations.Permission;
import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.model.system.Family;
import pro.dengyi.myhome.service.FamilyService;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 家庭controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "家庭接口")
@RestController
@Permission
@RequestMapping("/family")
@Validated
public class FamilyController {
    @Autowired
    private FamilyService familyService;

    @ApiOperation(value = "新增或修改家庭")
    @PostMapping("/addUpdate")
    public void addUpdate(@RequestBody @Validated Family family) {
        familyService.addUpdate(family);
    }

    @ApiOperation("根据id查询家庭信息")
    @GetMapping("/infoById")
    public FamilyDto infoById(@RequestParam @NotBlank(message = "family id can not be blank") String familyId) {
        return familyService.infoById(familyId);
    }

    @ApiOperation("查询家庭信息集合")
    @GetMapping("/infoList")
    public List<FamilyDto> infoList() {
        return familyService.infoList();
    }

    @ApiOperation("查询是否是第一次登陆")
    @GetMapping("/checkIsFirst")
    public Boolean checkIsFirst() {
        return familyService.checkIsFirst();
    }


}
