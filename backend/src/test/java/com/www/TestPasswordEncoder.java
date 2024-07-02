package com.www;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/20:52
 * @Description:
 */
@SpringBootTest
public class TestPasswordEncoder {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    void matchPass() {
        String encodePwd = "$2a$10$i3oz3UbsKwhXpEOCSWMdP.11pvb1Gz8/lPI09y6kxDNeBhd9tHGfy";
        if (passwordEncoder.matches("admin123", encodePwd)) {
            System.out.println("匹配成功");
        } else {
            System.out.println("匹配失败");
        }
    }

    @Test
    void encodePwd() {
        String str = "123456";
        System.out.println(passwordEncoder.encode(str));
    }
}
