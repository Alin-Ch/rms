package com.www.config.swagger;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/04/04/13:13
 * @Description:
 */
@Configuration
@EnableSwagger2
public class SwaggerConfiguration {

    @Bean
    public Docket createDocApi(){
        return new Docket(DocumentationType.SWAGGER_2)
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.any())
                .build()
                .groupName("接口文档")
                .pathMapping("/")
                .apiInfo(DocApi());
    }

    private ApiInfo DocApi() {
        return new ApiInfoBuilder()
                // 页面标题
                .title("租赁平台api文档")
                // 创建人
                .contact(new Contact("阿林","https://glut-1.oss-cn-shenzhen.aliyuncs.com/image/efec2d468f964e2eb1097e15765d1c09.gif", "gxalinchen@qq.com"))
                // 版本号
                .version("1.0")
                // 描述
                .description("接口测试工具")
                .build();
    }
}
