package com.www.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.EchartsLine;
import com.www.pojo.SysLog;
import com.www.service.SysLogService;
import com.www.mapper.SysLogMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
* @author Alin
* @description 针对表【sys_log】的数据库操作Service实现
* @createDate 2024-05-12 11:18:42
*/
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog>
    implements SysLogService{
    private final SysLogMapper sysLogMapper;

    public SysLogServiceImpl(SysLogMapper sysLogMapper) {
        this.sysLogMapper = sysLogMapper;
    }

    @Override
    public List<EchartsLine> getLogBie() {
        List<EchartsLine> list = sysLogMapper.getLogBie();
        // 使用Java 8的流API反转列表
        List<EchartsLine> reversedList = new ArrayList<>(list);
        Collections.reverse(reversedList);
        return list;
    }

    @Override
    public List<SysLog> getLogBieData() {
        return sysLogMapper.getLogBieData();
    }
}




