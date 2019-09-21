package com.company.csi.controller;

import com.company.csi.pojo.Department;
import com.company.csi.pojo.Notice;
import com.company.csi.pojo.Position;
import com.company.csi.pojo.Staff;
import com.company.csi.service.StaffService;
import com.company.csi.utils.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 员工控制类
 */
@Controller
public class StaffController {

    @Autowired
    StaffService staffService;

    /**
     * 使用json方式分页查询全部员工
     */
    @RequestMapping("/staffs")
    @ResponseBody
    public Object list(@RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Staff> staffList = staffService.list();
        PageInfo page = new PageInfo(staffList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 增加单个员工
     */
    @RequestMapping(value = "/staff", method = RequestMethod.POST)
    @ResponseBody
    public Object add(Staff bean) {
        staffService.add(bean);
        return Result.success();
    }


    /**
     * 获取单个员工
     */
    @RequestMapping(value = "/staff/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object get(@PathVariable int id) {
        Staff staff = staffService.get(id);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("staff", staff);
        return Result.success(map);
    }


    /**
     * 修改单个员工
     */
    @RequestMapping(value = "/staff/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public Object update(Staff bean) {
        staffService.update(bean);
        return Result.success();
    }

    /**
     * 删除多个和删除一个 二合一
     * 1-2-3-
     * 1
     */
    @RequestMapping(value = "/staff/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@PathVariable String ids) {
        if (ids.contains("-")) {
            List<Integer> idList = new ArrayList<Integer>();
            String[] strIds = ids.split("-");
            for (String strId : strIds) {
                idList.add(Integer.parseInt(strId));
            }
            staffService.deleteAll(idList);
        } else {
            staffService.delete(Integer.parseInt(ids));
        }
        return Result.success();
    }

    /**
     * 多条件搜索员工
     */
    @RequestMapping(value = "/searchStaff", method = RequestMethod.GET)
    @ResponseBody
    public Object search(@RequestParam(value = "positionId") int positionId,
                         @RequestParam(value = "staffName") String staffName,
                         @RequestParam(value = "idNumber") String idNumber,
                         @RequestParam(value = "gender") String gender,
                         @RequestParam(value = "phone") String phone,
                         @RequestParam(value = "departmentId") int departmentId,
                         @RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Staff> staffList = staffService.search(positionId, staffName, idNumber, gender, phone, departmentId);
        PageInfo page = new PageInfo(staffList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

}
