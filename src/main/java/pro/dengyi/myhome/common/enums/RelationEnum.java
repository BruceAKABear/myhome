package pro.dengyi.myhome.common.enums;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/9/20 10:24
 * @description：
 * @modified By：
 */
public enum RelationEnum {
    AND("&&"),
    OR("||"),
    NOT("!");

    private String val;

    RelationEnum(String value) {
        this.val = value;
    }

    public String getValue() {
        return val;
    }
}
