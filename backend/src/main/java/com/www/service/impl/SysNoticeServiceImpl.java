package com.www.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.SysNotice;
import com.www.service.SysNoticeService;
import com.www.mapper.SysNoticeMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_notice】的数据库操作Service实现
* @createDate 2024-05-03 19:30:45
*/
@Service
public class SysNoticeServiceImpl extends ServiceImpl<SysNoticeMapper, SysNotice>
    implements SysNoticeService{
    private final SysNoticeMapper sysNoticeMapper;

    public SysNoticeServiceImpl(SysNoticeMapper sysNoticeMapper) {
        this.sysNoticeMapper = sysNoticeMapper;
    }

    @Override
    public List<SysNotice> getNotice() {
        List<SysNotice> list = sysNoticeMapper.getNotice();
        return list;
    }

    @Override
    public IPage<SysNotice> getPageData(Page<SysNotice> page) {
        return sysNoticeMapper.getPageData(page);
    }
}




