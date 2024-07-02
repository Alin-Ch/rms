package com.www.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.SysOrder;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * @author Alin
 * @description 针对表【sys_order】的数据库操作Mapper
 * @createDate 2024-04-27 21:40:08
 * @Entity com.wfzm.pojo.SysOrder
 */
@Mapper
public interface SysOrderMapper extends BaseMapper<SysOrder> {

    IPage<SysOrder> selectBySeller(Page<SysOrder> page, Long ownerId, String order_no);

    IPage<SysOrder> selectByAdmin(Page<SysOrder> page, String order_no);

    @Select("select * from sys_order where order_no=#{outTradeNo}")
    SysOrder findByOrderNo(String outTradeNo);

    IPage<SysOrder> selectByBuyer(Page<SysOrder> page, Long userId, String order_no, Integer status);

    @Select("SELECT SUM(money) AS total_money FROM sys_order WHERE `status` != 0;")
    Long getTradedCount();

}




