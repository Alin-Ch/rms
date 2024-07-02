package com.www.service;

import com.www.pojo.SysRole;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author anxm
* @description 针对表【sys_role(角色表)】的数据库操作Service
* @createDate 2024-03-24 19:46:39
*/
public interface SysRoleService extends IService<SysRole> {

    List<SysRole> listRolesByUserId(Long userId);
}
