package pro.dengyi.myhome.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2023-12-24
 */
@Data
public class TreeDto {
    private String id;
    private String name;
    private Boolean gateway;
    private List<TreeDto> children;
}
