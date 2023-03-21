package pro.dengyi.myhome.model.system;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/3/14 9:52
 * @description：the api processing time model
 * @modified By：
 */

@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("system_api_processing_time")
@ApiModel("接口处理时间")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ApiProcessingTime extends BaseModel {


  private String uri;


  private Integer times;

}
