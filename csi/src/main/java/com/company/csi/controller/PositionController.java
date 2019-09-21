package com.company.csi.controller;

import com.company.csi.pojo.Position;
import com.company.csi.service.PositionService;
import com.company.csi.utils.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PositionController {

    @Autowired
    PositionService positionService;

    /**
     * 使用json方式分页查询全部职位
     */
    @RequestMapping("/positions")
    @ResponseBody
    public Object list(@RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Position> positionList = positionService.list();
        PageInfo page = new PageInfo(positionList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 查询全部职位，为添加员工所挑选
     */
    @RequestMapping("/positionsSelect")
    @ResponseBody
    public Object list() {
        List<Position> positionList = positionService.list();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("positionList", positionList);
        return Result.success(map);
    }


    /**
     * 获取单个职位信息
     */
    @RequestMapping(value = "/position/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object get(@PathVariable int id) {
        Position position = positionService.get(id);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("position", position);
        return Result.success(map);
    }



    /**
     * 修改单个职位信息
     */
    @RequestMapping(value = "/position/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public Object update(Position bean) {
        positionService.update(bean);
        return Result.success();
    }

    /**
     * 增加单个职位
     */
    @RequestMapping(value = "/position", method = RequestMethod.POST)
    @ResponseBody
    public Object add(Position bean) {
        positionService.add(bean);
        return Result.success();
    }

    /**
     * 删除多个职位和删除一个用户 二合一
     * 1-2-3-
     * 1
     */
    @RequestMapping(value = "/position/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@PathVariable String ids) {
        if (ids.contains("-")) {
            List<Integer> idList = new ArrayList<Integer>();
            String[] strIds = ids.split("-");
            for (String strId : strIds) {
                idList.add(Integer.parseInt(strId));
            }
            positionService.deleteAll(idList);
        } else {
            positionService.delete(Integer.parseInt(ids));
        }
        return Result.success();
    }

    /**
     * 根据职位名称模糊搜索职位
     */
    @RequestMapping(value = "/searchByPositionName", method = RequestMethod.GET)
    @ResponseBody
    public Object searchByFullName(@RequestParam(value = "positionName") String positionName,
                                   @RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Position> positionList = positionService.searchByPositionName(positionName);
        PageInfo page = new PageInfo(positionList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

}

