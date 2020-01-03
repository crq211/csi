package com.company.csi.controller;

import com.company.csi.pojo.Permission;
import com.company.csi.pojo.Position;
import com.company.csi.pojo.Role;
import com.company.csi.pojo.RolePermission;
import com.company.csi.service.PermissionService;
import com.company.csi.service.RolePermissionService;
import com.company.csi.service.RoleService;
import com.company.csi.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色控制类
 */
@Controller
@RequestMapping("config")
public class RoleController {

    @Autowired
    RoleService roleService;

    @Autowired
    PermissionService permissionService;

    @Autowired
    RolePermissionService rolePermissionService;

    @RequestMapping("listRole")
    public String list(Model model) {
        //全部的角色
        List<Role> roleList = roleService.list();
        model.addAttribute("rs", roleList);

        //每个角色各自拥有的权限
        Map<Role, List<Permission>> role_permissions = new HashMap<>();
        for (Role role : roleList) {
            List<Permission> permissionList = permissionService.list(role);
            role_permissions.put(role, permissionList);
        }
        model.addAttribute("role_permissions", role_permissions);
        return "config/listRole";
    }

    @RequestMapping("addRole")
    public String add(Role role) {
        roleService.add(role);
        return "redirect:listRole";
    }

    @RequestMapping("deleteRole")
    public String delete(int id) {
        roleService.delete(id);
        return "redirect:listRole";
    }

    @RequestMapping("editRole")
    public String edit(int id, Model model) {
        //当前角色
        Role role = roleService.get(id);
        model.addAttribute("role", role);

        //所有权限
        List<Permission> ps = permissionService.list();
        model.addAttribute("ps", ps);

        //当前角色拥有的权限
        List<Permission> currentPermissions = permissionService.list(role);
        model.addAttribute("currentPermissions", currentPermissions);

        return "config/editRole";
    }

    @RequestMapping("updateRole")
    public String update(Role role, int[] permissionIds) {
        rolePermissionService.setPermissions(role, permissionIds);
        roleService.update(role);
        return "redirect:listRole";
    }

}
