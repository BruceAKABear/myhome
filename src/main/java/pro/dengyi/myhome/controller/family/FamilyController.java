package pro.dengyi.myhome.controller.family;

import com.github.benmanes.caffeine.cache.Cache;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.annotations.Permission;
import pro.dengyi.myhome.model.dto.FamilyDto;
import pro.dengyi.myhome.model.system.Family;
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
@Permission
@RequestMapping("/family")
public class FamilyController {

  @Autowired
  private Cache<String, Object> cache;
  @Autowired
  private FamilyService familyService;

  @ApiOperation(value = "新增或修改家庭")
  @PostMapping("/addUpdate")
  public CommonResponse addUpdate(@RequestBody @Validated Family family) {
    familyService.addUpdate(family);
    return CommonResponse.success();
  }

  @ApiOperation("查询家庭信息")
  @GetMapping("/info")
  public DataResponse<FamilyDto> info() {
    FamilyDto familyDto = (FamilyDto) cache.get("familyInfo", key -> familyService.info());
    return new DataResponse<>(familyDto);
  }

  @ApiOperation("查询是否是第一次登陆")
  @GetMapping("/checkIsFirst")
  public DataResponse<Boolean> checkIsFirst() {
    Boolean flag = familyService.checkIsFirst();
    return new DataResponse<>(flag);
  }


}
