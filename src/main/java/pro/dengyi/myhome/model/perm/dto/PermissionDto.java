package pro.dengyi.myhome.model.perm.dto;

import lombok.Data;
import pro.dengyi.myhome.model.perm.PermissionFunction;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-10-01
 */
@Data
public class PermissionDto {

    private List<PermissionFunction> menuPerms;

    private List<String> buttonPerm;

}
