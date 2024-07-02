package com.www.service;

import com.www.pojo.SysRole;
import com.www.pojo.SysUserRole;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author anxm
* @description 针对表【sys_user_role(用户角色表)】的数据库操作Service
* @createDate 2024-03-24 19:47:02
*/
public interface SysUserRoleService extends IService<SysUserRole> {


    SysRole getByUserId(Long id);
}
