package pro.dengyi.myhome.model.perm.dto;

import java.util.List;
import lombok.Data;
import pro.dengyi.myhome.model.perm.PermissionFunction;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-10-01
 */
@Data
public class PermissionDto {

  private  List<PermissionFunction>  menuPerms;

  private List<String> buttonPerm;

}
