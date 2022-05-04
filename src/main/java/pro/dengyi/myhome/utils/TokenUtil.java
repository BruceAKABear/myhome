package pro.dengyi.myhome.utils;

import com.alibaba.fastjson.JSON;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.Date;
import lombok.extern.slf4j.Slf4j;
import pro.dengyi.myhome.model.User;

/**
 * token工具类
 *
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Slf4j
public class TokenUtil {

  /**
   * subject
   */
  public static final String SUBJECT = "myhome";
  /**
   * 过期时间
   */
  public static final long EXPIREDAYS = 30;
  /**
   * 加密秘钥
   */
  public static final String APPSECRET = "myhome123!@#";


  /**
   * 生成 jwt token方法
   *
   * @return token字符串
   */
  public static String genToken(User user) {
    String userJson = JSON.toJSONString(user);
    return Jwts.builder().setSubject(SUBJECT).claim("userJson", userJson).setIssuedAt(new Date())
        .setExpiration(Date.from(
            LocalDate.now().plusDays(EXPIREDAYS).atStartOfDay(ZoneOffset.ofHours(8)).toInstant()))
        .signWith(SignatureAlgorithm.HS256, APPSECRET).compact();
  }

  /**
   * 解析token
   *
   * @param token
   * @return
   */
  public static User decToken(String token) {
    Claims body = Jwts.parser().setSigningKey(APPSECRET).parseClaimsJws(token).getBody();
    String userJson = (String) body.get("userJson");
    return JSON.parseObject(userJson, User.class);
  }
}
