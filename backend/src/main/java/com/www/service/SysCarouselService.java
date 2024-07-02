package com.www.service;

import com.www.pojo.SysCarousel;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_carousel】的数据库操作Service
* @createDate 2024-05-03 19:30:45
*/
public interface SysCarouselService extends IService<SysCarousel> {

    List<SysCarousel> getBannerList();

}
