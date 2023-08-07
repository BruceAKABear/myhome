package pro.dengyi.myhome.common.pubsub;

import lombok.Data;

import java.util.Map;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2023/6/20 15:14
 * @description：
 * @modified By：
 */
@Data
public class Event {

    private EventType eventType;

    private String message;

    private Map<String, Object> params;

}