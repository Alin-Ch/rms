package com.www.service;

import com.www.pojo.SysFavor;
import com.baomidou.mybatisplus.extension.service.IService;

/**
* @author Alin
* @description 针对表【sys_favor】的数据库操作Service
* @createDate 2024-05-08 23:34:49
*/
public interface SysFavorService extends IService<SysFavor> {

    void deleteFavor(Long userid, Long houseid);
}
