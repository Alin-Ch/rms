package com.www.service;

import com.www.common.dto.SysMenuDto;
import com.www.pojo.SysMenu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author anxm
* @description 针对表【sys_menu(菜单表)】的数据库操作Service
* @createDate 2024-03-24 19:46:26
*/
public interface SysMenuService extends IService<SysMenu> {

    List<SysMenuDto> getCurrentUserNav();

    List<SysMenu> tree();
}
