package com.www;

import cn.hutool.core.lang.generator.SnowflakeGenerator;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/22/17:43
 * @Description:
 */
@SpringBootApplication
@MapperScan("com.www.mapper")
@EnableSwagger2
public class Application {
    public static void main(String[] args) {
        // http://localhost:8000/swagger-ui.html 或 http://localhost:8000/doc.html#/home
        SpringApplication.run(Application.class,args);
        System.out.println("项目启动成功...");
    }

    @Bean
    public SnowflakeGenerator snowflakeGenerator(){
        return new SnowflakeGenerator(1, 0);
    }
}
