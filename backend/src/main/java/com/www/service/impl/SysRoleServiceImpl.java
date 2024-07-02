package com.www.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.SysRole;
import com.www.service.SysRoleService;
import com.www.mapper.SysRoleMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author anxm
* @description 针对表【sys_role(角色表)】的数据库操作Service实现
* @createDate 2024-03-24 19:46:39
*/
@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService{


    @Override
    public List<SysRole> listRolesByUserId(Long userId) {
        List<SysRole> sysRoles = this.list(new QueryWrapper<SysRole>()
                .inSql("id", "select role_id from sys_user_role where user_id = " + userId));

        return sysRoles;
    }
}




