package com.www.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.SysNotice;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_notice】的数据库操作Service
* @createDate 2024-05-03 19:30:45
*/
public interface SysNoticeService extends IService<SysNotice> {

    List<SysNotice> getNotice();

    IPage<SysNotice> getPageData(Page<SysNotice> page);
}
