package com.www.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.SysFavor;
import com.www.service.SysFavorService;
import com.www.mapper.SysFavorMapper;
import org.springframework.stereotype.Service;

/**
* @author Alin
* @description 针对表【sys_favor】的数据库操作Service实现
* @createDate 2024-05-08 23:34:49
*/
@Service
public class SysFavorServiceImpl extends ServiceImpl<SysFavorMapper, SysFavor>
    implements SysFavorService{
    private final SysFavorMapper sysFavorMapper;

    public SysFavorServiceImpl(SysFavorMapper sysFavorMapper) {
        this.sysFavorMapper = sysFavorMapper;
    }

    @Override
    public void deleteFavor(Long userid, Long houseid) {
        sysFavorMapper.delete(new QueryWrapper<SysFavor>().eq("user_id", userid).eq("house_id", houseid));
    }
}




