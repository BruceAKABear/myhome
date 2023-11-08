package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

import java.time.LocalTime;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/2 14:32
 * @description： 场景 条件及结果参见readme文档
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("scene_condition")
@ApiModel("场景条件实体")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SceneCondition extends BaseModel {

    private String sceneId;

    //type: device time
    private String type;

    private LocalTime startTime;
    private LocalTime endTime;

    private String deviceId;

    private String deviceProperty;
    private String propertyValue;
    //first one is null
    private String relation;

}
