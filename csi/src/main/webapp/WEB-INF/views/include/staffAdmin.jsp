<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/15
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<body>
<%-- 显示员工 --%>
<div class="menuDiv" id="staffSelectDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">员工查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：员工管理 > 员工查询</span>
        </div>

        <div class="searchDiv">
            <div>
                <span class="ss">职位：</span>
                <div class="sss">
                    <%-- 下拉框 --%>
                    <select name="positionId" id="positionStaff"></select>
                </div>
                <span class="ss">姓名：</span>
                <input type="text" name="staffName" id="staffNameText">
                <span class="ss">身份证号码：</span>
                <input type="text" name="idNumber" id="idNumberText">
            </div>
            <div>
                <span class="ss">性别：</span>
                <div class="sss">
                    <%-- 下拉框 --%>
                    <select name="gender" id="genderText">
                        <option value="">--请选择性别--</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>
                <span class="ss">手机：</span>
                <input type="text" name="phone" id="phoneText">
                <span class="ss">所属部门：</span>
                <div class="sss">
                    <%-- 下拉框 --%>
                    <select name="departmentId" id="departmentStaff"></select>
                </div>
                <button type="button" class="btn btn-primary btn-sm" id="searchStaffBtn">搜索</button>
                <button type="button" class="btn btn-danger btn-sm" id="deleteStaffBtn">删除</button>
            </div>
        </div>

        <div class="dataDiv">
            <table class="table table-hover table-bordered dataTable" id="staffs_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkStaffAll"></th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>手机号码</th>
                    <th>邮箱</th>
                    <th>职位</th>
                    <th>学历</th>
                    <th>身份证号码</th>
                    <th>部门</th>
                    <th>联系地址</th>
                    <th>建档日期</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="pageDiv">
            <%-- 分页条信息 --%>
            <div id="page_staff_nav"></div>
            <%-- 分页跳转信息 --%>
            <div id="page_staff_jump"></div>
            <%-- 分页文字信息 --%>
            <div id="page_staff_info"></div>
        </div>
    </div>
</div>

<%-- 添加员工 --%>
<div class="menuDiv" id="staffAddDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">添加员工</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：员工管理 > 添加员工</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="staffLeftDiv">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">姓名：</label>
                        <div class="col-sm-3">
                            <input type="text" name="staffName" id="staffNameAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">身份证号码：</label>
                        <div class="col-sm-3">
                            <input type="text" name="idNumber" id="idNumberAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">性别：</label>
                        <div class="col-sm-3">
                            <%-- 下拉框 --%>
                            <select class="form-control" name="gender">
                                <option>男</option>
                                <option>女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">职位：</label>
                        <div class="col-sm-3">
                            <%-- 下拉框 --%>
                            <select class="form-control" name="positionId" id="positionOption"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">学历：</label>
                        <div class="col-sm-3">
                            <input type="text" name="education" id="educationAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">邮箱：</label>
                        <div class="col-sm-3">
                            <input type="text" name="email" id="emailAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">手机：</label>
                        <div class="col-sm-3">
                            <input type="text" name="phone" id="phoneAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">所属部门：</label>
                        <div class="col-sm-3">
                            <%-- 下拉框 --%>
                            <select class="form-control" name="departmentId" id="departmentOption"></select>
                        </div>
                    </div>
                </div>
                <div class="staffRightDiv">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">QQ号码：</label>
                        <div class="col-sm-3">
                            <input type="text" name="qqNumber" id="qqNumberAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">联系地址：</label>
                        <div class="col-sm-3">
                            <input type="text" name="address" id="addressAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">邮政编码：</label>
                        <div class="col-sm-3">
                            <input type="text" name="post" id="postAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">出生日期：</label>
                        <div class="col-sm-3">
                            <input type="text" name="birthDate" id="birthDateAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">民族：</label>
                        <div class="col-sm-3">
                            <input type="text" name="nation" id="nationAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">所学专业：</label>
                        <div class="col-sm-3">
                            <input type="text" name="major" id="majorAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">爱好：</label>
                        <div class="col-sm-3">
                            <input type="text" name="hobby" id="hobbyAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">备注：</label>
                        <div class="col-sm-3">
                            <input type="text" name="remark" id="remarkAdd" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="staffAddBtn" class="btn btn-default">添加</button>
                        <button type="button" id="staffCancelAddBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 修改员工 --%>
<div class="menuDiv" id="staffUpdateDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">修改员工</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：员工管理 > 修改员工</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="staffLeftDiv">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">姓名：</label>
                        <div class="col-sm-3">
                            <input type="text" name="staffName" id="staffNameEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">身份证号码：</label>
                        <div class="col-sm-3">
                            <input type="text" name="idNumber" id="idNumberEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">性别：</label>
                        <div class="col-sm-3">
                            <%-- 下拉框 --%>
                            <select class="form-control" name="gender">
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">职位：</label>
                        <div class="col-sm-3">
                            <%-- 下拉框 --%>
                            <select class="form-control" name="positionId" id="positionOptionEdit"></select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">学历：</label>
                        <div class="col-sm-3">
                            <input type="text" name="education" id="educationEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">邮箱：</label>
                        <div class="col-sm-3">
                            <input type="text" name="email" id="emailEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">手机：</label>
                        <div class="col-sm-3">
                            <input type="text" name="phone" id="phoneEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">所属部门：</label>
                        <div class="col-sm-3">
                            <%-- 下拉框 --%>
                            <select class="form-control" name="departmentId" id="departmentOptionEdit"></select>
                        </div>
                    </div>
                </div>
                <div class="staffRightDiv">
                    <div class="form-group">
                        <label class="col-sm-1 control-label">QQ号码：</label>
                        <div class="col-sm-3">
                            <input type="text" name="qqNumber" id="qqNumberEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">联系地址：</label>
                        <div class="col-sm-3">
                            <input type="text" name="address" id="addressEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">邮政编码：</label>
                        <div class="col-sm-3">
                            <input type="text" name="post" id="postEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">出生日期：</label>
                        <div class="col-sm-3">
                            <input type="text" name="birthDate" id="birthDateEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">民族：</label>
                        <div class="col-sm-3">
                            <input type="text" name="nation" id="nationEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">所学专业：</label>
                        <div class="col-sm-3">
                            <input type="text" name="major" id="majorEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">爱好：</label>
                        <div class="col-sm-3">
                            <input type="text" name="hobby" id="hobbyEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">备注：</label>
                        <div class="col-sm-3">
                            <input type="text" name="remark" id="remarkEdit" class="form-control">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="staffUpdateBtn" class="btn btn-default">修改</button>
                        <button type="button" id="staffCancelEditBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    var ok8 = true, ok9 = false;

    //显示方法，传递后端查询出来的数据
    function staff_to(start) {
        $.ajax({
            url: "${pageContext.request.contextPath}/staffs",
            data: "start=" + start,
            type: "GET",
            success: function (result) {
                build_staffs_table(result);
                build_staffs_nav(result);
                build_staffs_jump();
                build_staffs_info(result);
            }
        })
    }

    function build_staffs_table(result) {
        $("div.dataDiv table tbody").empty();
        var staffs = result.data.page.list;
        $.each(staffs, function (index, item) {
            var checkboxTd = $("<td></td>").append("<input type='checkbox' class='checkStaffItem'/>");
            var staffNameTd = $("<td></td>").append(item.staffName);
            var genderTd = $("<td></td>").append(item.gender);
            var phoneTd = $("<td></td>").append(item.phone);
            var emailTd = $("<td></td>").append(item.email);
            var positionTd = $("<td></td>").append(item.position.positionName);
            var educationTd = $("<td></td>").append(item.education);
            var idNumberTd = $("<td></td>").append(item.idNumber);
            var departmentTd = $("<td></td>").append(item.department.departmentName);
            var addressTd = $("<td></td>").append(item.address);
            var formatDate = formatStrDate(new Date(item.createDate));
            var createDateTd = $("<td></td>").append(formatDate);
            var editBtn = $("<button></button>").addClass("btn btn-link btn-sm editStaffBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-edit"));
            //为编辑按钮添加一个自定义属性，表示当前员工
            editBtn.attr("editId", item.id);
            var operationTd = $("<td></td>").append(editBtn);
            $("<tr></tr>").append(checkboxTd).append(staffNameTd)
                .append(genderTd).append(phoneTd).append(emailTd).append(positionTd)
                .append(educationTd).append(idNumberTd).append(departmentTd).append(addressTd)
                .append(createDateTd).append(operationTd).appendTo("#staffs_table tbody");
        });
    }

    function build_staffs_nav(result) {
        build_pages_nav(result, staff_to, "#page_staff_nav");

    }

    function build_staffs_jump() {
        build_pages_jump("#page_staff_jump", "jumpStaffBtn");
    }

    function build_staffs_info(result) {
        build_pages_info(result, "#page_staff_info");
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
    $(document).on("click", ".jumpStaffBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            staff_to(num);
        }
    });

    //员工姓名的规范
    $("#staffNameEdit").change(function () {
        var staffName = this.value;
        var regStaffName = /(^[a-zA-Z]{3,12}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regStaffName.test(staffName)) {
            show_validate_msg("fail", "#staffNameEdit", "姓名必须为2-5位中文或3-12位英文");
            ok8 = false;
        } else {
            show_validate_msg("success", "#staffNameEdit", "该姓名可用");
            ok8 = true;
        }
    });

    $("#staffNameAdd").change(function () {
        var staffName = this.value;
        var regStaffName = /(^[a-zA-Z]{3,12}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regStaffName.test(staffName)) {
            show_validate_msg("fail", "#staffNameAdd", "姓名必须为2-5位中文或3-12位英文");
            ok9 = false;
        } else {
            show_validate_msg("success", "#staffNameAdd", "该姓名可用");
            ok9 = true;
        }
    });


    //点击添加按钮
    $(document).on("click", "#staffAddBtn", function () {
        var staffNameAdd = $("#staffNameAdd").val();
        var idNumberAdd = $("#idNumberAdd").val();
        var educationAdd = $("#educationAdd").val();
        var addressAdd = $("#addressAdd").val();
        var postAdd = $("#postAdd").val();
        var nationAdd = $("#nationAdd").val();

        if (staffNameAdd.length == 0) {
            show_validate_msg("fail", "#staffNameAdd", "请输入员工姓名");
            return false;
        }
        if (idNumberAdd.length == 0) {
            show_validate_msg("fail", "#idNumberAdd", "请输入身份证号码");
            return false;
        }
        if (educationAdd.length == 0) {
            show_validate_msg("fail", "#educationAdd", "请输入学历");
            return false;
        }
        if (addressAdd.length == 0) {
            show_validate_msg("fail", "#addressAdd", "请输入联系地址");
            return false;
        }
        if (postAdd.length == 0) {
            show_validate_msg("fail", "#postAdd", "请输入邮政编码");
            return false;
        }
        if (nationAdd.length == 0) {
            show_validate_msg("fail", "#nationAdd", "请输入民族");
            return false;
        }
        if (ok9) {
            $.ajax({
                url: "${pageContext.request.contextPath}/staff",
                type: "POST",
                data: $("#staffAddDiv form").serialize(),
                success: function (result) {
                    if (result.code == 0) {
                        $("div#staffAddDiv").hide();
                        $("div#staffSelectDiv").show();
                        $("#staffAdd").removeAttr("style");
                        $("#staffSelect").css("background-Color", "#4cae4c");
                        staff_to(1);
                    } else {
                        alert("您没有这个权限");
                    }
                }
            })
        }
    });

    //点击取消添加按钮
    $(document).on("click", "#staffCancelAddBtn", function () {
        $("#staffAddDiv form")[0].reset();
        $("#staffAddDiv form").find("*").removeClass("has-error has-success");
        $("#staffAddDiv form").find(".help-block").text("");
    });

    //点击编辑按钮
    $(document).on("click", ".editStaffBtn", function () {
        //显示职位和部门的下拉框
        getPositions("#positionOptionEdit");
        getDepartments("#departmentOptionEdit");

        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/staff/" + id,
            type: "GET",
            success: function (result) {
                if (result.code == 0) {
                    //清空样式
                    $("#staffUpdateDiv form").find("*").removeClass("has-error has-success");
                    $("#staffUpdateDiv form").find(".help-block").text("");
                    $("div#staffSelectDiv").hide();
                    $("div#staffUpdateDiv").show();
                    var data = result.data.staff;
                    //设置数据在页面上
                    $("#staffNameEdit").val(data.staffName);
                    $("#idNumberEdit").val(data.idNumber);
                    $("#educationEdit").val(data.education);
                    $("#emailEdit").val(data.email);
                    $("#phoneEdit").val(data.phone);
                    $("#qqNumberEdit").val(data.qqNumber);
                    $("#addressEdit").val(data.address);
                    $("#postEdit").val(data.post);
                    $("#birthDateEdit").val(data.birthDate);
                    $("#nationEdit").val(data.nation);
                    $("#majorEdit").val(data.major);
                    $("#hobbyEdit").val(data.hobby);
                    $("#remarkEdit").val(data.remark);

                    //下拉框指定显示
                    $("#staffUpdateDiv select[name=gender]").val([data.gender]);
                    $("#staffUpdateDiv select[name=positionId]").val([data.positionId]);
                    $("#staffUpdateDiv select[name=departmentId]").val([data.departmentId]);
                    getPositions("#positionStaff");
                    getDepartments("#departmentStaff");
                } else {
                    alert("您没有这个权限");
                }
            }
        });
        //给修改按钮加上这个员工的id
        $("#staffUpdateBtn").attr("editId", id);
    });

    //点击取消编辑按钮
    $(document).on("click", "#staffCancelEditBtn", function () {
        $("div#staffUpdateDiv").hide();
        $("div#staffSelectDiv").show();
        staff_to(curPage);
    });

    //点击修改按钮
    $(document).on("click", "#staffUpdateBtn", function () {
        var staffNameEdit = $("#staffNameEdit").val();
        var idNumberEdit = $("#idNumberEdit").val();
        var educationEdit = $("#educationEdit").val();
        var addressEdit = $("#addressEdit").val();
        var postEdit = $("#postEdit").val();
        var nationEdit = $("#nationEdit").val();

        if (staffNameEdit.length == 0) {
            show_validate_msg("fail", "#staffNameEdit", "请输入员工姓名");
            return false;
        }
        if (idNumberEdit.length == 0) {
            show_validate_msg("fail", "#idNumberEdit", "请输入身份证号码");
            return false;
        }
        if (educationEdit.length == 0) {
            show_validate_msg("fail", "#educationEdit", "请输入学历");
            return false;
        }
        if (addressEdit.length == 0) {
            show_validate_msg("fail", "#addressEdit", "请输入联系地址");
            return false;
        }
        if (postEdit.length == 0) {
            show_validate_msg("fail", "#postEdit", "请输入邮政编码");
            return false;
        }
        if (nationEdit.length == 0) {
            show_validate_msg("fail", "#nationEdit", "请输入民族");
            return false;
        }
        var id = $(this).attr("editId");
        if (ok8) {
            $.ajax({
                url: "${pageContext.request.contextPath}/staff/" + id,
                type: "PUT",
                data: $("#staffUpdateDiv form").serialize(),
                success: function (result) {
                    if (result.code == 0) {
                        $("div#staffUpdateDiv").hide();
                        $("div#staffSelectDiv").show();
                        staff_to(curPage);
                    } else {
                        alert("您没有这个权限");
                    }
                }
            })
        }
    });

    //点击全选按钮
    $("#checkStaffAll").click(function () {
        $(".checkStaffItem").prop("checked", $(this).prop("checked"))
    });

    //点击下面的判断是否全选, 之后事件，使用on
    $(document).on("click", ".checkStaffItem", function () {
        //JQuery提供的:checked，判断选中的
        var flag = $(".checkStaffItem:checked").length == $(".checkStaffItem").length;
        $("#checkStaffAll").prop("checked", flag);
    });

    //点击删除按钮
    $("#deleteStaffBtn").click(function () {
        var names = "";
        var ids = "";
        $.each($(".checkStaffItem:checked"), function () {
            names += $(this).parents("tr").find("td:eq(1)").text() + ",";
            ids += $(this).parents("tr").find("td:eq(11)").find("button").attr("editId") + "-";
        });
        names = names.substring(0, names.length - 1);
        ids = ids.substring(0, ids.length - 1);
        if ($(".checkStaffItem:checked").length != 0) {
            if (confirm("确认删除【" + names + "】吗?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/staff/" + ids,
                    type: "DELETE",
                    success: function (result) {
                        if (result.code == 0) {
                            staff_to(curPage);
                        }else {
                            alert("您没有这个权限!");
                        }
                    }
                })
            }
        }
    });

    //点击搜索按钮
    $("#searchStaffBtn").click(function () {
        $("div.menuDiv").hide();
        $("div#staffSelectDiv").show();
        searchStaff_to(1);
    });

    function searchStaff_to(start) {
        var positionId = $("#positionStaff").val();
        var staffName = $("#staffNameText").val();
        var idNumber = $("#idNumberText").val();
        var gender = $("#genderText").val();
        var phone = $("#phoneText").val();
        var departmentId = $("#departmentStaff").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/searchStaff",
            data: {
                "positionId": positionId, "staffName": staffName, "idNumber": idNumber,
                "gender": gender, "phone": phone, "departmentId": departmentId, "start": start
            },
            type: "GET",
            success: function (result) {
                build_staffs_table(result);
                build_searchStaff_nav(result);
                build_searchStaff_jump();
                build_searchStaff_info(result);
            }
        })
    }

    function build_searchStaff_nav(result) {
        build_pages_nav(result, searchStaff_to, "#page_staff_nav");
    }

    function build_searchStaff_jump() {
        build_pages_jump("#page_staff_jump", "jumpSearchStaffBtn");
    }

    function build_searchStaff_info(result) {
        build_pages_info(result, "#page_staff_info");
    }

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpSearchStaffBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            searchStaff_to(num);
        }
    });
</script>
</body>
</html>
