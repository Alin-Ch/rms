package com.www.mapper;

import com.www.pojo.SysRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
* @author anxm
* @description 针对表【sys_role(角色表)】的数据库操作Mapper
* @createDate 2024-03-24 19:46:39
* @Entity com.wfzm.pojo.SysRole
*/
@Mapper
public interface SysRoleMapper extends BaseMapper<SysRole> {

    SysRole getByUserId(Long id);
}




