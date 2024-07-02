package com.www.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.mp.MyPage;
import com.www.pojo.SysRole;
import com.www.pojo.SysRoleMenu;
import com.www.pojo.SysUserRole;
import com.www.service.SysRoleMenuService;
import com.www.service.SysRoleService;
import com.www.service.SysUserRoleService;
import com.www.service.SysUserService;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/29/19:45
 * @Description:
 */
@RestController
@Api(tags = "角色管理")
@RequestMapping("/sys/role")
public class SysRoleController {


    private final SysRoleService sysRoleService;

    private final SysRoleMenuService sysRoleMenuService;

    private final SysUserService sysUserService;

    private final SysUserRoleService sysUserRoleService;

    private final MyPage myPage;

    public SysRoleController(SysRoleService sysRoleService,
                             SysRoleMenuService sysRoleMenuService,
                             SysUserService sysUserService,
                             SysUserRoleService sysUserRoleService,
                             MyPage myPage) {
        this.sysRoleService = sysRoleService;
        this.sysRoleMenuService = sysRoleMenuService;
        this.sysUserService = sysUserService;
        this.sysUserRoleService = sysUserRoleService;
        this.myPage = myPage;
    }

    /**
     * 获取当前用户角色详情和菜单信息，关联角色菜单中间表
     *
     * @param id
     * @return
     */
    @PreAuthorize("hasAuthority('sys:role:list')")
    @GetMapping("/info/{id}")
    public Result info(@PathVariable("id") Long id) {
        SysRole sysRole = sysRoleService.getById(id);
        // 获取角色相关联的菜单id
        List<SysRoleMenu> roleMenus = sysRoleMenuService.list(new QueryWrapper<SysRoleMenu>().eq("role_id", id));
        List<Long> menuIds = roleMenus.stream().map(p -> p.getMenuId()).collect(Collectors.toList());
        sysRole.setMenusIds(menuIds);
        return Result.success(sysRole);
    }

    /**
     * 查询角色列表，分页查询和模糊查询
     *
     * @param name
     * @return
     */
    @PreAuthorize("hasAuthority('sys:role:list')")
    @GetMapping("/list")
    public Result list(String name) {
        Page<SysRole> pageData = sysRoleService.page(myPage.getPage(),
                new QueryWrapper<SysRole>().like(StrUtil.isNotBlank(name), "name", name)
        );
        return Result.success(pageData);
    }

    /**
     * 新增角色
     *
     * @param sysRole
     * @return
     */
    @PreAuthorize("hasAuthority('sys:role:save')")
    @PostMapping("/save")
    public Result save(@Validated @RequestBody SysRole sysRole) {
        sysRole.setCreated(new Date());
        // 设置角色的状态为1，表示正常。在数据库设计已完成默认值设置
        sysRoleService.save(sysRole);
        return Result.success(sysRole);
    }

    /**
     * 更新角色信息
     *
     * @param sysRole
     * @return
     */
    @PreAuthorize("hasAuthority('sys:role:update')")
    @PostMapping("/update")
    public Result update(@Validated @RequestBody SysRole sysRole) {

        sysRole.setUpdated(new Date());
        sysRoleService.updateById(sysRole);
        // 更新缓存
        sysUserService.clearUserAuthorityInfoByRoleId(sysRole.getId());
        return Result.success(sysRole);
    }

    /**
     * 删除角色信息，并清除缓存
     *
     * @param ids
     * @return
     */
    @PreAuthorize("hasAuthority('sys:role:delete')")
    @PostMapping("/delete")
    @Transactional
    public Result info(@RequestBody Long[] ids) {
        // 数组转集合
        sysRoleService.removeByIds(Arrays.asList(ids));

        // 删除中间表
        sysUserRoleService.remove(new QueryWrapper<SysUserRole>().in("role_id", ids));
        sysRoleMenuService.remove(new QueryWrapper<SysRoleMenu>().in("role_id", ids));
        // 缓存同步删除
        Arrays.stream(ids).forEach(id -> {
            // 更新缓存
            sysUserService.clearUserAuthorityInfoByRoleId(id);
        });
        return Result.success("删除成功");
    }

    /**
     * 给用户分配权限接口
     *
     * @param roleId
     * @param menuIds
     * @return
     */
    @PreAuthorize("hasAuthority('sys:role:perm')")
    @PostMapping("/perm/{roleId}")
    @Transactional
    public Result list(@PathVariable("roleId") Long roleId, @RequestBody Long[] menuIds) {

        List<SysRoleMenu> sysRoleMenus = new ArrayList<>();
        Arrays.stream(menuIds).forEach(menuId -> {
            SysRoleMenu roleMenu = new SysRoleMenu();
            roleMenu.setMenuId(menuId);
            roleMenu.setRoleId(roleId);

            sysRoleMenus.add(roleMenu);
        });

        // 先删除原来的记录，再保存新的
        sysRoleMenuService.remove(new QueryWrapper<SysRoleMenu>().eq("role_id", roleId));
        sysRoleMenuService.saveBatch(sysRoleMenus);

        // 删除缓存
        sysUserService.clearUserAuthorityInfoByRoleId(roleId);
        return Result.success(menuIds);
    }
}
