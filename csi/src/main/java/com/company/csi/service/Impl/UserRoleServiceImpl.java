package com.company.csi.service.Impl;

import com.company.csi.mapper.UserRoleMapper;
import com.company.csi.pojo.User;
import com.company.csi.pojo.UserRole;
import com.company.csi.pojo.UserRoleExample;
import com.company.csi.service.UserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户-角色接口实现类
 */
@Service
public class UserRoleServiceImpl implements UserRoleService {

    @Autowired
    UserRoleMapper userRoleMapper;


    @Override
    public void setRole(User user, int roleId) {
        //设置新的角色关系
        UserRole userRole = new UserRole();
        userRole.setUserId(user.getId());
        userRole.setRoleId(roleId);
        userRoleMapper.insertSelective(userRole);
    }

    @Override
    public void deleteByUser(int userId) {
        UserRoleExample example = new UserRoleExample();
        example.createCriteria().andUserIdEqualTo(userId);
        List<UserRole> userRoleList = userRoleMapper.selectByExample(example);
        for (UserRole userRole : userRoleList) {
            userRoleMapper.deleteByPrimaryKey(userRole.getId());
        }
    }
}
