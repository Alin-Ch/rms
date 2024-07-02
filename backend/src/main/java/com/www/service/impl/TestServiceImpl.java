package com.www.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.pojo.Test;
import com.www.service.TestService;
import com.www.mapper.TestMapper;
import org.springframework.stereotype.Service;

/**
* @author Alin
* @description 针对表【test】的数据库操作Service实现
* @createDate 2024-05-22 22:18:10
*/
@Service
public class TestServiceImpl extends ServiceImpl<TestMapper, Test>
    implements TestService{

}




