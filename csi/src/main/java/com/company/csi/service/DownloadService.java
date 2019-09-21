package com.company.csi.service;

import com.company.csi.pojo.Download;
import com.company.csi.pojo.Position;

import java.util.List;

/**
 * 下载中心接口类
 */
public interface DownloadService {

    List<Download> list();

    void add(Download bean);

    void delete(int id);

    void update(Download bean);

    Download get(int id);

    void deleteAll(List<Integer> idList);

    /**
     * 根据文档标题模糊搜索文档
     */
    List<Download> search(String downloadTitle);
}
