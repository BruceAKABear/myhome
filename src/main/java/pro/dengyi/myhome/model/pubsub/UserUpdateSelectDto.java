package pro.dengyi.myhome.model.pubsub;

import lombok.Data;
import pro.dengyi.myhome.common.enums.UserUpdateSelectEnum;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2024-03-04 13:19
 * @description：
 * @modified By：
 */
@Data
public class UserUpdateSelectDto {
    private String userId;
    private UserUpdateSelectEnum updateSelectType;
    private String value;

    public UserUpdateSelectDto(String userId,
                               UserUpdateSelectEnum updateSelectType,
                               String value) {
        this.userId = userId;
        this.updateSelectType = updateSelectType;
        this.value = value;
    }
}
