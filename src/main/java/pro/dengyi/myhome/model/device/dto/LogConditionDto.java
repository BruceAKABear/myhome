package pro.dengyi.myhome.model.device.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.time.LocalDateTime;
import lombok.Data;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/12/22 10:49
 * @description：
 * @modified By：
 */
@Data
public class LogConditionDto {

  private String deviceId;

  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime startDateTime;
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
  private LocalDateTime endDateTime;

  private Integer step;

}
