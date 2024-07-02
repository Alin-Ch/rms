package com.www.security;

import com.www.pojo.SysUser;
import com.www.service.SysUserService;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/25/20:00
 * @Description:        通过数据库校验用户名，security校验密码
 */
@Service
public class MyUserDetailsServiceImpl implements UserDetailsService {


    private final SysUserService sysUserService;

    public MyUserDetailsServiceImpl(SysUserService sysUserService) {
        this.sysUserService = sysUserService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 根据用户名从数据库查询
        SysUser sysUser = sysUserService.getByUsername(username);
        if (sysUser != null && sysUser.getStatu() == 0){
            throw new UsernameNotFoundException("账号被封禁，请联系管理员");
        }
        if (sysUser == null){
            throw new UsernameNotFoundException("用户名或密码不正确");
        }


        return new MyUserDetails(
                sysUser.getId(),
                sysUser.getUsername(),
                sysUser.getPassword(),
                getUserAuthority(sysUser.getId())
        );
    }



    /**
     * 获取用户权限信息（角色、菜单权限）
     * @param userId
     * @return
     */
    public List<GrantedAuthority> getUserAuthority(Long userId) {

        // 角色（ROLE_xxx）、菜单操作权限（sys:user:list）
        String authority = sysUserService.getUserAuthorityInfo(userId);     // ROLE_admin,ROLE_normal,sys:user:list,……
        // 方法commaSeparatedStringToAuthorityList：将权限列表中的数据用逗号分割
        return AuthorityUtils.commaSeparatedStringToAuthorityList(authority);
    }
}
