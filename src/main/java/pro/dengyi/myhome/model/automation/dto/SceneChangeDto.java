package pro.dengyi.myhome.model.automation.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/12/13 14:54
 * @description：
 * @modified By：
 */
@Data
public class SceneChangeDto {
    @NotBlank
    private String sceneId;
    @NotNull
    private Boolean enable;
}
