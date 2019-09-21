<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/15
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<body>
<%-- 显示职位 --%>
<div class="menuDiv" id="positionSelectDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">职位查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：职位管理 > 职位查询</span>
        </div>

        <div class="searchDiv">
            部门名称：<input type="text" id="positionNameText">
            <button type="button" class="btn btn-primary btn-sm" id="searchPositionBtn">搜索</button>
            <button type="button" class="btn btn-danger btn-sm" id="deletePositionBtn">删除</button>
        </div>

        <div class="dataDiv">
            <table class="table table-hover table-bordered dataTable" id="positions_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkPositionAll"></th>
                    <th>职位名称</th>
                    <th>详细信息</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="pageDiv">
            <%-- 分页条信息 --%>
            <div id="page_position_nav"></div>
            <%-- 分页跳转信息 --%>
            <div id="page_position_jump"></div>
            <%-- 分页文字信息 --%>
            <div id="page_position_info"></div>
        </div>
    </div>
</div>

<%-- 修改职位 --%>
<div class="menuDiv" id="positionUpdateDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">职位查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：职位管理 > 职位部门</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">职位名称：</label>
                    <div class="col-sm-3">
                        <input type="text" name="positionName" id="positionNameEdit" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">详细描述：</label>
                    <div class="col-sm-3">
                        <input type="text" name="message" id="messageEditP" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="positionUpdateBtn" class="btn btn-default">修改</button>
                        <button type="button" id="positionCancelEditBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 添加职位 --%>
<div class="menuDiv" id="positionAddDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">添加职位</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：职位管理 > 添加职位</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">职位名称：</label>
                    <div class="col-sm-3">
                        <input type="text" name="positionName" id="positionNameAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">详细描述：</label>
                    <div class="col-sm-3">
                        <input type="text" name="message" id="messageAddP" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-1">
                        <button type="button" id="positionAddBtn" class="btn btn-default">添加</button>
                        <button type="button" id="positionCancelAddBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    //显示方法，传递后端查询出来的数据
    function position_to(start) {
        $.ajax({
            url: "${pageContext.request.contextPath}/positions",
            data: "start=" + start,
            type: "GET",
            success: function (result) {
                build_positions_table(result);
                build_positions_nav(result);
                build_positions_jump();
                build_positions_info(result);
            }
        })
    }

    function build_positions_table(result) {
        $("div.dataDiv table tbody").empty();
        var positions = result.data.page.list;
        $.each(positions, function (index, item) {
            var checkboxTd = $("<td></td>").append("<input type='checkbox' class='checkPositionItem'/>");
            var positionNameTd = $("<td></td>").append(item.positionName);
            var messageTd = $("<td></td>").append(item.message);
            var editBtn = $("<button></button>").addClass("btn btn-link btn-sm editPositionBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-edit"));
            //为编辑按钮添加一个自定义属性，表示当前部门
            editBtn.attr("editId", item.id);
            var operationTd = $("<td></td>").append(editBtn);
            $("<tr></tr>").append(checkboxTd).append(positionNameTd)
                .append(messageTd).append(operationTd).appendTo("#positions_table tbody");
        });
    }

    function build_positions_nav(result) {
        build_pages_nav(result, position_to, "#page_position_nav");
    }

    function build_positions_jump() {
        build_pages_jump("#page_position_jump", "jumpPositionBtn");
    }

    function build_positions_info(result) {
        build_pages_info(result, "#page_position_info");
    }

    //对输入框进行规定
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
    $(document).on("click", ".jumpPositionBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            position_to(num);
        }
    });

    //点击编辑按钮
    $(document).on("click", ".editPositionBtn", function () {
        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/position/" + id,
            type: "GET",
            success: function (result) {
                if (result.code == 0) {
                    //清空样式
                    $("#positionUpdateDiv form").find("*").removeClass("has-error has-success");
                    $("#positionUpdateDiv form").find(".help-block").text("");
                    $("div#positionSelectDiv").hide();
                    $("div#positionUpdateDiv").show();
                    var data = result.data.position;
                    //设置数据在页面上
                    $("#positionNameEdit").val(data.positionName);
                    $("#messageEditP").val(data.message);
                } else {
                    alert("您没有这个权限!");
                }

            }
        });
        //给修改按钮加上这个用户的id
        $("#positionUpdateBtn").attr("editId", id);
    });

    //点击取消编辑按钮
    $(document).on("click", "#positionCancelEditBtn", function () {
        $("div#positionUpdateDiv").hide();
        $("div#positionSelectDiv").show();
        position_to(curPage);
    });

    //点击修改按钮
    $(document).on("click", "#positionUpdateBtn", function () {
        var positionName = $("#positionNameEdit").val();
        var messageEditP = $("#messageEditP").val();
        if (positionName.length == 0) {
            show_validate_msg("fail", "#positionNameEdit", "请输入职位名称");
            return false;
        }
        if (messageEditP.length == 0) {
            show_validate_msg("fail", "#messageEditP", "请输入详细信息");
            return false;
        }

        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/position/" + id,
            type: "PUT",
            data: $("#positionUpdateDiv form").serialize(),
            success: function (result) {
                if (result.code == 0) {
                    $("div#positionUpdateDiv").hide();
                    $("div#positionSelectDiv").show();
                    position_to(curPage);
                } else {
                    alert("您没有这个权限");
                }
            }
        })
    });

    //点击添加按钮
    $(document).on("click", "#positionAddBtn", function () {
        var positionName = $("#positionNameAdd").val();
        var messageEditP = $("#messageAddP").val();
        if (positionName.length == 0) {
            show_validate_msg("fail", "#positionNameAdd", "请输入职位名称");
            return false;
        }
        if (messageEditP.length == 0) {
            show_validate_msg("fail", "#messageAddP", "请输入详细信息");
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/position",
            type: "POST",
            data: $("#positionAddDiv form").serialize(),
            success: function (result) {
                if (result.code == 0) {
                    $("div#positionAddDiv").hide();
                    $("div#positionSelectDiv").show();
                    $("#positionAdd").removeAttr("style");
                    $("#positionSelect").css("background-Color", "#4cae4c");
                    position_to(1);
                } else {
                    alert("您没有这个权限!");
                }
            }
        })
    });

    //点击取消添加按钮
    $(document).on("click", "#positionCancelAddBtn", function () {
        $("#positionAddDiv form")[0].reset();
        $("#positionAddDiv form").find("*").removeClass("has-error has-success");
        $("#positionAddDiv form").find(".help-block").text("");
    });

    //点击全选按钮
    $("#checkPositionAll").click(function () {
        $(".checkPositionItem").prop("checked", $(this).prop("checked"))
    });

    //点击全选按钮
    $("#checkPositionAll").click(function () {
        $(".checkPositionItem").prop("checked", $(this).prop("checked"))
    });

    //点击下面的判断是否全选, 之后事件，使用on
    $(document).on("click", ".checkPositionItem", function () {
        //JQuery提供的:checked，判断选中的
        var flag = $(".checkPositionItem:checked").length == $(".checkPositionItem").length;
        $("#checkPositionAll").prop("checked", flag);
    });

    //点击删除按钮
    $("#deletePositionBtn").click(function () {
        var names = "";
        var ids = "";
        $.each($(".checkPositionItem:checked"), function () {
            names += $(this).parents("tr").find("td:eq(1)").text() + ",";
            ids += $(this).parents("tr").find("td:eq(3)").find("button").attr("editId") + "-";
        });
        names = names.substring(0, names.length - 1);
        ids = ids.substring(0, ids.length - 1);
        if ($(".checkPositionItem:checked").length != 0) {
            if (confirm("确认删除【" + names + "】吗?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/position/" + ids,
                    type: "DELETE",
                    success: function (result) {
                        if (result.code == 0) {
                            position_to(curPage);
                        }else {
                            alert("您没有这个权限");
                        }
                    }
                })
            }
        }
    });

    //点击搜索按钮
    $("#searchPositionBtn").click(function () {
        $("div.menuDiv").hide();
        $("div#positionSelectDiv").show();
        searchPosition_to(1);
    });

    function searchPosition_to(start) {
        var positionName = $("#positionNameText").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/searchByPositionName",
            data: {"positionName": positionName, "start": start},
            type: "GET",
            success: function (result) {
                build_positions_table(result);
                build_searchPosition_nav(result);
                build_searchPosition_jump();
                build_searchPosition_info(result);
            }
        })
    }

    function build_searchPosition_nav(result) {
        build_pages_nav(result, searchPosition_to, "#page_position_nav");
    }

    function build_searchPosition_jump() {
        build_pages_jump("#page_position_jump", "jumpSearchPositionBtn");
    }

    function build_searchPosition_info(result) {
        build_positions_info(result, "#page_position_info");
    }

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpSearchPositionBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            searchPosition_to(num);
        }
    });
</script>
</body>
</html>
