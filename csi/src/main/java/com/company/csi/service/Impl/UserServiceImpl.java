package com.company.csi.service.Impl;

import com.company.csi.mapper.UserMapper;
import com.company.csi.pojo.User;
import com.company.csi.pojo.UserExample;
import com.company.csi.service.UserRoleService;
import com.company.csi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户接口的实现类
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Autowired
    UserRoleService userRoleService;

    /**
     * 登录
     * 1、根据输入的用户名和用户密码，判断是否登录成功
     * 成功则返回User，否则返回null
     */
    @Override
    public User get(String userName, String userPassword) {
        UserExample example = new UserExample();
        example.createCriteria().andUserNameEqualTo(userName).andUserPasswordEqualTo(userPassword);
        List<User> userList = userMapper.selectByExample(example);
        if (!userList.isEmpty()) {
            return userList.get(0);
        }
        return null;
    }

    @Override
    public void add(User bean) {
        userMapper.insertSelective(bean);
    }

    @Override
    public void delete(int id) {
        userMapper.deleteByPrimaryKey(id);
        userRoleService.deleteByUser(id);
    }

    @Override
    public void update(User bean) {
        userMapper.updateByPrimaryKeySelective(bean);
    }

    @Override
    public User get(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<User> list() {
        UserExample example = new UserExample();
        example.setOrderByClause("id desc");
        return userMapper.selectByExample(example);
    }

    @Override
    public void deleteAll(List<Integer> idList) {
        UserExample example = new UserExample();
        example.createCriteria().andIdIn(idList);
        userMapper.deleteByExample(example);
    }

    @Override
    public boolean checkUser(String userName) {
        UserExample example = new UserExample();
        example.createCriteria().andUserNameEqualTo(userName);
        long count = userMapper.countByExample(example);
        return count == 0;      //返回true，即没有这个用户，用户可用
    }

    @Override
    public List<User> searchByFullName(String fullName) {
        UserExample example = new UserExample();
        example.createCriteria().andFullNameLike("%" + fullName + "%");
        return userMapper.selectByExample(example);
    }

    /**
     * 根据用户名获取用户
     */
    @Override
    public User getByUserName(String userName) {
        UserExample example = new UserExample();
        example.createCriteria().andUserNameEqualTo(userName);
        List<User> userList = userMapper.selectByExample(example);
        if (!userList.isEmpty()) {
            return userList.get(0);
        }
        return null;

    }

    @Override
    public void updateFaceUrlByName(String userName, String faceUrl, String facePath) {
        UserExample example = new UserExample();
        example.createCriteria().andUserNameEqualTo(userName);
        List<User> userList = userMapper.selectByExample(example);
        if (userList != null) {
            User user = userList.get(0);
            user.setFaceUrl(faceUrl);
            user.setFacePath(facePath);
            userMapper.updateByPrimaryKeySelective(user);
        } else {
            throw new RuntimeException("没有这个用户");
        }

    }

}
