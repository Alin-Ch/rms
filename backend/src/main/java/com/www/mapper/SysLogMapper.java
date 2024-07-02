package com.www.mapper;

import com.www.pojo.EchartsLine;
import com.www.pojo.SysLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_log】的数据库操作Mapper
* @createDate 2024-05-12 11:18:42
* @Entity com.wfzm.pojo.SysLog
*/
@Mapper
public interface SysLogMapper extends BaseMapper<SysLog> {

    List<EchartsLine> getLogBie();

    List<SysLog> getLogBieData();
}




