package com.company.csi.service.Impl;

import com.company.csi.mapper.RolePermissionMapper;
import com.company.csi.pojo.Role;
import com.company.csi.pojo.RolePermission;
import com.company.csi.pojo.RolePermissionExample;
import com.company.csi.service.RolePermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 角色-权限接口实现类
 */
@Service
public class RolePermissionServiceImpl implements RolePermissionService {

    @Autowired
    RolePermissionMapper rolePermissionMapper;

    @Override
    public void setPermissions(Role role, int[] permissionIds) {
        //先删除当前角色的权限
        deleteByRole(role.getId());
        //设置新的权限关系
        if (null != permissionIds)
            for (int permissionId : permissionIds) {
                RolePermission rolePermission = new RolePermission();
                rolePermission.setPermissionId(permissionId);
                rolePermission.setRoleId(role.getId());
                rolePermissionMapper.insertSelective(rolePermission);
            }
    }

    @Override
    public void deleteByRole(int roleId) {
        RolePermissionExample example = new RolePermissionExample();
        example.createCriteria().andRoleIdEqualTo(roleId);
        List<RolePermission> rolePermissionList = rolePermissionMapper.selectByExample(example);
        for (RolePermission rolePermission : rolePermissionList) {
            rolePermissionMapper.deleteByPrimaryKey(rolePermission.getId());
        }
    }
}
