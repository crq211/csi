package com.company.csi.controller;

import com.company.csi.pojo.Role;
import com.company.csi.pojo.User;
import com.company.csi.service.RoleService;
import com.company.csi.service.UserRoleService;
import com.company.csi.service.UserService;
import com.company.csi.utils.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;

/**
 * 用户控制器
 */
@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    RoleService roleService;

    @Autowired
    UserRoleService userRoleService;

    /**
     * 使用json方式分页查询全部用户
     */
    @RequestMapping("/users")
    @ResponseBody
    public Object list(@RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<User> userList = userService.list();
        //为每个用户增加角色
        for (User user : userList) {
            List<Role> roleList = roleService.listRoles(user);
            user.setRoleList(roleList);
        }
        PageInfo page = new PageInfo(userList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 获取单个用户信息
     */
    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Object get(@PathVariable int id) {
        User user = userService.get(id);
        List<Role> roleList = roleService.listRoles(user);
        user.setRoleList(roleList);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user", user);
        return Result.success(map);
    }

    /**
     * 修改单个用户信息
     * JSR303校验
     */
    @RequestMapping(value = "/user/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public Object update(@Valid User bean, BindingResult result, int roleId) {
        //精髓
        userRoleService.deleteByUser(bean.getId());
        userRoleService.setRole(bean, roleId);
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                return Result.fail(error.getDefaultMessage());
            }
        }
        userService.update(bean);
        return Result.success();
    }



    /**
     * 增加单个用户
     * JSR303校验
     */
    @RequestMapping(value = "/user", method = RequestMethod.POST)
    @ResponseBody
    public Object add(@Valid User bean, BindingResult result, int roleId) {
        if (result.hasErrors()) {
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                return Result.fail(error.getDefaultMessage());
            }
        }
        String userName = bean.getUserName();
        String password = bean.getUserPassword();
        userName = HtmlUtils.htmlEscape(userName);  //转义

        String salt = new SecureRandomNumberGenerator().nextBytes().toString();
        int times = 2;
        String algorithmName = "md5";
        String encodedPassword = new SimpleHash(algorithmName, password, salt, times).toString();


        bean.setUserName(userName);
        bean.setUserPassword(encodedPassword);
        bean.setSalt(salt);
        bean.setCreateDate(new Date());
        System.out.printf("原始密码是：%s , 盐是：%s, 运算次数是：%d, 运算出来的密文是：%s ",
                password, salt, times, encodedPassword);
        userService.add(bean);

//      精髓
        userRoleService.setRole(bean, roleId);

        return Result.success();
    }

    /**
     * 删除多个用户和删除一个用户 二合一
     * 1-2-3-
     * 1
     */
    @RequestMapping(value = "/user/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@PathVariable String ids) {
        if (ids.contains("-")) {
            List<Integer> idList = new ArrayList<Integer>();
            String[] strIds = ids.split("-");
            for (String strId : strIds) {
                idList.add(Integer.parseInt(strId));
            }
            userService.deleteAll(idList);
        } else {
            userService.delete(Integer.parseInt(ids));
        }
        return Result.success();
    }

    /**
     * 检验用户是否重复
     * 在检查该用户名是否可用之前检验是否合法
     */
    @RequestMapping(value = "/checkUser", method = RequestMethod.POST)
    @ResponseBody
    public Object checkUser(@RequestParam("userName") String userName) {
        //先判断用户名是否合法
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,6})";
        if (!userName.matches(regName)) {
            return Result.fail("登录名必须是2-6位中文或6-16位英文和数字的组合");
        }
        //再判断数据库用户名是否重复
        boolean flag = userService.checkUser(userName);
        if (flag) {
            return Result.success();
        } else {
            return Result.fail("用户名已存在");
        }
    }

    /**
     * 根据用户名模糊搜索用户
     */
    @RequestMapping(value = "/searchByFullName", method = RequestMethod.GET)
    @ResponseBody
    public Object searchByFullName(@RequestParam(value = "fullNameText") String fullNameText,
                                   @RequestParam(value = "start", defaultValue = "1") int start) {
        PageHelper.startPage(start, 5);
        List<User> userList = userService.searchByFullName(fullNameText);
        PageInfo page = new PageInfo(userList, 5);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page", page);
        return Result.success(map);
    }

    /**
     * 检验密码是否正确
     */
    @RequestMapping(value = "/checkPassword", method = RequestMethod.POST)
    @ResponseBody
    public Object checkPassword(@RequestParam("oldPassword") String oldPassword,
                                HttpSession session) {
        /**
         * 将输入的密码传过来，进行加密，跟数据库的密码比较
         */
        //获取用户，获取盐，加密输入的密码
        User user = (User) session.getAttribute("user");
        String salt = user.getSalt();
        String passwordEncoded = new SimpleHash("md5", oldPassword, salt, 2).toString();
        String passwordInDB = user.getUserPassword();
        //如果不相同就是当前密码错误
        if (!passwordInDB.equals(passwordEncoded)) {
            return Result.fail("当前密码不正确，请重新输入");
        } else {
            return Result.success();
        }
    }

    /**
     * 修改密码
     */
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public Object updatePassword(@RequestParam("newPassword") String newPassword,
                                 HttpSession session) {
        /**
         * 获取当前用户，创建新盐，加密新密码，设置新盐、新密码，修改数据库数据
         */
        User user = (User) session.getAttribute("user");
        String salt = new SecureRandomNumberGenerator().nextBytes().toString();
        int times = 2;
        String algorithmName = "md5";
        String encodedPassword = new SimpleHash(algorithmName, newPassword, salt, times).toString();
        user.setSalt(salt);
        user.setUserPassword(encodedPassword);
        userService.update(user);

        //获取Cookie
//        Cookie[] cookies = request.getCookies();
//        //遍历Cookie
//        for (Cookie cookie : cookies) {
//            //如果之前有记住，这次不记住，就不记住了
//            if (cookie.getName().equals(user.getUserName())) {
//                cookie.setMaxAge(0);
//                cookie.setPath("/");
//                response.addCookie(cookie);
//            }
//        }
        return Result.success();
    }

    /**
     * 查询全部角色，为添加用户所挑选
     */
    @RequestMapping("/roleSelect")
    @ResponseBody
    public Object list() {
        List<Role> roleList = roleService.list();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("roleList", roleList);
        return Result.success(map);
    }

}
