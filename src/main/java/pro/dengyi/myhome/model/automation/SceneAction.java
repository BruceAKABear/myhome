package pro.dengyi.myhome.model.automation;

import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import pro.dengyi.myhome.model.base.BaseModel;

import javax.validation.constraints.NotBlank;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/2/2 14:32
 * @description： 场景 条件及结果参见readme文档
 * @modified By：
 */
@Data
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@TableName("scene_action")
@ApiModel("场景动作")
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SceneAction extends BaseModel {

    private String sceneId;

    private String type;
    //延迟时间，为空就不延迟立刻执行，有值就延迟到结束
    private String delayTime;

    private String deviceId;

    @NotBlank
    private String deviceProperty;

    @NotBlank
    private String propertyValue;


}
