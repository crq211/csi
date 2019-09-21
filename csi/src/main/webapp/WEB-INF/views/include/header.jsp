<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/8
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
<%-- 表示本页面会使用html5的技术 --%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <script src="static/js/jquery-1.12.4.min.js"></script>
    <script src="static/js/jquery.cookie.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="static/css/style.css" rel="stylesheet">

    <script>
        <%-- 格式化日期 2019-7-5 --%>
        function formatStrDate(date) {
            var strDate = date.getFullYear() + "年";
            strDate += date.getMonth() + 1 + "月";
            strDate += date.getDate() + "日";
            return strDate;
        }

        //数据输入之后提示校验后的信息
        function show_validate_msg(status, ele, msg) {
            //输入之前先清空class样式
            $(ele).parent().removeClass("has-error has-success");
            $(ele).next("span").text("");
            if (status == "fail") {
                $(ele).parent().addClass("has-error");      //给当前输入框的父元素增加样式
                $(ele).next("span").text(msg);              //给当前输入框的紧接元素(span)增加内容
            } else if (status == "success") {
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }
        }
    </script>
</head>
</html>
