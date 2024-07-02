package com.www;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Date;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/26/11:25
 * @Description:
 */
@SpringBootTest
public class TestJwt {

    @Test
    void gen() {
        Date nowDate = new Date();
        String jwt = Jwts.builder()
                .setHeaderParam("typ", "JWT")
                .claim("id", 123456)
                .claim("name", "admin")
                .setIssuedAt(nowDate)
                .setExpiration(new Date(nowDate.getTime() + 1000 * 604800))
                .signWith(SignatureAlgorithm.HS256, "pgL621pWx6O4ubZh2s4QVE78j9amh3sP")
                .compact();
        System.out.println(jwt);
    }
}
