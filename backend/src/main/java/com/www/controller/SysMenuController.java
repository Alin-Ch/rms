package com.www.controller;

import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.www.common.dto.SysMenuDto;
import com.www.pojo.SysMenu;
import com.www.pojo.SysRoleMenu;
import com.www.pojo.SysUser;
import com.www.service.SysMenuService;
import com.www.service.SysRoleMenuService;
import com.www.service.SysUserService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/28/11:00
 * @Description:
 */
@RestController
@Api(tags = "菜单管理")
@RequestMapping("/sys/menu")
public class SysMenuController {

    private final SysUserService sysUserService;

    private final SysMenuService sysMenuService;

    private final SysRoleMenuService sysRoleMenuService;

    public SysMenuController(SysUserService sysUserService,
                             SysMenuService sysMenuService,
                             SysRoleMenuService sysRoleMenuService) {
        this.sysUserService = sysUserService;
        this.sysMenuService = sysMenuService;
        this.sysRoleMenuService = sysRoleMenuService;
    }

    /**
     * 获取当前用户的菜单和权限信息
     *
     * @param principal
     * @return
     */
    @GetMapping("/nav")
    public Result nav(Principal principal) {
        SysUser sysUser = sysUserService.getByUsername(principal.getName());

        // 获取权限信息
        String authorityInfo = sysUserService.getUserAuthorityInfo(sysUser.getId());    // ROLE_normal,ROLE_admin,sys:user:save……
        // 将上面的字符串转换为数组，将逗号拆开放到数组中去
        String[] authorityInfoArray = StringUtils.tokenizeToStringArray(authorityInfo, ",");

        // 获取导航栏信息
        List<SysMenuDto> navs = sysMenuService.getCurrentUserNav();

        return Result.success(MapUtil.builder()
                .put("authorities", authorityInfoArray)
                .put("nav", navs)
                .map()
        );
    }

    /**
     * 获取当前行的菜单信息，就是点击编辑时要显示本行的信息，即根据ID查询一条记录
     *
     * @param id
     * @return
     */
    @PreAuthorize("hasAuthority('sys:menu:list')")
    @GetMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id) {
        return Result.success(sysMenuService.getById(id));
    }

    /**
     * 获取所有菜单信息，并转成树状结构
     *
     * @return
     */
    @PreAuthorize("hasAuthority('sys:menu:list')")
    @GetMapping("/list")
    public Result list() {
        List<SysMenu> menus = sysMenuService.tree();
        return Result.success(menus);
    }

    /**
     * 新增菜单
     *
     * @param sysMenu
     * @return
     */
    @PreAuthorize("hasAuthority('sys:menu:save')")
    @PostMapping("/save")
    public Result save(@Validated @RequestBody SysMenu sysMenu) {
        sysMenu.setCreated(new Date());
        sysMenuService.save(sysMenu);
        return Result.success(sysMenu);
    }

    /**
     * 更新菜单
     *
     * @param sysMenu
     * @return
     */
    @PreAuthorize("hasAuthority('sys:menu:update')")
    @PostMapping("/update")
    public Result update(@Validated @RequestBody SysMenu sysMenu) {
        sysMenu.setUpdated(new Date());
        sysMenuService.updateById(sysMenu);
        // 删除所有与菜单相关的权限缓存
        sysUserService.clearUserAuthorityInfoByMenuId(sysMenu.getId());
        return Result.success(sysMenu);
    }

    @PreAuthorize("hasAuthority('sys:menu:delete')")
    @PostMapping("/delete/{id}")
    public Result delete(@PathVariable("id") Long id) {

        long count = sysMenuService.count(new QueryWrapper<SysMenu>().eq("parent_id", id));
        if (count > 0) {
            return Result.fail("请先删除子菜单");
        }
        // 删除所有与菜单相关的权限缓存
        sysUserService.clearUserAuthorityInfoByMenuId(id);
        // 同步删除中间关联表
        sysRoleMenuService.remove(new QueryWrapper<SysRoleMenu>().eq("menu_id", id));

        sysMenuService.removeById(id);
        return Result.success("删除成功");
    }
}
