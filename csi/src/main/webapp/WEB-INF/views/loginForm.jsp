<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/8/26
  Time: 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="include/header.jsp" %>
<html>
<head>
    <title>CSI员工之家</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>

    <script src="static/js/jquery-1.12.4.min.js"></script>
    <script src="static/js/jquery.cookie.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>


    <%--<link rel="stylesheet" href="js/metronic/plugins/bootstrap/css/bootstrap.css"/>--%>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="login/css/font-awesome.css"/>
    <link rel="stylesheet" href="js/metronic/plugins/simple-line-icons/css/simple-line-icons.css"/>
    <link rel="stylesheet" href="login/css/animate.min.css"/>
    <!-- Ionicons -->
    <link href="login/css/ionicons.css" rel="stylesheet" type="text/css"/>
    <!-- Skins. Choose a skin from the css/skins
     folder instead of downloading all of them to reduce the load. -->
    <link href="login/css/_all-skins.css" rel="stylesheet" type="text/css"/>
    <!-- Castle 1.0 -->
    <link href="login/css/castle.css" rel="stylesheet" type="text/css"/>
    <!-- Theme style -->
    <link href="login/css/castle-main.css" rel="stylesheet" type="text/css"/>
    <link href="js/metronic/plugins/layui/css/layui.css" rel="stylesheet" type="text/css"/>
    <link href="js/metronic/plugins/scrollbar/perfect-scrollbar.css" rel="stylesheet" type="text/css"/>
    <link href="login/css/fontsize.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="login/css/theme.css"/>
    <link rel="stylesheet" href="login/css/cover.css"/>
    <link rel="stylesheet" href="login/css/step.css"/>
    <link href="login/css/login.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="css/mask.css"/>

    <%--<script language="JavaScript">--%>
    <%--var context = "/hrm", __contextPath = "/hrm", __extendOptions = "main/options", __jsPath = "/hrm/gdsp/js",--%>
    <%--__scriptPath = "/hrm/gdsp/script";</script>--%>


    <%--<script src="js/jquery-2.1.4.js"></script>--%>
    <script src="js/utils-base.js"></script>

    <script src="js/metronic/plugins/layui/layui.js"></script>
    <script src="js/metronic/plugins/layui/layui-config.js"></script>
    <script src="js/util.js"></script>
    <script src="js/autoheight.js"></script>
    <script src="js/mask.js"></script>


    <script type="text/javascript" src="js/login/lufylegend-1.10.1.simple.min.js"></script>
    <script type="text/javascript" src="js/login/lufylegend.LoadingSample4-0.1.0.min.js"></script>
    <script type="text/javascript" src="js/login/TweenLite.min.js"></script>
    <script type="text/javascript" src="js/login/login.js"></script>
    <script type="text/javascript" src="js/metronic/plugins/jQuery-Storage-API/jquery.storageapi.js"></script>

    <%-- 111111111111111111 --%>
    <script type="text/javascript" src="login/js/login.js"></script>

    <script type="text/javascript" src="js/alert.js"></script>


    <script src="js/metronic/plugins/layui/layui.js"></script>
    <script src="js/metronic/plugins/layui/layui-config.js"></script>
    <script src="js/metronic/plugins/jQuery-Storage-API/jquery.storageapi.js"></script>
    <script src="js/metronic/plugins/app/app.js"></script>

    <script>
        $(function () {
            //提交时为空判断
            $("form.loginForm").submit(function () {
                if (0 == $("#loginname").val().length) {
                    return false;
                }
                if (0 == $("#password").val().length) {
                    return false;
                }
                //提交时如果没勾选，就删除这个用户名的Cookies
                if ($("#rememberPwd").attr("checked") != "checked") {
                    $.removeCookie($("#loginname").val(), {path: '/'})
                }
                return true;
            });

            //点击单选框，需要if判断当前是有没有勾选
            $("#rememberPwd").click(function () {
                if ($(this).attr("checked") == "checked") {
                    $(this).attr("checked", false);
                } else {
                    $(this).attr("checked", true);
                }
            });

            //在按键升起时触发,检测cookie中是否存在该用户名的key,如果有,则把value赋值给密码框
            $("#loginname").keyup(function () {
                var userName = $("#loginname").val();
                if (userName.trim() != "") {
                    var userPassword = $.cookie(userName);
                    if (userPassword != null) {
                        $("#password").val(userPassword);
                        $("#rememberPwd").attr("checked", true);
                        $("#rememberPwd").prop("value", 1);
                    }
                }
            });
        });

        <%--<c:if test="${!empty user}">--%>
        <%--window.location.href = "${pageContext.request.contextPath}/home";--%>
        <%--</c:if>--%>


        //账号密码错误时提示
        <%--<c:if test="${!empty msg}">--%>
        <%--$("span#errorMessage").html("${msg}");--%>
        <%--</c:if>--%>

    </script>

</head>

<body style="width: 100%;height: 100%;margin: 0;padding: 0; ">
<div class="bg-canvas">
    <canvas id="demo-canvas" width="100%" height="100%" style="width: 100%;height: 99%;overflow: hidden;"></canvas>
</div>
<div class="login-box" id="loginbox">
    <div class="login" id="main_login">
        <div class="input_text">
            <div id="message" style="position:absolute;color:red;margin-top:-20px;margin-left:100px;"></div>

            <form action="login" method="post" class="loginForm">
                <div class="content">
                    <div class="navbar-header">
                        <div>
                            <span style="font-family:'Britannic Bold', 'Britannic';color:#3BC5BB;">CSI员工</span>
                            <span style="font-family:'Segoe UI Emoji Bold', 'Segoe UI Emoji Normal', 'Segoe UI Emoji';color:#1D4474;"></span>
                            <span style="font-family:'Segoe UI Emoji Bold', 'Segoe UI Emoji Normal', 'Segoe UI Emoji';color:#FF9A4C;">之家</span>
                        </div>
                    </div>

                    <div class="formitem">
                        <span class="icon fa fa-user"></span>
                        <span class="input">
					        		<input id="loginname" name="userName" value="" class="form-control l35"
                                           fv_type="NOTCN" type="text" maxlength="20" placeholder="请输入您的用户名"
                                           data-toggle="tooltip" data-placement="right">
					        	</span>
                    </div>
                    <div class="formitem">
                        <span class="icon fa fa-key"></span>
                        <span class="input">
					        		<input id="password" name="userPassword" value=""
                                           class="form-control highlight_green l35" fv_type="NOTCN" type="password"
                                           maxlength="20" placeholder="请输入您的密码" data-toggle="tooltip"
                                           data-placement="right">
					        	</span>
                    </div>
                    <div class="formoperate">
					        	<span class="rememberPwd">
					        		<input type="checkbox" name="rememberMe" id="rememberPwd" value="1"/><label
                                        for="rememberPwd">记住密码</label>
					        	</span>
                    </div>
                    <div>
                        <button type="submit" id="login-submit-btn" class="layui-btn  btn-login" style="width:150px">
                            &nbsp;&nbsp;登　录&nbsp;&nbsp;
                        </button>
                        <button type="button" title="刷脸登录" data-search-open="" data-title="刷脸登录"
                                data-href="faceLogin" modal-toggle="modal" data-width="780" data-height="500"
                                class="layui-btn  btn-login" style="width:150px">&nbsp;&nbsp;刷 脸&nbsp;&nbsp;
                        </button>
                    </div>
                    <div class="formoperate" id="tishi" style="text-align: center;color: red;padding-top: 15px">
                        <%--<div>--%>
                            <%--<span id="errorMessage"></span>--%>
                        <%--</div>--%>
                    </div>

                </div>
            </form>
        </div>
    </div>
</div>


</body>

</html>
