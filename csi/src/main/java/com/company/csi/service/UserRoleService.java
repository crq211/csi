package com.company.csi.service;

import com.company.csi.pojo.User;

/**
 * 用户-角色接口类
 */
public interface UserRoleService {

    /**
     * 为用户设置角色
     */
    void setRole(User user, int roleId);

    /**
     * 删除当前用户的角色
     */
    void deleteByUser(int userId);

}
