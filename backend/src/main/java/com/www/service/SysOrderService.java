package com.www.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.SysOrder;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author Alin
* @description 针对表【sys_order】的数据库操作Service
* @createDate 2024-04-27 21:40:08
*/
public interface SysOrderService extends IService<SysOrder> {

    IPage<SysOrder> selectBySeller(Page<SysOrder> page, Long ownerId, String order_no);

    IPage<SysOrder> selectByAdmin(Page<SysOrder> page, String order_no);

    IPage<SysOrder> selectByBuyer(Page<SysOrder> page, Long id, String order_no, Integer status);

    Long getTradedCount();
}
