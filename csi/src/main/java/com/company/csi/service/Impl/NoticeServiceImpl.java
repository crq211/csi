package com.company.csi.service.Impl;

import com.company.csi.mapper.NoticeMapper;
import com.company.csi.pojo.*;
import com.company.csi.service.NoticeService;
import com.company.csi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 公告接口实现类
 */
@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    NoticeMapper noticeMapper;

    @Autowired
    UserService userService;

    @Override
    public List<Notice> list() {
        NoticeExample example = new NoticeExample();
        example.setOrderByClause("id desc");
        List<Notice> noticeList = noticeMapper.selectByExample(example);
        setUser(noticeList);
        return noticeList;
    }

    @Override
    public void add(Notice bean) {
        noticeMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        noticeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Notice bean) {
        noticeMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public Notice get(int id) {
        return noticeMapper.selectByPrimaryKey(id);
    }

    @Override
    public void deleteAll(List<Integer> idList) {
        NoticeExample example = new NoticeExample();
        example.createCriteria().andIdIn(idList);
        noticeMapper.deleteByExample(example);
    }

    @Override
    public List<Notice> search(String noticeName, String noticeMsg) {
        NoticeExample example = new NoticeExample();
        example.createCriteria().andNoticeNameLike("%" + noticeName + "%")
                .andMessageLike("%" + noticeMsg + "%");
        List<Notice> noticeList = noticeMapper.selectByExample(example);
        setUser(noticeList);
        return noticeList;
    }

    public void setUser(Notice notice) {
        User user = userService.get(notice.getUserId());
        notice.setUser(user);
    }

    public void setUser(List<Notice> noticeList) {
        for (Notice notice : noticeList) {
            setUser(notice);
        }
    }
}
