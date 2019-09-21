package com.company.csi.service;

import com.company.csi.pojo.Role;

/**
 * 角色-权限接口类
 */
public interface RolePermissionService {

    /**
     * 为当前角色设置新的权限
     */
    void setPermissions(Role role, int[] permissionIds);

    /**
     * 删除当前角色的所有权限
     */
    void deleteByRole(int roleId);
}
