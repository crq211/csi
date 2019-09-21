package com.company.csi.service;


import com.company.csi.pojo.Role;
import com.company.csi.pojo.User;

import java.util.List;
import java.util.Set;

/**
 * 角色接口类
 */
public interface RoleService {

    List<Role> list();

    void add(Role bean);

    void delete(int id);

    void update(Role bean);

    Role get(int id);


    /**
     * 当前用户名拥有的角色名集合
     */
    Set<String> listRoleNames(String userName);

    /**
     * 当前用户名拥有的角色集合
     */
    List<Role> listRoles(String userName);

    /**
     * 当前用户拥有的角色集合
     */
    List<Role> listRoles(User user);
}
