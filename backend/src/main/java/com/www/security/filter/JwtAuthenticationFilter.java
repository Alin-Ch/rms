package com.www.security.filter;

import cn.hutool.core.util.StrUtil;
import com.www.pojo.SysUser;
import com.www.security.MyUserDetailsServiceImpl;
import com.www.service.SysUserService;
import com.www.utils.JwtUtils;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/19:04
 * @Description:        识别JWT
 */
public class JwtAuthenticationFilter extends BasicAuthenticationFilter {

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private MyUserDetailsServiceImpl myUserDetailsService;

    @Autowired
    private SysUserService sysUserService;

    public JwtAuthenticationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
    }

    // 重写过滤流程
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        // jwt的名称
        String jwt = request.getHeader(jwtUtils.getHeader());

        // 没有jwt放行针对白名单放行
        if (StrUtil.isBlankOrUndefined(jwt)) {
            chain.doFilter(request, response);
            return;
        }

        // 有jwt，则解析jwt
        Claims claim = jwtUtils.getClaimByToken(jwt);
        if (claim == null) {
            throw new JwtException("token异常");
        }

        // 判断token是否过期
        if (jwtUtils.isTokenExpired(claim)) {
            throw new JwtException("token已过期，请重新登录");
        }

        // 合法jwt，在Subject中获取用户名
        String username = claim.getSubject();
        // 获取用户的权限等信息，实现自动登录

        // 根据用户名获取用户
        SysUser sysUser = sysUserService.getByUsername(username);

        UsernamePasswordAuthenticationToken token =
                new UsernamePasswordAuthenticationToken(username, null, myUserDetailsService.getUserAuthority(sysUser.getId()));

        // 获取安全上下文，设置认证的主体
        SecurityContextHolder.getContext().setAuthentication(token);

        // 放行
        chain.doFilter(request,response);

    }
}
