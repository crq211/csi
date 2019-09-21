package com.company.csi.controller;

import com.company.csi.pojo.Syslog;
import com.company.csi.pojo.User;
import com.company.csi.service.SyslogService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

//@Component
//@Aspect
public class LogAop {

    @Autowired
    HttpServletRequest request;

    @Autowired
    SyslogService syslogService;

    private Date visitTime;         //访问时间

    private Class clazz;            //访问的类

    private Method method;          //访问的方法

    /**
     * 前置通知
     * 主要是获取开始时间，执行的类是哪一个，执行的方法是哪一个
     */
    @Before("execution(* com.company.csi.service.Impl.*.*(..))")
    public void doBefore(JoinPoint joinPoint) throws NoSuchMethodException {
        visitTime = new Date();

        System.out.println("前置通知 1访问时间--" + visitTime);

        clazz = joinPoint.getTarget().getClass();

        String methodName = joinPoint.getSignature().getName();     //只能获取方法名

        System.out.println("前置通知 方法名--" + methodName);

        Object[] args = joinPoint.getArgs();                //获取请求方法的参数
        if (args == null || args.length == 0) {
            method = clazz.getMethod(methodName);           //获取无参的方法
        } else {
            Class[] classArgs = new Class[args.length];    //装方法参数的Class[]
            for (int i = 0; i < args.length; i++) {
                classArgs[i] = args[i].getClass();
            }
            method = clazz.getMethod(methodName, classArgs);   //获取有参的方法
        }
        System.out.println("前置通知 2方法" + method);
    }

    /**
     * 后置通知
     */
    @After("execution(* com.company.csi.service.Impl.*.*(..))")
    public void doAfter(JoinPoint joinPoint) {
        //获取访问时长
        Long time = new Date().getTime() - visitTime.getTime();

        System.out.println("后置通知 3访问时长" + time);

        //获取访问的url      @RequestMapping("/users")   /users
        String url = "";
        if (clazz != null && method != null && clazz != LogAop.class) {
            System.out.println("看看这里有没有运行");

//            RequestMapping annotation = method.getAnnotation(RequestMapping.class);
//            String[] values = annotation.value();
//            url = values[0];
            url = request.getRequestURI();

            System.out.println("后置通知 4url" + url);

            //获取访问的ip
            String ip = request.getRemoteAddr();

            System.out.println("后置通知 5ip" + ip);

            //获取当前操作的用户
            User user = (User) request.getSession().getAttribute("user");
            String userName = user.getUserName();

            System.out.println("后置通知 6用户名" + userName);

            //将数据封装到Syslog对象
            Syslog syslog = new Syslog();
            syslog.setExecution(time);
            syslog.setIp(ip);
            syslog.setMethod("[类名] " + clazz.getName() + " [方法名] " + method.getName());
            syslog.setUrl(url);
            syslog.setUserName(userName);
            syslog.setVisitTime(visitTime);

            //调用Service
            syslogService.add(syslog);

        } else {
            System.out.println("clazz：" + clazz + "-----" + "method：" + method );
        }
    }



}
