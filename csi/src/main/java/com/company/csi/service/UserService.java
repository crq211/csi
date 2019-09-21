package com.company.csi.service;

import com.company.csi.pojo.User;

import java.util.List;

/**
 * 用户的接口类
 */
public interface UserService {

    /**
     * 登录
     */
    User get(String userName, String userPassword);

    void add(User bean);

    void delete(int id);

    void update(User bean);

    User get(int id);

    List<User> list();

    void deleteAll(List<Integer> idList);

    /**
     * 判断用户是否存在
     */
    boolean checkUser(String userName);

    /**
     * 根据用户名模糊搜索用户
     */
    List<User> searchByFullName(String fullName);

    /**
     * 根据用户名获取用户
     */
    User getByUserName(String userName);

    void updateFaceUrlByName(String userName, String faceUrl, String facePath);
}
