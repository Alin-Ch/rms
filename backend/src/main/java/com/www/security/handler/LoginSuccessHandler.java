package com.www.security.handler;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.www.common.aop.LogAspect;
import com.www.pojo.SysUser;
import com.www.service.SysUserService;
import com.www.utils.JwtUtils;
import com.www.vo.Result;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/13:24
 * @Description:        认证成功处理器
 */
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    private final JwtUtils jwtUtils;
    private final SysUserService sysUserService;
    private final LogAspect logAspect;

    public LoginSuccessHandler(JwtUtils jwtUtils,
                               SysUserService sysUserService, LogAspect logAspect) {
        this.jwtUtils = jwtUtils;
        this.sysUserService = sysUserService;
        this.logAspect = logAspect;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        // 以流的形式返回
        response.setContentType("/application/json;charset=UTF-8");
        ServletOutputStream outputStream = response.getOutputStream();

        // 生成jwt，并放置到请求头中，在authentication中获取用户名
        String jwt = jwtUtils.generateToken(authentication.getName());
        // 设置到响应头name为配置文件的Authorization，value为jwt，发送到浏览器的响应信息，如保存token
        response.setHeader(jwtUtils.getHeader(), jwt);



        Result result = Result.success("登录成功");
        SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", authentication.getName()));
        user.setLastLogin(new Date());
        sysUserService.updateById(user);

        // 调用日志切面记录登录日志
        logAspect.logLogin(user.getUsername(), request.getRemoteAddr(), user.getId());

        outputStream.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));
        outputStream.flush();
        outputStream.close();
    }
}
