package com.www.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.www.pojo.SysComment;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author Alin
* @description 针对表【sys_comment】的数据库操作Service
* @createDate 2024-05-12 14:01:20
*/
public interface SysCommentService extends IService<SysComment> {

    Page<SysComment> getByHouseId(Page<SysComment> page, Long houseId);
}
