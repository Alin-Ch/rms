package com.www.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.SysNotice;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_notice】的数据库操作Mapper
* @createDate 2024-05-03 19:30:45
* @Entity com.wfzm.pojo.SysNotice
*/
@Mapper
public interface SysNoticeMapper extends BaseMapper<SysNotice> {

    List<SysNotice> getNotice();

    IPage<SysNotice> getPageData(Page<SysNotice> page);
}




