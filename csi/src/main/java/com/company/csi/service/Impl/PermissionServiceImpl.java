package com.company.csi.service.Impl;

import com.company.csi.mapper.PermissionMapper;
import com.company.csi.mapper.RolePermissionMapper;
import com.company.csi.pojo.*;
import com.company.csi.service.PermissionService;

import com.company.csi.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 权限接口实现类
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    PermissionMapper permissionMapper;

    @Autowired
    RolePermissionMapper rolePermissionMapper;

    @Autowired
    RoleService roleService;

    @Override
    public List<Permission> list() {
        PermissionExample example = new PermissionExample();
        example.setOrderByClause("id desc");
        return permissionMapper.selectByExample(example);
    }

    @Override
    public void add(Permission bean) {
        permissionMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        permissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Permission bean) {
        permissionMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public Permission get(int id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    /**
     * 三表查询
     */
    @Override
    public List<Permission> list(Role role) {
        List<Permission> permissionList = new ArrayList<>();
        RolePermissionExample example = new RolePermissionExample();
        example.createCriteria().andRoleIdEqualTo(role.getId());
        List<RolePermission> rolePermissionList = rolePermissionMapper.selectByExample(example);
        for (RolePermission rolePermission : rolePermissionList) {
            Permission permission = get(rolePermission.getPermissionId());
            permissionList.add(permission);
        }
        return permissionList;
    }

    /**
     * 五表查询
     * 先准备个空集合，然后用户跟角色连接起来，再角色跟用户连接起来
     * 这里必须使用addAll()，才不会覆盖之前的，才可以叠加起来
     */
    @Override
    public List<Permission> listPermissions(String userName) {
        List<Permission> permissionList = new ArrayList<Permission>();
        List<Role> roleList = roleService.listRoles(userName);
        for (Role role : roleList) {
            permissionList.addAll(list(role));
//            permissionList = list(role);
        }
        return permissionList;
    }


    @Override
    public Set<String> listPermissionNames(String userName) {
        Set<String> result = new HashSet<String>();
        List<Permission> permissionList = listPermissions(userName);
        for (Permission permission : permissionList) {
            result.add(permission.getPermissionName());
        }
        return result;
    }

    @Override
    public boolean needInterceptor(String requestURI) {
        //拿到全部权限
        List<Permission> permissionList = list();
        //遍历，如果访问的url包含了权限里的url，就需要拦截，就是返回true
        for (Permission permission : permissionList) {
            if (requestURI.contains(permission.getUrl()))
                return true;
        }
        return false;
    }

    @Override
    public Set<String> listPermissionURLs(String userName) {
        Set<String> result = new HashSet<String>();
        List<Permission> permissionList = listPermissions(userName);
        for (Permission permission : permissionList) {
            result.add(permission.getUrl());
        }
        return result;
    }


}
