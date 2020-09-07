package com.company.csi.filter;

import java.util.Iterator;
import java.util.Set;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.company.csi.pojo.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.company.csi.service.PermissionService;

/**
 * 权限过滤器
 */
public class URLPathMatchingFilter extends AccessControlFilter {

    @Autowired
    PermissionService permissionService;

    @Override
    protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object o)
            throws Exception {
        //转换
        HttpServletRequest httpRequest = ((HttpServletRequest) request);
        String requestURI = httpRequest.getRequestURI();//获取URI
        System.out.println("当前请求的URL:" + requestURI);


        //如果没有登录，就跳转到登录页面
        Subject subject = SecurityUtils.getSubject();
        if (!subject.isAuthenticated()) {
            System.out.println(httpRequest.getSession().getAttribute("user"));
            WebUtils.issueRedirect(request, response, "/");
            return false;
        }

        //看看这个路径有没有在权限里面，没有就放行
        boolean needInterceptor = permissionService.needInterceptor(requestURI);
        if (!needInterceptor) {
            return true;
            //否则，不放行，进行判断该用户是否有这个权限
        } else {
            //先设置为false
            boolean hasPermission = false;
            //当前用户拥有的权限的路径
//            String userName = subject.getPrincipal().toString();
            User user = (User) httpRequest.getSession().getAttribute("user");
            String userName = user.getUserName();
            Set<String> permissionUrls = permissionService.listPermissionURLs(userName);
            //迭代输出一下
            Iterator<String> iterator = permissionUrls.iterator();
            while (iterator.hasNext()) {
                System.out.println("该用户有: " + iterator.next().toString() + " 权限");
            }
            //遍历
            for (String url : permissionUrls) {
                //当前用户要访问的路径和拥有的权限路径一样，证明该用户可以访问，放行
                if (requestURI.contains(url)) {
                    hasPermission = true;
                    break;
                }
            }
            //如果是true，放行
            if (hasPermission)
                return true;
            //如果遍历到最后还是false，就拦截
            else {
                WebUtils.issueRedirect(request, response, "/result1");
                return false;
            }

        }
    }

    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse)
            throws Exception {
        return false;
    }

}