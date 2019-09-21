package com.company.csi.controller;

import com.company.csi.pojo.User;
import com.company.csi.service.UserService;
import com.company.csi.utils.Result;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.apache.shiro.subject.Subject;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * 登录控制器
 */
@Controller
@RequestMapping("")
public class loginController {

    @Autowired
    UserService userService;

    /**
     * 跳转到登录页面
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String loginPage(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            return "redirect:home";
        }
        return "loginForm";
    }

//    @RequestMapping(value = "/loginPage", method = RequestMethod.GET)
//    public String loginForm() {
//        return "loginPage";
//    }

    /**
     * 登录
     *
     */
//    @RequestMapping(value = "/login", method = RequestMethod.POST)
//    public String login(@RequestParam("userName") String userName, @RequestParam("userPassword") String userPassword,
//                        Model model, HttpSession session) throws IOException {
//        User user = userService.get(userName, userPassword);
//        if (user != null) {
//            session.setAttribute("user", user);
//            return "redirect:/home";
//        } else {
//            model.addAttribute("msg", "账号密码错误");
//            return "loginPage";
//        }
//    }

    /**
     * 通过 Shiro的方式进行登录
     * 再增加Cookie
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public Object login(@RequestParam("userName") String userName,
                        @RequestParam("userPassword") String userPassword,
                        Model model, HttpSession session, HttpServletResponse response,
                        @RequestParam(value = "rememberMe",required = false, defaultValue = "0") int rememberMe)
            throws IOException {

        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(userName, userPassword);
        try {
            subject.login(token);
            User user = userService.getByUserName(userName);
            session.setAttribute("user", user);

            //增加记住密码功能
            if (rememberMe == 1) {
                //创建Cookie
                Cookie ck = new Cookie(URLEncoder.encode(userName, "UTF-8"), userPassword);
                //设置Cookie有效时间,单位为妙
                ck.setMaxAge(60 * 60 *24);
                //设置Cookie的有效范围,/为全部路径
                ck.setPath("/");
                response.addCookie(ck);
            }
            return "redirect:home";
        } catch (AuthenticationException e) {
            model.addAttribute("msg", "账号密码错误");
            return "loginForm";
        }
    }

    /**
     * 跳转到home页面
     */
    @RequestMapping("home")
    public String home(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            return "redirect:/";
        }
        return "home";
    }

    /**
     * 退出登录
     * 退出的时候，通过 subject.logout() 退出
     */
    @RequestMapping("doLogout")
    public String loginOut(HttpSession session) {
        Subject subject = SecurityUtils.getSubject();
        //如果登录了，退出登录
        if (subject.isAuthenticated()) {
            subject.logout();
        }
//        session.removeAttribute("user");
        return "redirect:/";
    }


    @RequestMapping("/result1")
    @ResponseBody
    public Object result1() {
        return Result.fail("没有这个权限");
    }
}
