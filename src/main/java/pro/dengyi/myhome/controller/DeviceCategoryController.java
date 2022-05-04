package pro.dengyi.myhome.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import pro.dengyi.myhome.annotations.NeedHolderPermission;
import pro.dengyi.myhome.model.DeviceCategory;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.DeviceCategoryService;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 设备分类controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Api(tags = "设备分类接口")
@Validated
@RestController
@RequestMapping("/deviceCategory")
public class DeviceCategoryController {

  @Autowired
  private DeviceCategoryService deviceCategoryService;


  @NeedHolderPermission
  @ApiOperation("添加后修改分类")
  @PostMapping("/addUpdate")
  public CommonResponse addUpdate(@RequestBody @Validated DeviceCategory deviceCategory) {
    deviceCategoryService.addUpdate(deviceCategory);
    return CommonResponse.success();
  }

  @NeedHolderPermission
  @ApiOperation("删除分类")
  @DeleteMapping("/delete/{id}")
  public CommonResponse delete(@PathVariable @NotBlank(message = "id不能为空") String id) {
    deviceCategoryService.delete(id);
    return CommonResponse.success();
  }

  @NeedHolderPermission
  @ApiOperation("分页查询")
  @GetMapping("/page")
  public DataResponse<IPage<DeviceCategory>> page(Integer pageNumber, Integer pageSize,
      String name) {
    IPage<DeviceCategory> pageResult = deviceCategoryService.page(pageNumber, pageSize, name);
    return new DataResponse<>(pageResult);
  }

  @NeedHolderPermission
  @ApiOperation("查询分类集合")
  @GetMapping("/categoryList")
  public DataResponse<List<DeviceCategory>> categoryList() {
    List<DeviceCategory> deviceCategoryList = deviceCategoryService.categoryList();
    return new DataResponse<>(deviceCategoryList);
  }


}
