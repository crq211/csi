<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/2
  Time: 14:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<body>
<%-- 模态窗口 --%>
<div class="modal fade" id="updatePasswordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h5 class="modal-title" id="myModalLabel" style="font-weight: bold">修改密码</h5>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">当前密码：</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="oldPasswordText"
                                   placeholder="请输入当前密码">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">新的密码：</label>
                        <div class="col-sm-9">
                            <input type="password" name="userPassword" class="form-control" id="newPasswordText"
                                   placeholder="请输入您的新密码">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">确认密码：</label>
                        <div class="col-sm-9">
                            <input type="password" class="form-control" id="rePasswordText" placeholder="请输入您的新密码">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="updatePasswordBtn">提交</button>
            </div>
        </div>
    </div>
</div>

<nav class="topCSI navbar navbar-default navbar-fixed-top ">
    <span class="pull-left" style="color: #31b0d5; font-size: 20px">CSI员工之家</span>

    <span class="pull-right">
        <span>欢迎登录：【${user.userName}】</span>

        <span class="glyphicon glyphicon-dashboard"></span>

        <span id="timeShow" style="margin-left:0px"></span>

        <span class="glyphicon glyphicon-cog" id="updatePassword">修改密码</span>

        <a href="faceRegister">
            <span class="glyphicon glyphicon-cog">人脸注册</span>
        </a>

        <a href="doLogout">
            <span class="glyphicon glyphicon-off">退出登录</span>
        </a>
    </span>
</nav>

<script>
    //nav显示时间
    function showTime() {
        var nowTime = new Date();
        var year = nowTime.getFullYear();
        var month = isSingleDigit(nowTime.getMonth() + 1);
        var date = isSingleDigit(nowTime.getDate());
        var hour = isSingleDigit(nowTime.getHours());
        var minute = isSingleDigit(nowTime.getMinutes());
        var second = isSingleDigit(nowTime.getSeconds());
        var week = nowTime.getDay();
        var arr = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
        var myWeek = arr[week];
        document.getElementById("timeShow").innerText = year + "年" + month + "月" + date + "日 "
            + hour + ":" + minute + ":" + second + " " + myWeek;
    }

    //动态增加一秒
    setInterval(showTime, 1000);
    //加0
    function isSingleDigit(num) {
        if (num >= 0 && num <= 9) {
            num = '0' + num;
        }
        return num;
    }
    
    //点击修改密码弹出模态窗口
    $(document).on("click", "#updatePassword", function () {
        //清空模态框的表单数据    [0]取出document对象
        $("#updatePasswordModal form")[0].reset();
        $("#updatePasswordModal form").find("*").removeClass("has-error has-success");
        $("#updatePasswordModal form").find(".help-block").text("");
        $("#updatePasswordModal").modal({
            backdrop: "static"
        });
    });

    var ok1 = false, ok2 = false;

    //后端数据校验，当前密码是否正确
    $("#oldPasswordText").change(function () {
        var oldPassword = this.value;
        $.ajax({
            url: "${pageContext.request.contextPath}/checkPassword",
            type: "POST",
            data: "oldPassword=" + oldPassword,
            success: function (result) {
                if (result.code == 0) {
                    show_validate_msg("success", "#oldPasswordText", "当前密码输入正确");
                    ok1 = true;
                } else {
                    show_validate_msg("fail", "#oldPasswordText", result.message);
                }
            }
        })
    });

    //修改密码时新密码的规范
    $("#newPasswordText").change(function () {
        var password = this.value;
        var regPassword = /(^[a-zA-Z0-9_-]{6,20}$)/;
        if (!regPassword.test(password)) {
            show_validate_msg("fail", "#newPasswordText", "密码必须为6-20位英文或数字的组合");
        } else {
            show_validate_msg("success", "#newPasswordText", "该密码可用");
            ok2 = true;
        }
    });

    //点击提交新密码
    $(document).on("click", "#updatePasswordBtn", function () {
        if ($("#oldPasswordText").val().length == 0) {
            show_validate_msg("fail", "#oldPasswordText", "请输入当前密码");
            return false;
        }
        if ($("#newPasswordText").val().length == 0) {
            show_validate_msg("fail", "#newPasswordText", "请输入密码");
            return false;
        }
        if ($("#newPasswordText").val() != $("#rePasswordText").val()) {
            show_validate_msg("fail", "#rePasswordText", "两次密码输入不一致");
            return false;
        }
        if ($("#newPasswordText").val() == $("#rePasswordText").val()) {
            show_validate_msg("success", "#rePasswordText", "密码输入一致");
        }

        var newPassword = $("#newPasswordText").val();
        //神判断，都通过了才进行提交
        if (ok1 && ok2) {
            $.ajax({
                url: "${pageContext.request.contextPath}/updatePassword",
                type: "POST",
                data: "newPassword=" + newPassword,
                success: function (result) {
                    if (result.code == 0) {
                        //关闭模态框
                        $("#updatePasswordModal").modal('hide');
                        //清楚当前密码Cookie
                        $.removeCookie("${user.userName}", {path: '/'});
                        //跳转到登录页面
                        location.href = "${pageContext.request.contextPath}/";
                    } else {
                        console.log(newPassword);
                    }
                }
            });
        }
    });
</script>
</body>
</html>
