package com.www.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.www.common.mp.MyPage;
import com.www.pojo.SysComment;
import com.www.pojo.SysUser;
import com.www.service.SysCommentService;
import com.www.mapper.SysCommentMapper;
import com.www.service.SysUserService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Alin
 * @description 针对表【sys_comment】的数据库操作Service实现
 * @createDate 2024-05-12 14:01:20
 */
@Service
public class SysCommentServiceImpl extends ServiceImpl<SysCommentMapper, SysComment>
        implements SysCommentService {

    private final SysCommentMapper sysCommentMapper;
    private final SysUserService sysUserService;
    private final MyPage myPage;

    public SysCommentServiceImpl(SysCommentMapper sysCommentMapper, SysUserService sysUserService, MyPage myPage) {
        this.sysCommentMapper = sysCommentMapper;
        this.sysUserService = sysUserService;
        this.myPage = myPage;
    }

    @Override
    public Page<SysComment> getByHouseId(Page<SysComment> page, Long houseId) {
        // 根据文章id查询评论列表(不包含回复)
        Page<SysComment> parentList = sysCommentMapper.getByHouseId(page, houseId);
        for (SysComment comment : parentList.getRecords()) {
            Long parentId = comment.getId();
            SysUser user = sysUserService.getById(comment.getUserId());
            comment.setUser(user);
            // 分页查询回复
            List<SysComment> replayList = sysCommentMapper.getReplayList(parentId);
            for (SysComment replayComment : replayList) {
                if (replayComment != null){
                    SysUser user2 = sysUserService.getById(replayComment.getUserId());
                    replayComment.setUser(user2);
                }
            }
            comment.setReply(replayList);
        }
        return parentList;
    }
}




