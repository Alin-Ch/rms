package com.www.security.handler.jwt;

import cn.hutool.json.JSONUtil;
import com.www.utils.JwtUtils;
import com.www.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/27/22:15
 * @Description:        Security Logout退出成功处理器，配置到SecurityConfig中
 */
@Component
public class JwtLogoutSuccessHandler implements LogoutSuccessHandler {

    @Autowired
    private JwtUtils jwtUtils;

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        // 手动退出，清除认证数据
        if(authentication != null){
            new SecurityContextLogoutHandler().logout(request,response,authentication);
        }

        // 以流的形式返回
        response.setContentType("/application/json;charset=UTF-8");
        ServletOutputStream outputStream = response.getOutputStream();

        // 设置到响应头name为配置文件的Authorization，value为jwt，发送到浏览器的响应信息，如保存token
        response.setHeader(jwtUtils.getHeader(), "");

        Result result = Result.success("登录成功");
        outputStream.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));
        outputStream.flush();
        outputStream.close();
    }
}
