package pro.dengyi.myhome.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.model.Family;
import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.FamilyService;

/**
 * 家庭controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "家庭接口")
@RestController
@RequestMapping("/family")
public class FamilyController {
    @Autowired
    private FamilyService familyService;

    @ApiOperation("新增或修改家庭")
    @PostMapping("/addUpdate")
    public CommonResponse addUpdate(@RequestBody @Validated Family family) {
        familyService.addUpdate(family);
        return CommonResponse.success();
    }

    @ApiOperation("家庭信息")
    @GetMapping("/info")
    public DataResponse<FamilyDto> info() {
        FamilyDto familyDto = familyService.info();
        return new DataResponse<>(familyDto);
    }


}
