package com.www.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.SysCarousel;
import com.www.service.SysCarouselService;
import com.www.mapper.SysCarouselMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_carousel】的数据库操作Service实现
* @createDate 2024-05-03 19:30:45
*/
@Service
public class SysCarouselServiceImpl extends ServiceImpl<SysCarouselMapper, SysCarousel>
    implements SysCarouselService{

    private final SysCarouselMapper sysCarouselMapper;

    public SysCarouselServiceImpl(SysCarouselMapper sysCarouselMapper) {
        this.sysCarouselMapper = sysCarouselMapper;
    }

    @Override
    public List<SysCarousel> getBannerList() {
        List<SysCarousel> list = sysCarouselMapper.getBannerList();
        return list;
    }
}




