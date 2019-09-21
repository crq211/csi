<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/14
  Time: 13:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<body>
<%-- 显示部门 --%>
<div class="menuDiv" id="departmentSelectDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">部门查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：部门管理 > 部门查询</span>
        </div>

        <div class="searchDiv">
            部门名称：<input type="text" id="departmentNameText">
            <button type="button" class="btn btn-primary btn-sm" id="searchDepartmentBtn">搜索</button>
            <button type="button" class="btn btn-danger btn-sm" id="deleteDepartmentBtn">删除</button>
        </div>

        <div class="dataDiv">
            <table class="table table-hover table-bordered dataTable" id="departments_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkDepartmentAll"></th>
                    <th>部门名称</th>
                    <th>详细信息</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="pageDiv">
            <%-- 分页条信息 --%>
            <div id="page_department_nav"></div>
            <%-- 分页跳转信息 --%>
            <div id="page_department_jump"></div>
            <%-- 分页文字信息 --%>
            <div id="page_department_info"></div>
        </div>
    </div>
</div>

<%-- 修改部门 --%>
<div class="menuDiv" id="departmentUpdateDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">部门查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：部门管理 > 修改部门</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">部门名称：</label>
                    <div class="col-sm-3">
                        <input type="text" name="departmentName" id="departmentNameEdit" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">详细描述：</label>
                    <div class="col-sm-3">
                        <input type="text" name="message" id="messageEdit" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="departmentUpdateBtn" class="btn btn-default">修改</button>
                        <button type="button" id="departmentCancelEditBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 添加部门 --%>
<div class="menuDiv" id="departmentAddDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">添加部门</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：部门管理 > 添加部门</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">部门名称：</label>
                    <div class="col-sm-3">
                        <input type="text" name="departmentName" id="departmentNameAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">详细描述：</label>
                    <div class="col-sm-3">
                        <input type="text" name="message" id="messageAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="departmentAddBtn" class="btn btn-default">添加</button>
                        <button type="button" id="departmentCancelAddBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    //显示方法，传递后端查询出来的数据
    function department_to(start) {
        $.ajax({
            url: "${pageContext.request.contextPath}/departments",
            data: "start=" + start,
            type: "GET",
            success: function (result) {
                build_departments_table(result);
                build_departments_nav(result);
                build_departments_jump();
                build_departments_info(result);
            }
        })
    }

    function build_departments_table(result) {
        $("div.dataDiv table tbody").empty();
        var departments = result.data.page.list;
        $.each(departments, function (index, item) {
            var checkboxTd = $("<td></td>").append("<input type='checkbox' class='checkDepartmentItem'/>");
            var departmentNameTd = $("<td></td>").append(item.departmentName);
            var messageTd = $("<td></td>").append(item.message);
            var editBtn = $("<button></button>").addClass("btn btn-link btn-sm editDepartmentBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-edit"));
            //为编辑按钮添加一个自定义属性，表示当前部门
            editBtn.attr("editId", item.id);
            var operationTd = $("<td></td>").append(editBtn);
            $("<tr></tr>").append(checkboxTd).append(departmentNameTd)
                .append(messageTd).append(operationTd).appendTo("#departments_table tbody");
        });
    }

    function build_departments_nav(result) {
        build_pages_nav(result, department_to, "#page_department_nav");
    }

    function build_departments_jump() {
        build_pages_jump("#page_department_jump", "jumpDepartmentBtn");
    }

    function build_departments_info(result) {
        build_pages_info(result, "#page_department_info");
    }

    //对输入框进行规定
    $(document).on("change", ".jumpSet", function () {
        var num = $(".jumpSet").val();
        num = parseInt(num);
        if (isNaN(num))
            num = 1;
        if (num <= 0)
            num = 1;
        if (num >= totalPage)
            num = totalPage;
        $(".jumpSet").val(num);
    });

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpDepartmentBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            department_to(num);
        }
    });

    //点击编辑按钮
    $(document).on("click", ".editDepartmentBtn", function () {
        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/department/" + id,
            type: "GET",
            success: function (result) {
                if (result.code == 0) {
                    //清空样式
                    $("#departmentUpdateDiv form").find("*").removeClass("has-error has-success");
                    $("#departmentUpdateDiv form").find(".help-block").text("");
                    $("div#departmentSelectDiv").hide();
                    $("div#departmentUpdateDiv").show();
                    var data = result.data.department;
                    //设置数据在页面上
                    $("#departmentNameEdit").val(data.departmentName);
                    $("#messageEdit").val(data.message);
                } else {
                    alert("您没有这个权限");
                }
            }
        });
        //给修改按钮加上这个用户的id
        $("#departmentUpdateBtn").attr("editId", id);
    });

    //点击取消编辑按钮
    $(document).on("click", "#departmentCancelEditBtn", function () {
        $("div#departmentUpdateDiv").hide();
        $("div#departmentSelectDiv").show();
        department_to(curPage);
    });

    //点击修改按钮
    $(document).on("click", "#departmentUpdateBtn", function () {
        var departmentName = $("#departmentNameEdit").val();
        var messageEdit = $("#messageEdit").val();
        if (departmentName.length == 0) {
            show_validate_msg("fail", "#departmentNameEdit", "请输入部门名称");
            return false;
        }
        if (messageEdit.length == 0) {
            show_validate_msg("fail", "#messageEdit", "请输入详细信息");
            return false;
        }

        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/department/" + id,
            type: "PUT",
            data: $("#departmentUpdateDiv form").serialize(),
            success: function (result) {
                if (result.code == 0) {
                    $("div#departmentUpdateDiv").hide();
                    $("div#departmentSelectDiv").show();
                    department_to(curPage);
                }else {
                    alert("您没有这个权限");
                }
            }
        })
    });

    //点击添加按钮
    $(document).on("click", "#departmentAddBtn", function () {
        var departmentName = $("#departmentNameAdd").val();
        var messageEdit = $("#messageAdd").val();
        if (departmentName.length == 0) {
            show_validate_msg("fail", "#departmentNameAdd", "请输入部门名称");
            return false;
        }
        if (messageEdit.length == 0) {
            show_validate_msg("fail", "#messageAdd", "请输入详细信息");
            return false;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/department",
            type: "POST",
            data: $("#departmentAddDiv form").serialize(),
            success: function (result) {
                if (result.code == 0) {
                    $("div#departmentAddDiv").hide();
                    $("div#departmentSelectDiv").show();
                    $("#departmentAdd").removeAttr("style");
                    $("#departmentSelect").css("background-Color", "#4cae4c");
                    department_to(1);
                } else {
                    alert("您没有这个权限");
                }
            }
        })
    });

    //点击取消添加按钮
    $(document).on("click", "#departmentCancelAddBtn", function () {
        $("#departmentAddDiv form")[0].reset();
        $("#departmentAddDiv form").find("*").removeClass("has-error has-success");
        $("#departmentAddDiv form").find(".help-block").text("");
    });

    //点击全选按钮
    $("#checkDepartmentAll").click(function () {
        $(".checkDepartmentItem").prop("checked", $(this).prop("checked"))
    });

    //点击下面的判断是否全选, 之后事件，使用on
    $(document).on("click", ".checkDepartmentItem", function () {
        //JQuery提供的:checked，判断选中的
        var flag = $(".checkDepartmentItem:checked").length == $(".checkDepartmentItem").length;
        $("#checkDepartmentAll").prop("checked", flag);
    });

    //点击删除按钮
    $("#deleteDepartmentBtn").click(function () {
        var names = "";
        var ids = "";
        $.each($(".checkDepartmentItem:checked"), function () {
            names += $(this).parents("tr").find("td:eq(1)").text() + ",";
            ids += $(this).parents("tr").find("td:eq(3)").find("button").attr("editId") + "-";
        });
        names = names.substring(0, names.length - 1);
        ids = ids.substring(0, ids.length - 1);
        if ($(".checkDepartmentItem:checked").length != 0) {
            if (confirm("确认删除【" + names + "】吗?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/department/" + ids,
                    type: "DELETE",
                    success: function (result) {
                        if (result.code == 0) {
                            department_to(curPage);
                        } else {
                            alert("您没有这个权限");
                        }
                    }
                })
            }
        }
    });

    //点击搜索按钮
    $("#searchDepartmentBtn").click(function () {
        $("div.menuDiv").hide();
        $("div#departmentSelectDiv").show();
        searchDepartment_to(1);
    });

    function searchDepartment_to(start) {
        var departmentName = $("#departmentNameText").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/searchByDepartmentName",
            data: {"departmentName": departmentName, "start": start},
            type: "GET",
            success: function (result) {
                build_departments_table(result);
                build_searchDepartment_nav(result);
                build_searchDepartment_jump();
                build_searchDepartment_info(result);
            }
        })
    }

    function build_searchDepartment_nav(result) {
        build_pages_nav(result, searchDepartment_to, "page_department_nav");
    }

    function build_searchDepartment_jump() {
        build_pages_jump("#page_department_jump", "jumpSearchDepartmentBtn")
    }

    function build_searchDepartment_info(result) {
        build_pages_info(result, "#page_department_info");
    }

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpSearchDepartmentBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            searchDepartment_to(num);
        }
    });
</script>
</body>
</html>
