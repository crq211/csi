<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/6/30
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="include/header.jsp" %>
<%@ include file="include/top.jsp" %>
<%@ include file="include/card.jsp" %>
<%@ include file="include/departmentAdmin.jsp" %>
<%@ include file="include/positionAdmin.jsp" %>
<%@ include file="include/staffAdmin.jsp" %>
<%@ include file="include/noticeAdmin.jsp" %>
<%@ include file="include/downloadAdmin.jsp" %>
<%@ include file="include/page.jsp" %>
<html>
<body>
<%-- 显示用户 --%>
<div class="menuDiv" id="userSelectDiv">
    <div class="titleDiv">
        <span class="label label-info">用户查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：用户管理 > 用户查询</span>
        </div>

        <div class="searchDiv">
            用户名：<input type="text" id="fullNameText">
            <button type="button" class="btn btn-primary btn-sm" id="searchUserBtn">搜索</button>
            <button type="button" class="btn btn-danger btn-sm" id="deleteUserBtn">删除</button>
        </div>

        <div class="dataDiv">
            <table class="table table-hover table-bordered dataTable" id="users_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkUserAll"></th>
                    <th>登录名</th>
                    <th>密码</th>
                    <th>用户名</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="pageDiv">
            <%-- 分页条信息 --%>
            <div id="page_user_nav"></div>
            <%-- 分页跳转信息 --%>
            <div id="page_user_jump"></div>
            <%-- 分页文字信息 --%>
            <div id="page_user_info"></div>
        </div>
    </div>
</div>

<%-- 修改用户 --%>
<div class="menuDiv" id="userUpdateDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">用户查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：用户管理 > 修改用户</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">姓名：</label>
                    <div class="col-sm-3">
                        <input type="text" name="fullName" id="fullNameEdit" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">登录名：</label>
                    <div class="col-sm-3">
                        <input type="text" name="userName" id="userNameEdit" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">角色：</label>
                    <div class="col-sm-3">
                        <%-- 下拉框 --%>
                        <select class="form-control" name="roleId" id="roleOptionE"></select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="userUpdateBtn" class="btn btn-default">修改</button>
                        <button type="button" id="userCancelEditBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 增加用户 --%>
<div class="menuDiv" id="userAddDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">添加用户</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：用户管理 > 添加用户</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">姓名：</label>
                    <div class="col-sm-3">
                        <input type="text" name="fullName" id="fullNameAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">登录名:</label>
                    <div class="col-sm-3">
                        <input type="text" name="userName" id="userNameAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">密码：</label>
                    <div class="col-sm-3">
                        <input type="text" name="userPassword" id="userPasswordAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">角色：</label>
                    <div class="col-sm-3">
                        <%-- 下拉框 --%>
                        <select class="form-control" name="roleId" id="roleOption"></select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="userAddBtn" class="btn btn-default">添加</button>
                        <button type="button" id="userCancelAddBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(function () {
        user_to(1);
    });


    //提取出总页数和当前页，后续使用
    var totalPage, curPage;

    var ok3 = true, ok4 = true;
    var ok5 = false, ok6 = false, ok7 = false;

    //显示方法，传递后端查询出来的数据
    function user_to(start) {
        $.ajax({
            url: "${pageContext.request.contextPath}/users",
            data: "start=" + start,
            type: "GET",
            success: function (result) {
                build_users_table(result);
                build_users_nav(result);
                build_users_jump();
                build_users_info(result);
            }
        })
    }

    function build_users_table(result) {
        $("div.dataDiv table tbody").empty();
        var users = result.data.page.list;
        $.each(users, function (index, item) {
            var checkboxTd = $("<td></td>").append("<input type='checkbox' class='checkUserItem'/>");
            var loginNameTd = $("<td></td>").append(item.userName);
            var passwordTd = $("<td></td>").append(item.userPassword);
            var fullNameTd = $("<td></td>").append(item.fullName);
            var roleTd;
            var str = "";
            $.each(item.roleList, function (index, item) {
                str += item.desc;
                roleTd = $("<td></td>").append(str);
            });
            var formatDate = formatStrDate(new Date(item.createDate));
            var createTimeTd = $("<td></td>").append(formatDate);
            var editBtn = $("<button></button>").addClass("btn btn-link btn-sm editUserBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-edit"));
            //为编辑按钮添加一个自定义属性，表示当前用户
            editBtn.attr("editId", item.id);
            var operationTd = $("<td></td>").append(editBtn);
            $("<tr></tr>").append(checkboxTd).append(loginNameTd).append(passwordTd)
                .append(fullNameTd).append(roleTd).append(createTimeTd).append(operationTd)
                .appendTo("#users_table tbody");
        });
    }

    function build_users_nav(result) {
        build_pages_nav(result, user_to, "#page_user_nav");
    }

    function build_users_jump() {
        build_pages_jump("#page_user_jump", "jumpUserBtn");
    }

    function build_users_info(result) {
        build_pages_info(result, "#page_user_info");
    }

    $(document).on("change", ".jumpSet", function () {
        var num = $(".jumpSet").val();
        num = parseInt(num);
        if (isNaN(num))
            num = 1;
        if (num <= 0)
            num = 1;
        if (num > totalPage)
            num = totalPage;
        $(".jumpSet").val(num);
    });

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpUserBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            user_to(num);
        }
    });

    //点击编辑按钮
    $(document).on("click", ".editUserBtn", function () {
        getRoles("#roleOptionE");
        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/user/" + id,
            type: "GET",
            success: function (result) {
                if (result.code == 0) {
                    //清空样式
                    $("#userUpdateDiv form").find("*").removeClass("has-error has-success");
                    $("#userUpdateDiv form").find(".help-block").text("");
                    $("div#userSelectDiv").hide();
                    $("div#userUpdateDiv").show();
                    var userData = result.data.user;
                    //设置数据在页面上
                    $("#fullNameEdit").val(userData.fullName);
                    $("#userNameEdit").val(userData.userName);
                    var roleId;
                    $.each(userData.roleList, function (index, item) {
                        roleId = item.id;
                    });
                    $("#userUpdateDiv select[name=roleId]").val([roleId]);
                } else {
                    alert("您没有这个权限");
                }
            }
        });
        //给修改按钮加上这个用户的id
        $("#userUpdateBtn").attr("editId", id);
    });

    //点击取消编辑按钮
    $(document).on("click", "#userCancelEditBtn", function () {
        $("div#userUpdateDiv").hide();
        $("div#userSelectDiv").show();
        user_to(curPage);
    });

    //修改用户时姓名的规范
    $("#fullNameEdit").change(function () {
        var fullName = this.value;
        var regFullName = /(^[a-zA-Z]{3,12}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regFullName.test(fullName)) {
            show_validate_msg("fail", "#fullNameEdit", "姓名必须为2-5位中文或3-12位英文");
            ok3 = false;
        } else {
            show_validate_msg("success", "#fullNameEdit", "该姓名可用");
            ok3 = true;
        }
    });

    //后端数据校验，用户是否存在
    $("#userNameEdit").change(function () {
        var userName = this.value;
        $.ajax({
            url: "${pageContext.request.contextPath}/checkUser",
            type: "POST",
            data: "userName=" + userName,
            success: function (result) {
                if (result.code == 0) {
                    show_validate_msg("success", "#userNameEdit", "该用户名可用");
                    ok4 = true;
                } else {
                    show_validate_msg("fail", "#userNameEdit", result.message);
                    ok4 = false;
                }
            }
        })
    });

    //点击修改按钮
    $(document).on("click", "#userUpdateBtn", function () {
        var fullName = $("#fullNameEdit").val();
        var userName = $("#userNameEdit").val();
        if (fullName.length == 0) {
            show_validate_msg("fail", "#fullNameEdit", "请输入姓名");
            return false;
        }
        if (userName.length == 0) {
            show_validate_msg("fail", "#userNameEdit", "请输入登录名");
            return false;
        }
        var id = $(this).attr("editId");
        if (ok3 && ok4) {
            $.ajax({
                url: "${pageContext.request.contextPath}/user/" + id,
                type: "PUT",
                data: $("#userUpdateDiv form").serialize(),
                success: function (result) {
                    if (result.code == 0) {
                        $("div#userUpdateDiv").hide();
                        $("div#userSelectDiv").show();
                        user_to(curPage);
                    } else {
                        alert("您没有这个权限");
                    }
                }
            });
        }
    });

    //后端数据校验，用户是否存在
    $("#userNameAdd").change(function () {
        var userName = this.value;
        $.ajax({
            url: "${pageContext.request.contextPath}/checkUser",
            type: "POST",
            data: "userName=" + userName,
            success: function (result) {
                if (result.code == 0) {
                    show_validate_msg("success", "#userNameAdd", "该用户名可用");
                    ok5 = true;
                } else {
                    show_validate_msg("fail", "#userNameAdd", result.message);
                    ok5 = false;
                }
            }
        })
    });

    //添加用户时姓名的规范
    $("#fullNameAdd").change(function () {
        var fullName = this.value;
        var regFullName = /(^[a-zA-Z]{3,12}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regFullName.test(fullName)) {
            show_validate_msg("fail", "#fullNameAdd", "姓名必须为2-5位中文或3-12位英文");
            ok6 = false;
        } else {
            show_validate_msg("success", "#fullNameAdd", "该姓名可用");
            ok6 = true;
        }
    });

    //添加用户时密码的规范
    $("#userPasswordAdd").change(function () {
        var password = this.value;
        var regPassword = /(^[a-zA-Z0-9_-]{6,20}$)/;
        if (!regPassword.test(password)) {
            show_validate_msg("fail", "#userPasswordAdd", "密码必须为6-20英文或数字的组合");
            ok7 = false;
        } else {
            show_validate_msg("success", "#userPasswordAdd", "该密码可用");
            ok7 = true;
        }
    });

    //点击添加按钮
    $(document).on("click", "#userAddBtn", function () {
        var fullName = $("#fullNameAdd").val();
        var userName = $("#userNameAdd").val();
        var userPassword = $("#userPasswordAdd").val();
        if (fullName.length == 0) {
            show_validate_msg("fail", "#fullNameAdd", "请输入姓名");
            return false;
        }
        if (userName.length == 0) {
            show_validate_msg("fail", "#userNameAdd", "请输入登录名");
            return false;
        }
        if (userPassword.length == 0) {
            show_validate_msg("fail", "#userPasswordAdd", "请输入密码");
            return false;
        }

        if (ok5 && ok6 && ok7) {
            $.ajax({
                url: "${pageContext.request.contextPath}/user",
                type: "POST",
                data: $("#userAddDiv form").serialize(),
                success: function (result) {
                    if (result.code == 0) {
                        $("div#userAddDiv").hide();
                        $("div#userSelectDiv").show();
                        $("#userAdd").removeAttr("style");
                        $("#userSelect").css("background-Color", "#4cae4c");
                        user_to(1);
                    } else {
                        alert("您没有这个权限");
                    }
                }
            })
        }
    });

    //点击取消添加按钮
    $(document).on("click", "#userCancelAddBtn", function () {
        $("#userAddDiv form")[0].reset();
        $("#userAddDiv form").find("*").removeClass("has-error has-success");
        $("#userAddDiv form").find(".help-block").text("");
    });

    //点击全选按钮
    $("#checkUserAll").click(function () {
//        $(".checkUserItem").prop("checked", this.checked);
        $(".checkUserItem").prop("checked", $(this).prop("checked"));
    });

    //点击下面的判断是否全选, 之后事件，使用on
    $(document).on("click", ".checkUserItem", function () {
        //JQuery提供的:checked，判断选中的
        var flag = $(".checkUserItem:checked").length == $(".checkUserItem").length;
        $("#checkUserAll").prop("checked", flag);
    });

    //点击删除按钮
    $("#deleteUserBtn").click(function () {
        var names = "";
        var ids = "";
        $.each($(".checkUserItem:checked"), function () {
            names += $(this).parents("tr").find("td:eq(3)").text() + ",";
            ids += $(this).parents("tr").find("td:eq(6)").find("button").attr("editId") + "-";
        });
        names = names.substring(0, names.length - 1);
        ids = ids.substring(0, ids.length - 1);
        if ($(".checkUserItem:checked").length != 0) {
            if (confirm("确认删除【" + names + "】吗?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/user/" + ids,
                    type: "DELETE",
                    success: function (result) {
                        if (result.code == 0) {
                            user_to(curPage);
                        } else {
                            alert("您没有这个权限");
                        }
                    }
                })
            }
        }
    });


    //点击搜索按钮
    $("#searchUserBtn").click(function () {
        $("div.menuDiv").hide();
        $("div#userSelectDiv").show();
        searchUser_to(1);
    });

    function searchUser_to(start) {
        var fullNameText = $("#fullNameText").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/searchByFullName",
            data: {"fullNameText": fullNameText, "start": start},
            type: "GET",
            success: function (result) {
                build_users_table(result);
                build_searchUser_nav(result);
                build_searchUser_jump();
                build_searchUser_info(result);
            }
        })
    }

    function build_searchUser_nav(result) {
        build_pages_nav(result, searchUser_to, "#page_user_nav");
    }

    function build_searchUser_jump() {
        build_pages_jump("#page_user_jump", "jumpSearchUserBtn")
    }

    function build_searchUser_info(result) {
        build_pages_info(result, "#page_user_info")
    }

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpSearchUserBtn", function () {
        var num = $(".jumpSet").val();
        var numLen = $(".jumpSet").val().length;
        if (numLen != 0 && num != curPage) {
            searchUser_to(num);
        }
    });
</script>
</body>
</html>
