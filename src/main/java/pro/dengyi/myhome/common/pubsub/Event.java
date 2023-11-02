package pro.dengyi.myhome.common.pubsub;

import lombok.Data;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/20 15:14
 * @description：
 * @modified By：
 */
@Data
public class Event {

    private EventTypeEnum eventTypeEnum;

    private String message;

    private Object params;

}
