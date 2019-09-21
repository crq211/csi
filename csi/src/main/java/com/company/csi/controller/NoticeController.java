package com.company.csi.controller;

import com.company.csi.pojo.Notice;
import com.company.csi.service.NoticeService;
import com.company.csi.utils.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/**
 * 公告控制类
 */
@Controller
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    /**
     * 使用json方式分页查询全部部门
     */
    @RequestMapping("/notices")
    @ResponseBody
    public Object list(@RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Notice> noticeList = noticeService.list();
        PageInfo page = new PageInfo(noticeList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 增加单个公告
     */
    @RequestMapping(value = "/notice", method = RequestMethod.POST)
    @ResponseBody
    public Object add(Notice bean) {
        bean.setCreateDate(new Date());
        noticeService.add(bean);
        return Result.success();
    }

    /**
     * 获取单个公告
     */
    @RequestMapping(value = "/notice/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object get(@PathVariable int id) {
        Notice notice = noticeService.get(id);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("notice", notice);
        return Result.success(map);
    }

    /**
     * 获取单个公告
     */
    @RequestMapping(value = "/noticePreview/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object Preview(@PathVariable int id) {
        Notice notice = noticeService.get(id);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("notice", notice);
        return Result.success(map);
    }


    /**
     * 修改单个公告
     */
    @RequestMapping(value = "/notice/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public Object update(Notice bean) {
        noticeService.update(bean);
        return Result.success();
    }

    /**
     * 删除多个和删除一个 二合一
     * 1-2-3-
     * 1
     */
    @RequestMapping(value = "/notice/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@PathVariable String ids) {
        if (ids.contains("-")) {
            List<Integer> idList = new ArrayList<Integer>();
            String[] strIds = ids.split("-");
            for (String strId : strIds) {
                idList.add(Integer.parseInt(strId));
            }
            noticeService.deleteAll(idList);
        } else {
            noticeService.delete(Integer.parseInt(ids));
        }
        return Result.success();
    }

    /**
     * 根据公告名称或公告内容模糊搜索公告
     */
    @RequestMapping(value = "/searchByNotice", method = RequestMethod.GET)
    @ResponseBody
    public Object search(@RequestParam(value = "noticeName") String noticeName,
                         @RequestParam(value = "noticeMsg") String noticeMsg,
                         @RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Notice> noticeList = noticeService.search(noticeName, noticeMsg);
        PageInfo page = new PageInfo(noticeList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }
}
