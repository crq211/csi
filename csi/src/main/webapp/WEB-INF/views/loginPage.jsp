<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/1
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="include/header.jsp" %>
<html>
<head>
    <title>登录</title>
    <script>
        $(function () {
            //提交时为空判断
            $("form.loginForm").submit(function () {
                if (0 == $("#userNameLogin").val().length) {
                    $("span.errorMessage").html("请输入用户名");
                    $("div.loginErrorMessageDiv").show();
                    return false;
                }
                if (0 == $("#passwordLogin").val().length) {
                    $("span.errorMessage").html("请输入密码");
                    $("div.loginErrorMessageDiv").show();
                    return false;
                }
                //提交时如果没勾选，就删除这个用户名的Cookies
                if ($("#rememberMe").attr("checked") != "checked") {
                    $.removeCookie($("#userNameLogin").val(), {path: '/'})
                }
                return true;
            });
            //账号密码错误时提示
            <c:if test="${!empty msg}">
            $("span.errorMessage").html("${msg}");
            $("div.loginErrorMessageDiv").show();
            </c:if>
            //输入时清空错误提示
            $("form.loginForm input").keyup(function () {
                $("div.loginErrorMessageDiv").hide();
            });

            //点击单选框，需要if判断当前是有没有勾选
            $("#rememberMe").click(function () {
                if ($(this).attr("checked") == "checked") {
                    $(this).attr("checked", false);
                } else {
                    $(this).attr("checked", true);
                }
            });

            <c:if test="${!empty user}">
            window.location.href = "http://localhost:8080/csi/home";
            </c:if>

            //在按键升起时触发,监测cookie中是否存在该用户名的key,如果有,则把value赋值给密码框
            $("#userNameLogin").keyup(function () {
                var userName = $("#userNameLogin").val();
                if (userName != "") {
                    var userPassword = $.cookie(userName);
                    if (userPassword != null) {
                        $("#passwordLogin").val(userPassword);
                        $("#rememberMe").attr("checked", true);
                        $("#rememberMe").prop("value", 1);
                    }
                }
            });
        });
    </script>
</head>


<body>
<div id="loginDiv" style="position: relative">
    <form action="login" method="post" class="loginForm">
        <div id="loginSmallDiv" class="loginSmallDiv">
            <div class="loginErrorMessageDiv">
                <div class="alert alert-danger">
                    <span class="errorMessage"></span>
                </div>
            </div>

            <div class="csiText">CSI员工之家</div>

            <div class="loginInput">
                <span class="loginInputIcon ">
                    <span class="glyphicon glyphicon-user"></span>
                </span>
                <input id="userNameLogin" name="userName" placeholder="账号" type="text" class="form-control">
            </div>

            <div class="loginInput">
                <span class="loginInputIcon ">
                    <span class="glyphicon glyphicon-lock"></span>
                </span>
                <input id="passwordLogin" name="userPassword" type="password" placeholder="密码" class="form-control">
            </div>
            <div class="checkbox rePassword">
                <label>
                    <input type="checkbox" name="rememberMe" id="rememberMe" value="1"> 记住密码
                </label>
            </div>
            <div>
                <div class="loginDDD">
                    <button class="btn btn-block blueButton" type="submit">登 录</button>
                </div>

                <div class="blueDDD">
                    <a href="faceLogin">
                        <button class="btn btn-block blueButton" type="button">刷 脸</button>
                    </a>
                </div>
            </div>
        </div>
    </form>
</div>
</body>
</html>
