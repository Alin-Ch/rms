package com.www.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.EchartsBie;
import com.www.pojo.SysHouse;
import com.www.service.SysHouseService;
import com.www.mapper.SysHouseMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Alin
 * @description 针对表【sys_house】的数据库操作Service实现
 * @createDate 2024-04-27 21:40:08
 */
@Service
public class SysHouseServiceImpl extends ServiceImpl<SysHouseMapper, SysHouse>
        implements SysHouseService {

    private final SysHouseMapper sysHouseMapper;

    public SysHouseServiceImpl(SysHouseMapper sysHouseMapper) {
        this.sysHouseMapper = sysHouseMapper;
    }

    @Override
    public IPage<SysHouse> findBySearch(Page<SysHouse> page, String name, String username, String ownername) {
        return sysHouseMapper.findBySearch(page, name, username, ownername);
    }

    @Override
    public void addWatched(Long id) {
        sysHouseMapper.addWatched(id);
    }

    @Override
    public List<EchartsBie> getHouseStatusBie() {
        return sysHouseMapper.getHouseStatusBie();
    }

    @Override
    public Page<SysHouse> getPageData(Page page, String name, Long owner_id) {
        return sysHouseMapper.getPageData(page, name, owner_id);
    }


}




