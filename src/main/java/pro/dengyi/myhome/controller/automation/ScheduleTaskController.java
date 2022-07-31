package pro.dengyi.myhome.controller.automation;

import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javax.validation.constraints.NotBlank;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pro.dengyi.myhome.model.automation.ScheduleTask;
import pro.dengyi.myhome.response.CommonResponse;
import pro.dengyi.myhome.response.DataResponse;
import pro.dengyi.myhome.service.ScheduleTaskService;

/**
 * 定时任务controller
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-07-10
 */
@Api(tags = "定时任务接口")
@Validated
@RestController
@RequestMapping("/schedule")
public class ScheduleTaskController {

  @Autowired
  private ScheduleTaskService scheduleTaskService;


  @ApiOperation("分页查询")
  @GetMapping("/page")
  public DataResponse<IPage<ScheduleTask>> page(Integer page, Integer size, String name) {
    IPage<ScheduleTask> pageRes = scheduleTaskService.page(page, size, name);
    return new DataResponse<>(pageRes);
  }

  @ApiOperation("新增或修改定时任务")
  @PostMapping("/addOrUpdate")
  public CommonResponse addOrUpdate(@RequestBody ScheduleTask scheduleTask) {
    scheduleTaskService.addOrUpdate(scheduleTask);
    return CommonResponse.success();
  }

  @ApiOperation("启停定时任务")
  @GetMapping("/changeStatus")
  public CommonResponse changeStatus(
      @RequestParam @NotBlank(message = "定时任务id不能为空") String id) {
    scheduleTaskService.changeStatus(id);
    return CommonResponse.success();
  }

  @ApiOperation("立即触发定时任务(非启用中的任务不能立即触发)")
  @GetMapping("/triggerImmediately")
  public CommonResponse triggerImmediately(
      @RequestParam @NotBlank(message = "定时任务id不能为空") String id) {
    scheduleTaskService.triggerImmediately(id);
    return CommonResponse.success();
  }

  @ApiOperation("删除定时任务")
  @DeleteMapping("/delete/{id}")
  public CommonResponse delete(@PathVariable @NotBlank(message = "定时任务id不能为空") String id) {
    scheduleTaskService.delete(id);
    return CommonResponse.success();
  }


}
