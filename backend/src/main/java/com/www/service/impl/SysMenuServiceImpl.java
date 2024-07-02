package com.www.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.common.dto.SysMenuDto;
import com.www.mapper.SysUserMapper;
import com.www.pojo.SysMenu;
import com.www.pojo.SysUser;
import com.www.service.SysMenuService;
import com.www.mapper.SysMenuMapper;
import com.www.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author anxm
 * @description 针对表【sys_menu(菜单表)】的数据库操作Service实现
 * @createDate 2024-03-24 19:46:26
 */
@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {

    private final SysUserService sysUserService;

    private final SysUserMapper sysUserMapper;

    // SysUserService延迟加载，解决循环依赖
    @Autowired
    public SysMenuServiceImpl(SysUserService sysUserService,
                              SysUserMapper sysUserMapper) {
        this.sysUserService = sysUserService;
        this.sysUserMapper = sysUserMapper;
    }

    @Override
    public List<SysMenuDto> getCurrentUserNav() {
        // 获取当前用户信息
        String username = (String) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        SysUser sysUser = sysUserService.getByUsername(username);

        List<Long> menuIds = sysUserMapper.getNavMenuIds(sysUser.getId());
        List<SysMenu> menus = this.listByIds(menuIds);

        // 构建菜单树
        List<SysMenu> menuTree = buildTreeMenu(menus);

        // 实体转DTO
        return convert(menuTree);
    }

    @Override
    public List<SysMenu> tree() {
        // 获取所有菜单信息
        List<SysMenu> sysMenus = this.list(new QueryWrapper<SysMenu>().orderByAsc("order_num"));
        // 转成树状结构
        return buildTreeMenu(sysMenus);

    }

    private List<SysMenuDto> convert(List<SysMenu> menuTree) {
        List<SysMenuDto> menuDtos = new ArrayList<>();
        menuTree.forEach(m -> {
            SysMenuDto dto = new SysMenuDto();

            dto.setId(m.getId());
            dto.setName(m.getPerms());
            dto.setIcon(m.getIcon());
            dto.setTitle(m.getName());
            dto.setComponent(m.getComponent());
            dto.setPath(m.getPath());

            // 递归转换子节点的子节点
            if (m.getChildren().size() > 0){
                // 子节点调用当前方法进行再次转换
                dto.setChildren(convert(m.getChildren()));
            }

            menuDtos.add(dto);
        });
        return menuDtos;
    }

    // 转树状结构方法
    /*private List<SysMenu> buildTreeMenu(List<SysMenu> menus) {
        List<SysMenu> finalMenus = new ArrayList<>();

        // 先各自寻找到各自的孩子
        for (SysMenu menu : menus) {
            for (SysMenu e : menus) {
                if (menu.getId() == e.getParentId()) {
                    menu.getChildren().add(e);
                }
            }
            // 提取出父节点
            if (menu.getParentId() == 0L) {
                finalMenus.add(menu);
            }
        }
        return finalMenus;
    }*/
    private List<SysMenu> buildTreeMenu(List<SysMenu> menus) {
        Map<Long, SysMenu> menuMap = new HashMap<>();
        List<SysMenu> finalMenus = new ArrayList<>();

        // 将菜单项放入map中
        for (SysMenu menu : menus) {
            menuMap.put(menu.getId(), menu);
        }

        // 构建菜单树
        for (SysMenu menu : menus) {
            if (menu.getParentId() == 0L) {
                // 如果父菜单为0，则直接加入finalMenus
                finalMenus.add(menu);
            } else {
                // 如果有父菜单，则加入父菜单的children列表中
                SysMenu parentMenu = menuMap.get(menu.getParentId());
                if (parentMenu != null) {
                    parentMenu.getChildren().add(menu);
                }
            }
        }
        return finalMenus;
    }
}




