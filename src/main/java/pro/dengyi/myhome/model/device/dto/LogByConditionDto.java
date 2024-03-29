package pro.dengyi.myhome.model.device.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/**
 * @author ：dengyi(A.K.A Bear)
 * @date ：Created in 2022/12/22 10:49
 * @description：
 * @modified By：
 */
@Data
public class LogByConditionDto {


    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime dateTime;

    private LocalDate date;


    @JsonFormat(pattern = "HH:mm")
    private LocalTime time;

    private String log;

    public LocalDate getDate() {
        return dateTime.toLocalDate();
    }

    public LocalTime getTime() {
        return dateTime.toLocalTime();
    }
}
