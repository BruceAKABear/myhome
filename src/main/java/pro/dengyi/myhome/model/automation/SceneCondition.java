package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.common.enums.RelationEnum;
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

    //index from 0 to max
    private Integer orderNumber;

    //first relation is null
    private RelationEnum relation;

    private String sceneId;
    private String conditionGroupId;

    //type: device time
    private String type;

    @JsonFormat(pattern = "HH:mm")
    private LocalTime startTime;
    @JsonFormat(pattern = "HH:mm")
    private LocalTime endTime;

    //设备id
    private String deviceId;
    //设备
    private String deviceProperty;
    //操作符
    private String operator;
    //值
    private String propertyValue;

}
