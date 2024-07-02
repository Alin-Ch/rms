package com.www.security.filter;

import com.www.common.exception.CaptchaException;
import com.www.security.handler.LoginFailureHandler;
import com.www.utils.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/13:42
 * @Description: 验证码过滤器，一次性校验
 */
@Component
public class CaptchaFilter extends OncePerRequestFilter {

    private final RedisUtil redisUtil;

    private final LoginFailureHandler loginFailureHandler;

    public CaptchaFilter(RedisUtil redisUtil,
                         LoginFailureHandler loginFailureHandler) {
        this.redisUtil = redisUtil;
        this.loginFailureHandler = loginFailureHandler;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // 获取所有请求
        String url = request.getRequestURI();

        // 判断请求是不是登录请求，且提交方式为POST
        if ("/login".equals(url) && request.getMethod().equals("POST")) {
            try {
                // 校验验证码
                codeValidate(request);
            } catch (CaptchaException e) {
                // 如果不正确，跳转到认证失败处理器
                loginFailureHandler.onAuthenticationFailure(request, response, e);
            }
        }
        // 交给之后的过滤器
        filterChain.doFilter(request,response);
    }

    // 校验验证码逻辑
    private void codeValidate(HttpServletRequest request) {
        // 在请求参数中获取用户输入的code
        String code = request.getParameter("IDcode");
        String key = request.getParameter("token");

        if (StringUtils.isBlank(code) || StringUtils.isBlank(key)){
            redisUtil.del(key);
            throw new CaptchaException("图形验证码输入错误，请重新输入");
        }

        if (redisUtil.isExpire(key)){
            redisUtil.del(key);
            throw new CaptchaException("图形验证码输入超时，请重新获取验证码");
        }

        if (!code.equals(redisUtil.get(key))){
            redisUtil.del(key);
            throw new CaptchaException("图形验证码输入错误，请重新输入");
        }

        redisUtil.del(key);

    }
}
