package com.company.csi.service.Impl;

import com.company.csi.mapper.RoleMapper;
import com.company.csi.mapper.UserRoleMapper;
import com.company.csi.pojo.*;
import com.company.csi.service.RolePermissionService;
import com.company.csi.service.RoleService;
import com.company.csi.service.UserRoleService;
import com.company.csi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 角色接口实现类
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    RoleMapper roleMapper;

    @Autowired
    UserRoleService userRoleService;

    @Autowired
    RolePermissionService rolePermissionService;

    @Autowired
    UserRoleMapper userRoleMapper;

    @Autowired
    UserService userService;

    @Override
    public List<Role> list() {
        RoleExample example = new RoleExample();
        example.setOrderByClause("id desc");
        return roleMapper.selectByExample(example);
    }

    @Override
    public void add(Role bean) {
        roleMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        roleMapper.deleteByPrimaryKey(id);
        rolePermissionService.deleteByRole(id);
    }

    @Override
    public void update(Role bean) {
        roleMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public Role get(int id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    /**
     * 先准备个空Set<String>，获取Role集合，遍历取出角色名，加入空集合
     */
    @Override
    public Set<String> listRoleNames(String userName) {
        Set<String> result = new HashSet<String>();
        List<Role> roleList = listRoles(userName);
        for (Role role : roleList) {
            result.add(role.getRoleName());
        }
        return result;
    }

    @Override
    public List<Role> listRoles(String userName) {
        User user = userService.getByUserName(userName);
        if (user != null) {
            return listRoles(user);
        }
        return new ArrayList<Role>();       //新的集合
    }

    /**
     * 三表联合查询，先准备个空集合，再根据userId获取中间表，
     * 再根据中间表的roleId获取Role，增加进空集合,返回集合
     */
    @Override
    public List<Role> listRoles(User user) {
        List<Role> roleList = new ArrayList<Role>();
        UserRoleExample example = new UserRoleExample();
        example.createCriteria().andUserIdEqualTo(user.getId());
        List<UserRole> userRoleList = userRoleMapper.selectByExample(example);
        for (UserRole userRole : userRoleList) {
            Role role = roleMapper.selectByPrimaryKey(userRole.getRoleId());
            roleList.add(role);
        }
        return roleList;
    }


}
