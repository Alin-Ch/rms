package com.www.common.mp;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.ServletRequestUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA 2021.
 *
 * @Author: Mr Qin
 * @Date: 2024/03/29/20:21
 * @Description:    分页
 */
@Component
public class MyPage {

    private final HttpServletRequest req;

    @Autowired
    public MyPage(HttpServletRequest req) {
        this.req = req;
    }

    public Page getPage(){
        int current = ServletRequestUtils.getIntParameter(req, "current", 1);
        int size = ServletRequestUtils.getIntParameter(req, "size", 10);
        return new Page(current, size);
    }
}
