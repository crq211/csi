package com.company.csi.service;

import com.company.csi.pojo.Notice;
import com.company.csi.pojo.Staff;

import java.util.List;

/**
 * 公告接口类
 */
public interface NoticeService {

    List<Notice> list();

    void add(Notice bean);

    void delete(int id);

    void update(Notice bean);

    Notice get(int id);

    void deleteAll(List<Integer> idList);

    //多条件查询
    List<Notice> search(String noticeName,String noticeMsg);
}
