<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/18
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<body>
<%-- 模态窗口 --%>
<div class="modal fade" id="previewNoticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h5 class="modal-title" id="myModalLabel" style="font-weight: bold">预览公告</h5>
            </div>
            <div class="modal-body">
                <div style="margin-bottom: 50px">
                    <label class="col-sm-6 col-sm-offset-4 control-label titleLabel">参加会议通知</label>
                </div>
                <div style="height: 200px">
                    <label class="col-sm-10 control-label messageLabel" id="noticeMessage"></label>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<%-- 显示公告 --%>
<div class="menuDiv" id="noticeSelectDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">公告查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：公告管理 > 公告查询</span>
        </div>

        <div class="searchDiv">
            公告名称：<input type="text" id="noticeNameText">
            公告内容：<input type="text" id="noticeMsgText">
            <button type="button" class="btn btn-primary btn-sm" id="searchNoticeBtn">搜索</button>
            <button type="button" class="btn btn-danger btn-sm" id="deleteNoticeBtn">删除</button>
        </div>

        <div class="dataDiv">
            <table class="table table-hover table-bordered dataTable" id="notices_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkNoticeAll"></th>
                    <th>公告名称</th>
                    <th>公告内容</th>
                    <th>创建时间</th>
                    <th>公告人</th>
                    <th>操作</th>
                    <th>预览</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="pageDiv">
            <%-- 分页条信息 --%>
            <div id="page_notice_nav"></div>
            <%-- 分页跳转信息 --%>
            <div id="page_notice_jump"></div>
            <%-- 分页文字信息 --%>
            <div id="page_notice_info"></div>
        </div>
    </div>
</div>

<%-- 修改公告 --%>
<div class="menuDiv" id="noticeUpdateDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">修改公告</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：公告管理 > 修改公告</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">公告标题：</label>
                    <div class="col-sm-3">
                        <input type="text" name="noticeName" id="noticeNameEdit" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">公告内容：</label>
                    <div class="col-sm-6">
                        <textarea name="message" id="messageEditN" class="form-control" rows="5"></textarea>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-2">
                        <button type="button" id="noticeUpdateBtn" class="btn btn-default">修改</button>
                        <button type="button" id="noticeCancelEditBtn" class="btn btn-default">重置</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 添加公告 --%>
<div class="menuDiv" id="noticeAddDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">添加公告</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：公告管理 > 添加公告</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-1 control-label">公告标题：</label>
                    <div class="col-sm-3">
                        <input type="text" name="noticeName" id="noticeNameAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">公告内容：</label>
                    <div class="col-sm-6">
                        <textarea name="message" id="messageAddN" class="form-control" rows="5"></textarea>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-2">
                        <button type="button" id="noticeAddBtn" class="btn btn-default">添加</button>
                        <button type="button" id="noticeCancelAddBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
                <input type="hidden" name="userId" value="${user.id}">
            </form>
        </div>
    </div>
</div>

<script>
    //显示方法，传递后端查询出来的数据
    function notice_to(start) {
        $.ajax({
            url: "${pageContext.request.contextPath}/notices",
            data: "start=" + start,
            type: "GET",
            success: function (result) {
                build_notices_table(result);
                build_notices_nav(result);
                build_notices_jump();
                build_notices_info(result);
            }
        })
    }

    function build_notices_table(result) {
        $("div.dataDiv table tbody").empty();
        var notices = result.data.page.list;
        $.each(notices, function (index, item) {
            var checkboxTd = $("<td></td>").append("<input type='checkbox' class='checkNoticeItem'/>");
            var noticeNameTd = $("<td></td>").append(item.noticeName);
            var messageTd = $("<td></td>").append(item.message);
            var formatDate = formatStrDate(new Date(item.createDate));
            var createDateTd = $("<td></td>").append(formatDate);
            var userTd = $("<td></td>").append(item.user.userName);
            var editBtn = $("<button></button>").addClass("btn btn-link btn-sm editNoticeBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-edit"));
            //为编辑按钮添加一个自定义属性
            editBtn.attr("editId", item.id);
            var editTd = $("<td></td>").append(editBtn);
            var previewBtn = $("<button></button>").addClass("btn btn-link btn-sm previewNoticeBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-eye-open"));
            //为预览按钮添加一个自定义属性
            previewBtn.attr("previewId", item.id);
            var previewTd = $("<td></td>").append(previewBtn);
            $("<tr></tr>").append(checkboxTd).append(noticeNameTd)
                .append(messageTd).append(createDateTd).append(userTd).append(editTd)
                .append(previewTd).appendTo("#notices_table tbody");
        });
    }

    function build_notices_nav(result) {
        build_pages_nav(result, notice_to, "#page_notice_nav");
    }

    function build_notices_jump() {
        build_pages_jump("#page_notice_jump", "jumpNoticeBtn");
    }

    function build_notices_info(result) {
        build_pages_info(result, "#page_notice_info")
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
    $(document).on("click", ".jumpNoticeBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            notice_to(num);
        }
    });

    //点击添加按钮
    $(document).on("click", "#noticeAddBtn", function () {
        var noticeName = $("#noticeNameAdd").val();
        var messageAddN = $("#messageAddN").val();
        if (noticeName.length == 0) {
            show_validate_msg("fail", "#noticeNameAdd", "请输入公告标题");
            return false;
        }
        if (messageAddN.length == 0) {
            show_validate_msg("fail", "#messageAddN", "请输入公告内容");
            return false;
        }
        $.ajax({
            url: "${pageContext.request.contextPath}/notice",
            type: "POST",
            data: $("#noticeAddDiv form").serialize(),
            success: function (result) {
                if (result.code == 0) {
                    $("div#noticeAddDiv").hide();
                    $("div#noticeSelectDiv").show();
                    $("#noticeAdd").removeAttr("style");
                    $("#noticeSelect").css("background-Color", "#4cae4c");
                    notice_to(1);
                }else {
                    alert("您没有这个权限");
                }
            }
        })
    });

    //点击取消添加按钮
    $(document).on("click", "#noticeCancelAddBtn", function () {
        $("#noticeAddDiv form")[0].reset();
        $("#noticeAddDiv form").find("*").removeClass("has-error has-success");
        $("#noticeAddDiv form").find(".help-block").text("");
    });

    //点击编辑按钮
    $(document).on("click", ".editNoticeBtn", function () {
        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/notice/" + id,
            type: "GET",
            success: function (result) {
                if (result.code == 0) {
                    //清空样式
                    $("#noticeUpdateDiv form").find("*").removeClass("has-error has-success");
                    $("#noticeUpdateDiv form").find(".help-block").text("");
                    $("div#noticeSelectDiv").hide();
                    $("div#noticeUpdateDiv").show();
                    var data = result.data.notice;
                    //设置数据在页面上
                    $("#noticeNameEdit").val(data.noticeName);
                    $("#messageEditN").val(data.message);
                }else {
                    alert("您没有这个权限");
                }
            }
        });
        //给修改按钮加上这个用户的id
        $("#noticeUpdateBtn").attr("editId", id);
    });

    //点击重置按钮
    $(document).on("click", "#noticeCancelEditBtn", function () {
        $("#noticeUpdateDiv form")[0].reset();
        $("#noticeUpdateDiv form").find("*").removeClass("has-error has-success");
        $("#noticeUpdateDiv form").find(".help-block").text("");
    });

    //点击修改按钮
    $(document).on("click", "#noticeUpdateBtn", function () {
        var noticeName = $("#noticeNameEdit").val();
        var message = $("#messageEditN").val();
        if (noticeName.length == 0) {
            show_validate_msg("fail", "#noticeNameEdit", "请输入公告标题");
            return false;
        }
        if (message.length == 0) {
            show_validate_msg("fail", "#messageEditN", "请输入公告内容");
            return false;
        }
        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/notice/" + id,
            type: "PUT",
            data: $("#noticeUpdateDiv form").serialize(),
            success: function (result) {
                if (result.code == 0) {
                    $("div#noticeUpdateDiv").hide();
                    $("div#noticeSelectDiv").show();
                    notice_to(curPage);
                }else {
                    alert("您没有这个权限");
                }
            }
        })
    });

    //点击全选按钮
    $("#checkNoticeAll").click(function () {
        $(".checkNoticeItem").prop("checked", $(this).prop("checked"))
    });

    //点击全选按钮
    $("#checkNoticeAll").click(function () {
        $(".checkNoticeItem").prop("checked", $(this).prop("checked"))
    });

    //点击下面的判断是否全选, 之后事件，使用on
    $(document).on("click", ".checkNoticeItem", function () {
        //JQuery提供的:checked，判断选中的
        var flag = $(".checkNoticeItem:checked").length == $(".checkNoticeItem").length;
        $("#checkNoticeAll").prop("checked", flag);
    });

    //点击删除按钮
    $("#deleteNoticeBtn").click(function () {
        var names = "";
        var ids = "";
        $.each($(".checkNoticeItem:checked"), function () {
            names += $(this).parents("tr").find("td:eq(1)").text() + ",";
            ids += $(this).parents("tr").find("td:eq(5)").find("button").attr("editId") + "-";
        });
        names = names.substring(0, names.length - 1);
        ids = ids.substring(0, ids.length - 1);
        if ($(".checkNoticeItem:checked").length != 0) {
            if (confirm("确认删除【" + names + "】吗?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/notice/" + ids,
                    type: "DELETE",
                    success: function (result) {
                        if (result.code == 0) {
                            notice_to(curPage);
                        }else {
                            alert("您没有这个权限");
                        }
                    }
                })
            }
        }
    });

    //点击预览按钮
    $(document).on("click", ".previewNoticeBtn", function () {
        var id = $(this).attr("previewId");
        $.ajax({
            url: "${pageContext.request.contextPath}/noticePreview/" + id,
            type: "GET",
            success: function (result) {
                var data = result.data.notice;
                //设置数据在页面上
                $("#noticeMessage").html(data.message);
            }
        });
        $("#previewNoticeModal").modal({
            backdrop: "static"
        });
    });

    //点击搜索按钮
    $("#searchNoticeBtn").click(function () {
        $("div.menuDiv").hide();
        $("div#noticeSelectDiv").show();
        searchNotice_to(1);
    });

    function searchNotice_to(start) {
        var noticeName = $("#noticeNameText").val();
        var noticeMsg = $("#noticeMsgText").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/searchByNotice",
            data: {"noticeName": noticeName, "noticeMsg": noticeMsg, "start": start},
            type: "GET",
            success: function (result) {
                build_notices_table(result);
                build_searchNotice_nav(result);
                build_searchNotice_jump();
                build_searchNotice_info(result);
            }
        })
    }

    function build_searchNotice_nav(result) {
        build_pages_nav(result, searchNotice_to, "#page_notice_nav");
    }

    function build_searchNotice_jump() {
        build_pages_jump("#page_notice_jump", "jumpSearchNoticeBtn");
    }

    function build_searchNotice_info(result) {
        build_pages_info(result, "#page_notice_info");
    }

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpSearchNoticeBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            searchNotice_to(num);
        }
    });
</script>
</body>
</html>
