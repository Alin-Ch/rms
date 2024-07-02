package com.www.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.mapper.SysRoleMapper;
import com.www.pojo.SysRole;
import com.www.pojo.SysUserRole;
import com.www.service.SysUserRoleService;
import com.www.mapper.SysUserRoleMapper;
import org.springframework.stereotype.Service;

/**
* @author anxm
* @description 针对表【sys_user_role(用户角色表)】的数据库操作Service实现
* @createDate 2024-03-24 19:47:02
*/
@Service
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleMapper, SysUserRole>
    implements SysUserRoleService{

    private final SysRoleMapper sysRoleMapper;

    public SysUserRoleServiceImpl(SysRoleMapper sysRoleMapper) {
        this.sysRoleMapper = sysRoleMapper;
    }


    @Override
    public SysRole getByUserId(Long id) {
        return sysRoleMapper.getByUserId(id);
    }
}




