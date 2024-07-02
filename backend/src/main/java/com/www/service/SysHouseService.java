package com.www.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.EchartsBie;
import com.www.pojo.SysHouse;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_house】的数据库操作Service
* @createDate 2024-04-27 21:40:08
*/
public interface SysHouseService extends IService<SysHouse> {

    IPage<SysHouse> findBySearch(Page<SysHouse> page, String name, String username, String ownername);

    void addWatched(Long id);

    List<EchartsBie> getHouseStatusBie();

    Page<SysHouse> getPageData(Page page, String name, Long user_id);
}
