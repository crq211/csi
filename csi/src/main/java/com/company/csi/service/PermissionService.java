package com.company.csi.service;

import com.company.csi.pojo.Permission;
import com.company.csi.pojo.Role;

import java.util.List;
import java.util.Set;

/**
 * 权限接口类
 */
public interface PermissionService {

    List<Permission> list();

    void add(Permission bean);

    void delete(int id);

    void update(Permission bean);

    Permission get(int id);

    /**
     * 获取当前角色的权限
     */
    List<Permission> list(Role role);


    /**
     * 根据用户名查询权限集合
     */
    List<Permission> listPermissions(String userName);

    /**
     * 根据用户名查询权限名集合
     */
    Set<String> listPermissionNames(String userName);

    /**
     * 表示是否要进行拦截
     * 判断依据是如果访问的url在权限系统里存在，就要进行拦截。 如果不存在，就放行了。
     */
    boolean needInterceptor(String requestURI);

    /**
     * 用来获取某个用户所拥有的权限地址集合
     */
    Set<String> listPermissionURLs(String userName);

}
