package com.www.service;

import com.www.pojo.EchartsLine;
import com.www.pojo.SysLog;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_log】的数据库操作Service
* @createDate 2024-05-12 11:18:42
*/
public interface SysLogService extends IService<SysLog> {

    List<EchartsLine> getLogBie();

    List<SysLog> getLogBieData();
}
