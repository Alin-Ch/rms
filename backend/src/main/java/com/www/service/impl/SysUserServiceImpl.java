package com.www.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.EchartsBie;
import com.www.pojo.SysMenu;
import com.www.pojo.SysRole;
import com.www.pojo.SysUser;
import com.www.service.SysMenuService;
import com.www.service.SysRoleService;
import com.www.service.SysUserService;
import com.www.mapper.SysUserMapper;
import com.www.utils.RedisUtil;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author anxm
 * @description 针对表【sys_user(用户表)】的数据库操作Service实现
 * @createDate 2024-03-24 19:44:08
 */
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {

    private final SysRoleService sysRoleService;

    private final SysUserMapper sysUserMapper;

    private final SysMenuService sysMenuService;

    // 添加进缓存
    private final RedisUtil redisUtil;

    public SysUserServiceImpl(SysRoleService sysRoleService,
                              SysUserMapper sysUserMapper,
                              @Lazy SysMenuService sysMenuService,
                              RedisUtil redisUtil) {
        this.sysRoleService = sysRoleService;
        this.sysUserMapper = sysUserMapper;
        this.sysMenuService = sysMenuService;
        this.redisUtil = redisUtil;
    }

    /**
     * 根据用户名查询用户
     *
     * @param username
     * @return
     */
    @Override
    public SysUser getByUsername(String username) {
        return getOne(new QueryWrapper<SysUser>().eq("username", username));
    }


    /**
     * 获取用户权限集合
     *
     * @param userId
     * @return
     */
    @Override
    public String getUserAuthorityInfo(Long userId) {

        SysUser sysUser = sysUserMapper.selectById(userId);

        // ROLE_admin,ROLE_normal,sys:user:list,……
        String authority = "";

        if (redisUtil.hasKey("GrantedAuthority:" + sysUser.getUsername())) {
            authority = (String) redisUtil.get("GrantedAuthority:" + sysUser.getUsername());
        } else {

            // 根据ID查询用户角色关联表，获取当前ID所对应的所有角色信息
            List<SysRole> roles = sysRoleService.list(new QueryWrapper<SysRole>()
                    .inSql("id", "select role_id from sys_user_role where user_id = " + userId));

            if (roles.size() > 0) {
                // 获取roles，添加ROLE_前缀并使用","逗号隔开
                String roleCodes = roles.stream().map(r -> "ROLE_" + r.getCode()).collect(Collectors.joining(","));
                authority = roleCodes.concat(",");
            }

            // 获取菜单操作编码
            List<Long> menuIds = sysUserMapper.getNavMenuIds(userId);
            if (menuIds.size() > 0) {
                List<SysMenu> menus = sysMenuService.listByIds(menuIds);
                String menuPerms = menus.stream().map(m -> m.getPerms()).collect(Collectors.joining(","));
                authority = authority.concat(menuPerms);
            }

            // 添加缓存
            redisUtil.set("rmsGrantedAuthority:" + sysUser.getUsername(), authority, 60 * 60);
        }

        return authority;
    }

    // 清除用户相关缓存
    @Override
    public void clearUserAuthorityInfo(String username) {
        redisUtil.del("GrantedAuthority:" + username);
    }

    // 清除角色相关缓存
    @Override
    public void clearUserAuthorityInfoByRoleId(Long roleId) {
        List<SysUser> sysUsers = this.list(new QueryWrapper<SysUser>()
                .inSql("id", "select user_id from sys_user_role where role_id = " + roleId));
        sysUsers.forEach(u -> {
            this.clearUserAuthorityInfo(u.getUsername());
        });
    }

    // 清除菜单相关缓存
    @Override
    public void clearUserAuthorityInfoByMenuId(Long menuId) {
        List<SysUser> sysUsers = sysUserMapper.listByMenuId(menuId);
        sysUsers.forEach(u -> {
            this.clearUserAuthorityInfo(u.getUsername());
        });
    }

    @Override
    public void updateStatus(Long userId) {
        sysUserMapper.updateStatus(userId);
    }

    @Override
    public List<SysUser> getUserList() {
        return sysUserMapper.getUserList();
    }

    @Override
    public List<EchartsBie> getGenderBie() {
        return sysUserMapper.getGenderBie();
    }


}




