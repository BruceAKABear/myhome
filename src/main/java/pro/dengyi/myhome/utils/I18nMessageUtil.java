package pro.dengyi.myhome.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;

/**
 * i18n工具类
 *
 * @author ：dengyi
 * @date ：Created in 2022/2/17 10:57
 * @description：i18n消息内容获取工具类
 * @modified By：
 */
@Slf4j
@Component
public class I18nMessageUtil {

  private static MessageSource messageSource;

  public I18nMessageUtil(MessageSource messageSource) {
    I18nMessageUtil.messageSource = messageSource;
  }

  /**
   * 通过编码查询值
   *
   * @param errorCode
   * @return
   */
  public static String get(Integer errorCode) {
    return messageSource.getMessage(errorCode + "_message", null, LocaleContextHolder.getLocale());
  }

}
