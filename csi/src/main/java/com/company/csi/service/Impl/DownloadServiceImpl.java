package com.company.csi.service.Impl;

import com.company.csi.mapper.DownloadMapper;
import com.company.csi.pojo.*;
import com.company.csi.service.DownloadService;
import com.company.csi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 下载中心接口实现类
 */
@Service
public class DownloadServiceImpl implements DownloadService{

    @Autowired
    DownloadMapper downloadMapper;

    @Autowired
    UserService userService;

    @Override
    public List<Download> list() {
        DownloadExample example = new DownloadExample();
        example.setOrderByClause("id desc");
        List<Download> downloadList = downloadMapper.selectByExample(example);
        setUser(downloadList);
        return downloadList;
    }

    @Override
    public void add(Download bean) {
        downloadMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        downloadMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Download bean) {
        downloadMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public Download get(int id) {
        return downloadMapper.selectByPrimaryKey(id);
    }

    @Override
    public void deleteAll(List<Integer> idList) {
        DownloadExample example = new DownloadExample();
        example.createCriteria().andIdIn(idList);
        downloadMapper.deleteByExample(example);
    }

    @Override
    public List<Download> search(String downloadTitle) {
        DownloadExample example = new DownloadExample();
        example.createCriteria().andTitleLike("%" + downloadTitle + "%");
        List<Download> downloadList = downloadMapper.selectByExample(example);
        setUser(downloadList);
        return downloadList;
    }

    public void setUser(Download download) {
        User user = userService.get(download.getUserId());
        download.setUser(user);
    }


    public void setUser(List<Download> downloadList) {
        for (Download download : downloadList) {
            setUser(download);
        }
    }
}
