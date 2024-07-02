package com.www.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.mapper.SysHouseMapper;
import com.www.mapper.SysUserMapper;
import com.www.pojo.*;
import com.www.service.SysHouseShowService;
import com.www.service.SysHouseShowVideoService;
import com.www.service.SysOrderService;
import com.www.mapper.SysOrderMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Alin
 * @description 针对表【sys_order】的数据库操作Service实现
 * @createDate 2024-04-27 21:40:08
 */
@Service
public class SysOrderServiceImpl extends ServiceImpl<SysOrderMapper, SysOrder>
        implements SysOrderService {
    private final SysOrderMapper sysOrderMapper;
    private final SysHouseMapper sysHouseMapper;
    private final SysUserMapper sysUserMapper;

    private final SysHouseShowService sysHouseShowService;
    private final SysHouseShowVideoService sysHouseShowVideoService;

    public SysOrderServiceImpl(SysOrderMapper sysOrderMapper, SysHouseMapper sysHouseMapper, SysUserMapper sysUserMapper, SysHouseShowService sysHouseShowService, SysHouseShowVideoService sysHouseShowVideoService) {
        this.sysOrderMapper = sysOrderMapper;
        this.sysHouseMapper = sysHouseMapper;
        this.sysUserMapper = sysUserMapper;
        this.sysHouseShowService = sysHouseShowService;
        this.sysHouseShowVideoService = sysHouseShowVideoService;
    }

    @Override
    public IPage<SysOrder> selectBySeller(Page<SysOrder> page, Long ownerId, String order_no) {
        IPage<SysOrder> list = sysOrderMapper.selectBySeller(page, ownerId, order_no);
        // 遍历订单列表，查询并设置对应的房屋信息
        for (SysOrder order : list.getRecords()) {
            SysHouse house = sysHouseMapper.selectById(order.getHouseId()); // 根据 house_id 查询房屋信息

            order.setHouse(house); // 设置订单的房屋信息
            SysUser owner = sysUserMapper.selectById(order.getOwnerId());
            order.setOwner(owner);
            SysUser user = sysUserMapper.selectById(order.getUserId());
            order.setUser(user);

            List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", house.getId()));
            house.setList(houseShowList);
            List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", house.getId()));
            house.setVideoList(houseShowVideoList);
            house.setOwner(owner);
            house.setUser(user);
        }
        return list;
    }

    @Override
    public IPage<SysOrder> selectByAdmin(Page<SysOrder> page, String order_no) {
        IPage<SysOrder> orderList = sysOrderMapper.selectByAdmin(page, order_no);
        // 遍历订单列表，查询并设置对应的房屋信息
        for (SysOrder order : orderList.getRecords()) {
            SysHouse house = sysHouseMapper.selectById(order.getHouseId()); // 根据 house_id 查询房屋信息

            order.setHouse(house); // 设置订单的房屋信息
            SysUser owner = sysUserMapper.selectById(order.getOwnerId());
            order.setOwner(owner);
            SysUser user = sysUserMapper.selectById(order.getUserId());
            order.setUser(user);

            List<SysHouseShow> houseShowList = sysHouseShowService.list(new QueryWrapper<SysHouseShow>().eq("house_id", house.getId()));
            house.setList(houseShowList);
            List<SysHouseShowVideo> houseShowVideoList = sysHouseShowVideoService.list(new QueryWrapper<SysHouseShowVideo>().eq("house_id", house.getId()));
            house.setVideoList(houseShowVideoList);
            house.setOwner(owner);
            house.setUser(user);
        }
        return orderList;
    }

    @Override
    public IPage<SysOrder> selectByBuyer(Page<SysOrder> page, Long id, String order_no, Integer status) {
        IPage<SysOrder> pageData = sysOrderMapper.selectByBuyer(page, id, order_no, status);

        return pageData;
    }

    @Override
    public Long getTradedCount() {
        return sysOrderMapper.getTradedCount();
    }
}




