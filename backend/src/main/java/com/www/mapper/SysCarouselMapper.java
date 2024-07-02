package com.www.mapper;

import com.www.pojo.SysCarousel;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_carousel】的数据库操作Mapper
* @createDate 2024-05-03 19:30:45
* @Entity com.wfzm.pojo.SysCarousel
*/
@Mapper
public interface SysCarouselMapper extends BaseMapper<SysCarousel> {

    List<SysCarousel> getBannerList();
}




