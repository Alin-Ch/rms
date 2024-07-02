package com.www.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.SysComment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
* @author Alin
* @description 针对表【sys_comment】的数据库操作Mapper
* @createDate 2024-05-12 14:01:20
* @Entity com.wfzm.pojo.SysComment
*/
@Mapper
public interface SysCommentMapper extends BaseMapper<SysComment> {

    Page<SysComment> getByHouseId(Page<SysComment> page, Long houseId);

    List<SysComment> getReplayList(Long parentId);
}




