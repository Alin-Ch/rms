package com.www.config.security;

import com.www.security.MyUserDetailsServiceImpl;
import com.www.security.exception.JwtAccessDeniedHandler;
import com.www.security.exception.JwtAuthenticationEntryPoint;
import com.www.security.filter.CaptchaFilter;
import com.www.security.filter.JwtAuthenticationFilter;
import com.www.security.handler.LoginFailureHandler;
import com.www.security.handler.LoginSuccessHandler;
import com.www.security.handler.jwt.JwtLogoutSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/12:34
 * @Description: Security安全配置
 */
@EnableWebSecurity                                      // 加载security相关安全配置的策略
@EnableGlobalMethodSecurity(prePostEnabled = true)      // 全局方法安全配置注解
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private LoginFailureHandler loginFailureHandler;        // 认证失败处理器

    @Autowired
    private LoginSuccessHandler loginSuccessHandler;        // 认证成功处理器

    @Autowired
    private CaptchaFilter captchaFilter;                    // 验证码过滤器

    @Autowired
    private JwtAccessDeniedHandler jwtAccessDeniedHandler;  // jwt访问拒绝处理器

    @Autowired
    private JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;     // jwt认证入口

    @Autowired
    private MyUserDetailsServiceImpl myUserDetailsService;  // 注入自定义用户服务实现类，根据用户名查询数据库，匹配用户名和密码

    @Autowired
    private JwtLogoutSuccessHandler jwtLogoutSuccessHandler; // 退出处理器


    // jwt认证过滤器
    @Bean
    JwtAuthenticationFilter jwtAuthenticationFilter() throws Exception {
        JwtAuthenticationFilter jwtAuthenticationFilter = new JwtAuthenticationFilter(authenticationManager());
        return jwtAuthenticationFilter;
    }

    // 密码加密器：BCryptPasswordEncoder
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // 白名单放行数组
    private static final String[] URL_WHITEIST = {
            // 登录白名单放行
            "/login",
            // 注册白名单放行
            "/register",
            // 找回密码白名单放行
            "/updatePassword",
            // 退出白名单放行
            "/logout",
            // 登录验证码白名单放行
            "/captcha",
            // 注册验证码白名单放行
            "/email/**",
            // 图标白名单放行
            "/favicon.ico",
            // 上传头像白名单放行
            "/upload",
            "/upload/image",
            "/upload/video",
            // 支付宝沙箱
            "/alipay/pay",
            "/alipay/notify",
            // swagger api文档白名单放行-----访问：http://localhost:8000/doc.html
            "/doc.html",
            "/webjars/**",
            "/v2/api-docs",
            "/swagger-resources/**",
            // Druid  访问地址：http://localhost:8000/druid/login.html
            "/druid/**",
            // 放开websocket
            "/im/**",
            "/audio/**",

            // 用户端
            "/sys/carousel/**",
            "/sys/notice/**",
            "/sys/house/**",
            "/sys/house/random",
            "/sys/comment/**",
            "/test/**",
    };

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // headers().frameOptions()是用来iframe内嵌druid页面的
        http.cors().and().csrf().disable()
                // 登录配置
                .formLogin()
                .successHandler(loginSuccessHandler)        // 配置认证成功处理器
                .failureHandler(loginFailureHandler)        // 配置认证失败处理器
                .and()
                .logout()                                   // 配置退出成功处理器
                .logoutSuccessHandler(jwtLogoutSuccessHandler)               // 添加退出成功处理器

                // 禁用session
                .and()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)     // 配置session生成规则，stateless 不生成
                // 配置拦截规则
                .and()
                .authorizeRequests()
                .antMatchers(URL_WHITEIST).permitAll()       // 配置白名单放行
                .anyRequest().authenticated()
                // 异常处理器
                .and()
                .exceptionHandling()                         // 配置异常处理器
                .authenticationEntryPoint(jwtAuthenticationEntryPoint)       // 认证入口
                .accessDeniedHandler(jwtAccessDeniedHandler)                 // 拒绝访问处理器

                // 配置自定义的过滤器
                .and()
                .addFilter(jwtAuthenticationFilter())
                .addFilterBefore(captchaFilter, UsernamePasswordAuthenticationFilter.class)      // 在校验用户名和密码之前添加验证码过滤器
        ;
        /* 允许iframe访问本服务资源 */
        http.headers().frameOptions().disable();
    }

    // 将自定义的用户详情服务实现类，注入到security
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(myUserDetailsService);
        // 添加认证器
    }
}
