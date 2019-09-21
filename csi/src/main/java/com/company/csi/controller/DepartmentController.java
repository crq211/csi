package com.company.csi.controller;

import com.company.csi.pojo.Department;
import com.company.csi.service.DepartmentService;
import com.company.csi.utils.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
public class DepartmentController {

    @Autowired
    DepartmentService departmentService;

    /**
     * 使用json方式分页查询全部部门
     */
    @RequestMapping("/departments")
    @ResponseBody
    public Object list(@RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Department> userList = departmentService.list();
        PageInfo page = new PageInfo(userList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 查询全部部门，为添加员工所挑选
     */
    @RequestMapping("/departmentSelect")
    @ResponseBody
    public Object list() {
        List<Department> departmentList = departmentService.list();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("departmentList", departmentList);
        return Result.success(map);
    }

    /**
     * 获取单个部门信息
     */
    @RequestMapping(value = "/department/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object get(@PathVariable int id) {
        Department department = departmentService.get(id);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("department", department);
        return Result.success(map);
    }

    /**
     * 修改单个部门信息
     */
    @RequestMapping(value = "/department/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public Object update(Department bean) {
        departmentService.update(bean);
        return Result.success();
    }

    /**
     * 增加单个部门
     */

    @RequestMapping(value = "/department", method = RequestMethod.POST)
    @ResponseBody
    public Object add(Department bean) {
        departmentService.add(bean);
        return Result.success();
    }

    /**
     * 删除多个部门和删除一个用户 二合一
     * 1-2-3-
     * 1
     */
    @RequestMapping(value = "/department/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@PathVariable String ids) {
        if (ids.contains("-")) {
            List<Integer> idList = new ArrayList<Integer>();
            String[] strIds = ids.split("-");
            for (String strId : strIds) {
                idList.add(Integer.parseInt(strId));
            }
            departmentService.deleteAll(idList);
        } else {
            departmentService.delete(Integer.parseInt(ids));
        }
        return Result.success();
    }

    /**
     * 根据部门名称模糊搜索部门
     */
    @RequestMapping(value = "/searchByDepartmentName", method = RequestMethod.GET)
    @ResponseBody
    public Object searchByFullName(@RequestParam(value = "departmentName") String departmentName,
                                   @RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<Department> departmentList = departmentService.searchByDepartmentName(departmentName);
        PageInfo page = new PageInfo(departmentList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

}
