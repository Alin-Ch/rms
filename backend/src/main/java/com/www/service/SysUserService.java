package com.www.service;

import com.www.pojo.EchartsBie;
import com.www.pojo.SysUser;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author anxm
* @description 针对表【sys_user(用户表)】的数据库操作Service
* @createDate 2024-03-24 19:44:08
*/
public interface SysUserService extends IService<SysUser> {

    SysUser getByUsername(String username);

    String getUserAuthorityInfo(Long userId);

    // 清除缓存的方法
    void clearUserAuthorityInfo(String username);

    void clearUserAuthorityInfoByRoleId(Long roleId);

    void clearUserAuthorityInfoByMenuId(Long menuId);

    void updateStatus(Long userId);

    List<SysUser> getUserList();

    List<EchartsBie> getGenderBie();
}
