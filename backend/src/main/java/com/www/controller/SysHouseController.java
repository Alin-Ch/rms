package com.www.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.common.aop.AutoLog;
import com.www.common.lang.Const;
import com.www.common.mp.MyPage;
import com.www.pojo.*;
import com.www.service.*;
import com.www.vo.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDate;
import java.util.*;

/**
 * @Author Alin
 * @date 2024/4/28 028 13:54
 * @Description:
 */
@RestController
@RequestMapping("/sys/house")
@Api(tags = "出租房管理")
public class SysHouseController {
    private final SysHouseService sysHouseService;
    private final SysHouseTypeService sysHouseTypeService;
    private final SysHouseShowService sysHouseShowService;
    private final SysHouseShowVideoService sysHouseShowVideoService;
    private final SysUserService sysUserService;
    private final SysHistoryService sysHistoryService;
    private final SysFavorService sysFavorService;
    private final UserHouseOperationService userHouseOperationService;
    private final MyPage myPage;

    // 地球半径（单位：公里）
    private static final double EARTH_RADIUS = 6371.0;

    public SysHouseController(SysHouseService sysHouseService,
                              SysHouseTypeService sysHouseTypeService, SysHouseShowService sysHouseShowService,
                              SysHouseShowVideoService sysHouseShowVideoService,
                              SysUserService sysUserService,
                              SysHistoryService sysHistoryService,
                              UserHouseOperationService userHouseOperationService, SysFavorService sysFavorService, MyPage myPage) {
        this.sysHouseService = sysHouseService;
        this.sysHouseTypeService = sysHouseTypeService;
        this.sysHouseShowService = sysHouseShowService;
        this.sysHouseShowVideoService = sysHouseShowVideoService;
        this.sysUserService = sysUserService;
        this.sysHistoryService = sysHistoryService;
        this.userHouseOperationService = userHouseOperationService;
        this.sysFavorService = sysFavorService;
        this.myPage = myPage;
    }

    @GetMapping("/info/list")
    @ApiOperation("查询所有")
    public Result getHouseList() {
        // List<SysHouse> houseList = sysHouseService.list();
        // 构建查询条件
        QueryWrapper<SysHouse> queryWrapper = new QueryWrapper<>();
        // queryWrapper.eq("status", 0);
        // 查询符合条件的房屋列表
        List<SysHouse> houseList = sysHouseService.list(queryWrapper);
        for (SysHouse house : houseList) {
            // 查询对应的用户信息
            SysUser user = sysUserService.getById(house.getOwnerId());
            // 将用户信息存入每个房屋对象的 owner 属性中
            house.setOwner(user);
        }
        return Result.success(houseList);
    }

    @GetMapping("/recommend/list")
    @ApiOperation("假的推荐")
    public Result getRecommendList(Principal principal) {
        // List<SysHouse> houseList = sysHouseService.list();
        // 构建查询条件
        QueryWrapper<SysHouse> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("status", 0);
        // 查询符合条件的房屋列表
        List<SysHouse> houseList = sysHouseService.list(queryWrapper);
        for (SysHouse house : houseList) {
            // 查询对应的用户信息
            SysUser user = sysUserService.getById(house.getOwnerId());
            // 将用户信息存入每个房屋对象的 owner 属性中
            house.setOwner(user);
            List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", house.getId()));
            house.setList(houseShowList);
            List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", house.getId()));
            house.setVideoList(houseShowVideoList);
        }
        return Result.success(houseList);
    }

    @GetMapping("/random")
    @ApiOperation("真的推荐房屋")
    public Result getRandomRecommendation(Principal principal) {
        // 从安全上下文获取主体，并根据当前登录用户查询用户实体
        if (principal != null) {
            SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            // 实现协同过滤推荐，根据皮尔逊相似度计算
            Map<Long, Map<Long, Double>> data = new HashMap<>();
            List<UserHouseOperation> list = userHouseOperationService.getAllUserOperation();
            for (UserHouseOperation userItemOperation : list) {
                Long userId = userItemOperation.getUserId();
                Long itemId = userItemOperation.getItemId();
                Double rt = userItemOperation.getValue();
                data.putIfAbsent(userId, new HashMap<>());
                data.get(userId).put(itemId, rt);
            }
            List<SysHouse> recommendedList = userHouseOperationService.BaseUserRecommend(data, user.getId(), 2, 10);
            for (SysHouse house : recommendedList) {
                // 假设 setHouseDetail 方法接受一个参数，并将房屋的详细信息设置进去
                setHouseDetail(house);
            }
            return Result.success(recommendedList);
        } else {
            List<SysHouse> randomRecommend = userHouseOperationService.randomRecommend(Const.HOW_MANY);
            for (SysHouse house : randomRecommend) {
                // 假设 setHouseDetail 方法接受一个参数，并将房屋的详细信息设置进去
                setHouseDetail(house);
            }
            return Result.success(randomRecommend);
        }
    }

    @GetMapping("/recommend/user")
    @ApiOperation("推荐用户")
    public Result getUserRecommendation(Principal principal) {
        // 从安全上下文获取主体，并根据当前登录用户查询用户实体
        if (principal != null) {
            SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            // 实现协同过滤推荐，根据皮尔逊相似度计算
            Map<Long, Map<Long, Double>> data = new HashMap<>();
            List<UserHouseOperation> list = userHouseOperationService.getAllHouseOperation();
            for (UserHouseOperation userItemOperation : list) {
                Long itemId = userItemOperation.getItemId();
                Long userId = userItemOperation.getUserId();
                Double rate = userItemOperation.getValue();
                data.putIfAbsent(itemId, new HashMap<>());  //Map接口的一个方法
                data.get(itemId).put(userId, rate);
            }
            List<SysUser> recommendedList = userHouseOperationService.userRecommend(data, user.getId(), 2, 10);

            return Result.success(recommendedList);
        } else {
            return Result.fail("用户未登录");
        }
    }

    @GetMapping("/nearby")
    @ApiOperation("查询附近房屋")
    public Result list(Double jingdu, Double weidu, Principal principal) {
        List<SysHouse> list = new ArrayList<SysHouse>();
        List<SysHouse> allHouse = sysHouseService.list();
        // 遍历所有房屋
        for (SysHouse house : allHouse) {
            if (house.getJingdu() == null || house.getWeidu() == null){
                continue;
            }
            // 计算房屋与传入经纬度点的距离
            double distance = calculateDistance(weidu, jingdu, Double.parseDouble(house.getWeidu()), Double.parseDouble(house.getJingdu()));
            // 如果距离小于或等于50km，则将该房屋添加到结果列表中
            if (distance <= 50.0) {
                list.add(house);
            }
        }
        // 排序房屋列表
        Collections.sort(list, new Comparator<SysHouse>() {
            @Override
            public int compare(SysHouse house1, SysHouse house2) {
                // 比较房屋之间的距离
                double distance1 = calculateDistance(weidu, jingdu, Double.parseDouble(house1.getWeidu()), Double.parseDouble(house1.getJingdu()));
                double distance2 = calculateDistance(weidu, jingdu, Double.parseDouble(house2.getWeidu()), Double.parseDouble(house2.getJingdu()));
                // 根据距离升序排序
                return Double.compare(distance2, distance1);
            }
        });
        // 查询房屋详情
        for (SysHouse house : list) {
            // 查询对应的用户信息
            SysUser user = sysUserService.getById(house.getOwnerId());
            // 将用户信息存入每个房屋对象的 owner 属性中
            house.setOwner(user);
            List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", house.getId()));
            house.setList(houseShowList);
            List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", house.getId()));
            house.setVideoList(houseShowVideoList);
        }

        return Result.success(list);
    }
    // 将角度转换为弧度
    private double toRadians(double degrees) {
        return Math.toRadians(degrees);
    }
    // 计算两个经纬度坐标之间的距离（单位：公里）
    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        // 将经纬度转换为弧度
        double radLat1 = toRadians(lat1);
        double radLon1 = toRadians(lon1);
        double radLat2 = toRadians(lat2);
        double radLon2 = toRadians(lon2);

        // 计算经纬度差值
        double deltaLat = radLat2 - radLat1;
        double deltaLon = radLon2 - radLon1;

        // 使用球面余弦定理计算距离
        double a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2) +
                Math.cos(radLat1) * Math.cos(radLat2) *
                        Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distance = EARTH_RADIUS * c;

        return distance;
    }






    @GetMapping("/random/user")
    public Result getRandomUserRecommendation(Principal principal) {
        // 从安全上下文获取主体，并根据当前登录用户查询用户实体
        if (principal != null) {
            SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            // 实现协同过滤推荐，根据皮尔逊相似度计算
            Map<Long, Map<Long, Double>> data = new HashMap<>();
            List<UserHouseOperation> list = userHouseOperationService.getAllUserOperation();
            for (UserHouseOperation userItemOperation : list) {
                Long userId = userItemOperation.getUserId();
                Long itemId = userItemOperation.getItemId();
                Double rt = userItemOperation.getValue();
                data.putIfAbsent(userId, new HashMap<>());
                data.get(userId).put(itemId, rt);
            }
            List<SysUser> recommendedList = userHouseOperationService.BaseBusinessRecommend(data, user.getId(), 2, 10);

            return Result.success(recommendedList);
        } else {
            return Result.fail("用户未登录");
        }
    }


    @GetMapping("/detail/{id}")
    @ApiOperation("根据id查详情--使用redis缓存")
    public Result getDetailById(@PathVariable("id") Long id, Principal principal) {
        SysHouse sysHouse = sysHouseService.getById(id);
        SysUser sysUser = sysUserService.getById(sysHouse.getOwnerId());
        sysHouse.setOwner(sysUser);
        List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", sysHouse.getId()));
        sysHouse.setList(houseShowList);
        List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", sysHouse.getId()));
        sysHouse.setVideoList(houseShowVideoList);
        // 根据上下文获取用户信息   这里我要存足迹  以及 推荐表
        if (principal != null) {
            // 将房屋的浏览数+1  登录了才算，避免恶意刷浏览量
            sysHouseService.addWatched(sysHouse.getId());
            SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            // 获取当前日期
            LocalDate currentDate = LocalDate.now();
            // new一个推荐表的实体
            UserHouseOperation userHouseOperation = new UserHouseOperation();
            userHouseOperation.setUserId(user.getId());
            userHouseOperation.setItemId(sysHouse.getId());
            userHouseOperation.setOperationType(1);  // 1是浏览
            userHouseOperation.setCreateTime(new Date());
            userHouseOperationService.save(userHouseOperation);
            // 查询条件
            QueryWrapper<SysHistory> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("user_id", user.getId())
                    .eq("house_id", sysHouse.getId())
                    .eq("DATE_FORMAT(create_time, '%Y-%m-%d')", currentDate.toString());
            // 查询符合条件的记录数量
            int existingCount = (int) sysHistoryService.count(queryWrapper);
            if (existingCount == 0) {
                // 如果历史记录不存在，则新增
                SysHistory sysHistory = new SysHistory();
                sysHistory.setUserId(user.getId());
                sysHistory.setHouseId(sysHouse.getId());
                sysHistory.setUserName(user.getUsername());
                sysHistory.setHouseName(sysHouse.getName());
                sysHistory.setCreateTime(new Date()); // 设置创建时间为当前时间
                // 执行插入操作
                sysHistoryService.save(sysHistory);
            } else {
                // 已存在相同的历史记录，可以进行相应的处理
            }


        }

        return Result.success(sysHouse);
    }

    @GetMapping("/shop/detail/{id}")
    @ApiOperation("根据id查店铺列表")
    public Result getShopDetailById(@PathVariable("id") Long id, Principal principal) {
        List<SysHouse> houseList = sysHouseService.list(new QueryWrapper<SysHouse>()
                .eq("owner_id", id));
        for (SysHouse sysHouse : houseList) {
            SysUser sysUser = sysUserService.getById(sysHouse.getOwnerId());
            sysHouse.setOwner(sysUser);
            List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", sysHouse.getId()));
            sysHouse.setList(houseShowList);
            List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", sysHouse.getId()));
            sysHouse.setVideoList(houseShowVideoList);
        }
        return Result.success(houseList);
    }


    @GetMapping("/list")
    @ApiOperation("分页查询")
    public Result list(String name, Long user_id, Principal principal) {
        // 分页查询、模糊查询
//        Page<SysHouse> page = myPage.getPage();
//        IPage<SysHouse> pageData = sysHouseService.findBySearch(page, name, username, ownername);

//        Page<SysHouse> pageData = sysHouseService.page(myPage.getPage(),
//                new QueryWrapper<SysHouse>().like(StrUtil.isNotBlank(name), "name", name)
//                        .eq(ObjectUtil.isNotNull(user_id), "owner_id", user_id)
//                        .orderByDesc("create_time"));

        Page<SysHouse> pageData = sysHouseService.getPageData(myPage.getPage(), name, user_id);

        // 遍历 SysHouse 对象列表，查询对应的 sys_house_show 数据
        for (SysHouse sysHouse : pageData.getRecords()) {
            // 查询 sys_house_show 表中 house_id = sysHouse.getId() 的数据
            List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", sysHouse.getId()));
            // 将查询到的数据加入到 SysHouse 对象中
            sysHouse.setList(houseShowList);
            // 查询 sys_house_show_video 表中 house_id = sysHouse.getId() 的数据
            List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", sysHouse.getId()));
            // 将查询到的数据加入到 SysHouse 对象中
            sysHouse.setVideoList(houseShowVideoList);
            // 查询 sys_user 表中 id = sysHouse.getOwnerId() 的用户信息
            SysUser owner = sysUserService.getById(sysHouse.getOwnerId());
            // 将查询到的用户信息加入到 SysHouse 对象中
            sysHouse.setOwner(owner);
            // 查询 sys_user 表中 id = sysHouse.getUserId() 的用户信息
            SysUser user = sysUserService.getById(sysHouse.getUserId());
            // 将查询到的用户信息加入到 SysHouse 对象中
            sysHouse.setUser(user);
        }
        return Result.success(pageData);
    }

    @PostMapping("/save")
    @AutoLog("新增商品")
    @ApiOperation("新增")
    public Result save(@RequestBody SysHouse sysHouse, Principal principal) {
        if (principal != null) {
            SysUser user = sysUserService.getOne(new QueryWrapper<SysUser>().eq("username", principal.getName()));
            sysHouse.setOwnerId(user.getId());
        }
        sysHouse.setCreateTime(new Date());
        sysHouseService.save(sysHouse);
        Long id = sysHouse.getId(); // 获取保存后的 id

        List<SysHouseShow> addList = sysHouse.getAddList();
        List<SysHouseShowVideo> vaddList = sysHouse.getVaddList();
        // 执行增加操作
        if (addList != null && !addList.isEmpty()) {
            for (SysHouseShow item : addList) {
                item.setHouseId(id);
                sysHouseShowService.save(item);
            }
        }
        // 执行视频增加操作
        if (vaddList != null && !vaddList.isEmpty()) {
            for (SysHouseShowVideo item : vaddList) {
                item.setHouseId(id);
                sysHouseShowVideoService.save(item);
            }
        }

        return Result.success(sysHouse);
    }

    @PostMapping("/update")
    @AutoLog("修改商品")
    @ApiOperation("修改")
    public Result update(@RequestBody SysHouse sysHouse) {
        sysHouse.setUpdateTime(new Date());
        if (sysHouse != null && sysHouse.getUserId() != null && sysHouse.getUserId() != 0) {
            sysHouse.setStatus(1);
        } else {
            long userId = 0L; // 使用L后缀来表示长整型常量
            sysHouse.setUserId(userId);
            sysHouse.setStatus(0);
        }
        sysHouseService.updateById(sysHouse);

        List<SysHouseShow> addList = sysHouse.getAddList();
        List<SysHouseShow> delList = sysHouse.getDelList();
        List<SysHouseShowVideo> vaddList = sysHouse.getVaddList();
        List<SysHouseShowVideo> vdelList = sysHouse.getVdelList();
        // 执行增加操作
        if (addList != null && !addList.isEmpty()) {
            for (SysHouseShow item : addList) {
                sysHouseShowService.save(item);
            }
        }
        // 执行删除操作
        if (delList != null && !delList.isEmpty()) {
            for (SysHouseShow item : delList) {
                sysHouseShowService.removeById(item.getId());
            }
        }
        // 执行视频增加操作
        if (vaddList != null && !vaddList.isEmpty()) {
            for (SysHouseShowVideo item : vaddList) {
                sysHouseShowVideoService.save(item);
            }
        }
        // 执行视频删除操作
        if (vdelList != null && !vdelList.isEmpty()) {
            for (SysHouseShowVideo item : vdelList) {
                sysHouseShowVideoService.removeById(item.getId());
            }
        }

        return Result.success("修改成功！");
    }

    @PostMapping("/delete")
    @ApiOperation("删除")
    @AutoLog("删除商品")
    @Transactional
    public Result info(@RequestBody Long[] ids) {
        sysHouseService.removeByIds(Arrays.asList(ids));
        // 删除中间表
        sysHouseShowService.remove(new QueryWrapper<SysHouseShow>().in("house_id", ids));
        sysHouseShowVideoService.remove(new QueryWrapper<SysHouseShowVideo>().in("house_id", ids));
        sysHistoryService.remove(new QueryWrapper<SysHistory>().in("house_id", ids));
        sysFavorService.remove(new QueryWrapper<SysFavor>().in("house_id", ids));
        return Result.success("删除成功");
    }

    // 设置房屋信息的方法
    public void setHouseDetail(SysHouse sysHouse) {
        // 查询对应的用户信息
        SysUser user = sysUserService.getById(sysHouse.getOwnerId());
        // 将用户信息存入每个房屋对象的 owner 属性中
        sysHouse.setOwner(user);
        List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", sysHouse.getId()));
        sysHouse.setList(houseShowList);
        List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", sysHouse.getId()));
        sysHouse.setVideoList(houseShowVideoList);
    }
}
