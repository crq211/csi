package com.company.csi.controller;


import com.company.csi.pojo.Permission;
import com.company.csi.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * 权限控制类
 */
@Controller
@RequestMapping("config")
public class PermissionController {

    @Autowired
    PermissionService permissionService;

    @RequestMapping("listPermission")
    public String list(Model model) {
        List<Permission> ps = permissionService.list();
        model.addAttribute("ps", ps);
        return "config/listPermission";
    }

    @RequestMapping("addPermission")
    public String add( Permission permission) {
        permissionService.add(permission);
        return "redirect:listPermission";
    }

    @RequestMapping("editPermission")
    public String list(Model model, int id) {
        Permission permission = permissionService.get(id);
        model.addAttribute("permission", permission);
        return "config/editPermission";
    }

    @RequestMapping("updatePermission")
    public String update(Permission permission) {
        permissionService.update(permission);
        return "redirect:listPermission";
    }

    @RequestMapping("deletePermission")
    public String delete(int id) {
        permissionService.delete(id);
        return "redirect:listPermission";
    }
}
