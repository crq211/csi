<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/23
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<body>
<%-- 文档管理 --%>
<div class="menuDiv" id="downloadSelectDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">文档查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：文档管理 > 文档查询</span>
        </div>

        <div class="searchDiv">
            标题：<input type="text" id="titleText">
            <button type="button" class="btn btn-primary btn-sm" id="searchDownloadBtn">搜索</button>
            <button type="button" class="btn btn-danger btn-sm" id="deleteDownloadBtn">删除</button>
        </div>

        <div class="dataDiv">
            <table class="table table-hover table-bordered dataTable" id="downloads_table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkDownloadAll"></th>
                    <th>标题</th>
                    <th>创建时间</th>
                    <th>创建人</th>
                    <th>描述</th>
                    <th>操作</th>
                    <th>下载</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="pageDiv">
            <%-- 分页条信息 --%>
            <div id="page_download_nav"></div>
            <%-- 分页跳转信息 --%>
            <div id="page_download_jump"></div>
            <%-- 分页文字信息 --%>
            <div id="page_download_info"></div>
        </div>
    </div>
</div>

<%-- 修改文档 --%>
<div class="menuDiv" id="downloadUpdateDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">文档查询</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：文档管理 > 修改文档</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal" id="tf" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="col-sm-1 control-label">文档标题：</label>
                    <div class="col-sm-3">
                        <input type="text" name="title" id="titleEdit" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">文档描述：</label>
                    <div class="col-sm-6">
                        <textarea name="message" id="messageEditDo" class="form-control" rows="5"></textarea>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">文档：</label>
                    <div class="col-sm-3">
                        <input type="file" name="image" id="fileEdit" value="选择文件">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-2">
                        <button type="button" id="downloadUpdateBtn" class="btn btn-default">确定</button>
                        <button type="button" id="downloadCancelEditBtn" class="btn btn-default">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<%-- 上传文档 --%>
<div class="menuDiv" id="downloadAddDiv" style="display: none">
    <div class="titleDiv">
        <span class="label label-info">上传文档</span>
    </div>
    <div class="outDiv">
        <div class="placeDiv">
            <span>当前位置：文档管理 > 上传文档</span>
        </div>

        <div class="dataDiv">
            <form class="form-horizontal" enctype="multipart/form-data">
                <div class="form-group">
                    <label class="col-sm-1 control-label">文档标题：</label>
                    <div class="col-sm-3">
                        <input type="text" name="title" id="titleAdd" class="form-control">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">文档描述：</label>
                    <div class="col-sm-6">
                        <textarea name="message" id="messageAddDo" class="form-control" rows="5"></textarea>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">文档：</label>
                    <div class="col-sm-3">
                        <input type="file" name="image" id="fileAdd" value="选择文件">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-2">
                        <button type="button" id="downloadAddBtn" class="btn btn-default">上传</button>
                        <button type="button" id="downloadCancelAddBtn" class="btn btn-default">重置</button>
                    </div>
                </div>
                <input type="hidden" name="userId" value="${user.id}" id="userIdAdd">
            </form>
        </div>
    </div>
</div>


<script>
    //显示方法，传递后端查询出来的数据
    function download_to(start) {
        $.ajax({
            url: "${pageContext.request.contextPath}/downloads",
            data: "start=" + start,
            type: "GET",
            success: function (result) {
                build_downloads_table(result);
                build_downloads_nav(result);
                build_downloads_jump();
                build_downloads_info(result);
            }
        })
    }

    function build_downloads_table(result) {
        $("div.dataDiv table tbody").empty();
        var downloads = result.data.page.list;
        $.each(downloads, function (index, item) {
            var checkboxTd = $("<td></td>").append("<input type='checkbox' class='checkDownloadItem'/>");
            var titleTd = $("<td></td>").append(item.title);
            var formatDate = formatStrDate(new Date(item.createDate));
            var createDateTd = $("<td></td>").append(formatDate);
            var userTd = $("<td></td>").append(item.user.userName);
            var messageTd = $("<td></td>").append(item.message);
            var editBtn = $("<button></button>").addClass("btn btn-link btn-sm editDownloadBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-edit"));
            //为编辑按钮添加一个自定义属性
            editBtn.attr("editId", item.id);
            var editTd = $("<td></td>").append(editBtn);
            var downloadBtn = $("<button></button>").addClass("btn btn-link btn-sm fileDownloadBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon glyphicon-download"));
            //为预览按钮添加一个自定义属性
            downloadBtn.attr("downloadId", item.id);
            var downloadTd = $("<td></td>").append(downloadBtn);
            $("<tr></tr>").append(checkboxTd).append(titleTd)
                .append(createDateTd).append(userTd).append(messageTd).append(editTd)
                .append(downloadTd).appendTo("#downloads_table tbody");
        });
    }

    function build_downloads_nav(result) {
        build_pages_nav(result, download_to, "#page_download_nav")

    }

    function build_downloads_jump() {
        build_pages_jump("#page_download_jump", "jumpDownloadBtn");
    }

    function build_downloads_info(result) {
        build_pages_info(result, "#page_download_info");
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
    $(document).on("click", ".jumpDownloadBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            download_to(num);
        }
    });

    //点击上传按钮
    $(document).on("click", "#downloadAddBtn", function () {
        var title = $("#titleAdd").val();
        var message = $("#messageAddDo").val();
        var file = $("#fileAdd").val();
        if (title.length == 0) {
            show_validate_msg("fail", "#titleAdd", "请输入文档标题");
            return false;
        }
        if (message.length == 0) {
            show_validate_msg("fail", "#messageAddDo", "请输入文档描述");
            return false;
        }
        if (file.length == 0) {
            show_validate_msg("fail", "#fileAdd", "请选择要上传的文件");
            return false;
        }

        var formData = new FormData();
        var uploadFile = $('#fileAdd').get(0).files[0];
        var userId = $('#userIdAdd').val();
        formData.append("image", uploadFile);
        formData.append("title", title);
        formData.append("message", message);
        formData.append("userId", userId);
        $.ajax({
            url: "${pageContext.request.contextPath}/download",
            type: "POST",
            data: formData,
            async: false,
            cache: false,
            contentType: false, //不设置内容类型
            processData: false, //不处理数据
            success: function (result) {
                if (result.code == 0) {
                    $("div#downloadAddDiv").hide();
                    $("div#downloadSelectDiv").show();
                    $("#downloadAdd").removeAttr("style");
                    $("#downloadSelect").css("background-Color", "#4cae4c");
                    download_to(1);
                } else {
                    alert("您没有这个权限");
                }
            }
        })
    });

    //点击重置按钮
    $(document).on("click", "#downloadCancelAddBtn", function () {
        $("#downloadAddDiv form")[0].reset();
        $("#downloadAddDiv form").find("*").removeClass("has-error has-success");
        $("#downloadAddDiv form").find(".help-block").text("");
    });

    //点击编辑按钮
    $(document).on("click", ".editDownloadBtn", function () {
        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/download/" + id,
            type: "GET",
            success: function (result) {
                if (result.code == 0) {
                    //清空样式
                    $("#downloadUpdateDiv form").find("*").removeClass("has-error has-success");
                    $("#downloadUpdateDiv form").find(".help-block").text("");
                    $("div#downloadSelectDiv").hide();
                    $("div#downloadUpdateDiv").show();
                    var data = result.data.download;
                    //设置数据在页面上
                    $("#titleEdit").val(data.title);
                    $("#messageEditDo").val(data.message);
                } else {
                    alert("您没有这个权限");
                }
            }
        });
        //给修改按钮加上这个用户的id
        $("#downloadUpdateBtn").attr("editId", id);
    });

    //点击取消编辑按钮
    $(document).on("click", "#downloadCancelEditBtn", function () {
        $("div#downloadUpdateDiv").hide();
        $("div#downloadSelectDiv").show();
        download_to(curPage);
    });

    //点击修改按钮
    $(document).on("click", "#downloadUpdateBtn", function () {
        var title = $("#titleEdit").val();
        var message = $("#messageEditDo").val();
        if (title.length == 0) {
            show_validate_msg("fail", "#titleEdit", "请输入文档标题");
            return false;
        }
        if (message.length == 0) {
            show_validate_msg("fail", "#messageEditDo", "请输入文档描述");
            return false;
        }

        var formData = new FormData();
        var uploadFile = $('#fileEdit').get(0).files[0];
        console.log(uploadFile);
        formData.append("image", uploadFile);
        formData.append("title", title);
        formData.append("message", message);
//        formData.append("_method", 'PUT');

        var id = $(this).attr("editId");
        $.ajax({
            url: "${pageContext.request.contextPath}/download/" + id,
            type: "POST",
            data: formData,
            async: false,
            cache: false,
            contentType: false, //不设置内容类型
            processData: false, //不处理数据
            dataType: "json",//设置返回数据的格式
            success: function (result) {
                if (result.code == 0) {
                    $("div#downloadUpdateDiv").hide();
                    $("div#downloadSelectDiv").show();
                    download_to(curPage);
                } else {
                    alert("您没有这个权限");
                }
            }
        })
    });

    //点击全选按钮
    $("#checkDownloadAll").click(function () {
        $(".checkDownloadItem").prop("checked", $(this).prop("checked"))
    });

    //点击下面的判断是否全选, 之后事件，使用on
    $(document).on("click", ".checkDownloadItem", function () {
        //JQuery提供的:checked，判断选中的
        var flag = $(".checkDownloadItem:checked").length == $(".checkDownloadItem").length;
        $("#checkDownloadAll").prop("checked", flag);
    });

    //点击删除按钮
    $("#deleteDownloadBtn").click(function () {
        var names = "";
        var ids = "";
        $.each($(".checkDownloadItem:checked"), function () {
            names += $(this).parents("tr").find("td:eq(1)").text() + ",";
            ids += $(this).parents("tr").find("td:eq(5)").find("button").attr("editId") + "-";
        });
        names = names.substring(0, names.length - 1);
        ids = ids.substring(0, ids.length - 1);
        if ($(".checkDownloadItem:checked").length != 0) {
            if (confirm("确认删除【" + names + "】吗?")) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/download/" + ids,
                    type: "DELETE",
                    success: function (result) {
                        if (result.code == 0) {
                            download_to(curPage);
                        } else {
                            alert("您没有这个权限");
                        }
                    }
                })
            }
        }
    });

    //点击搜索按钮
    $("#searchDownloadBtn").click(function () {
        $("div.menuDiv").hide();
        $("div#downloadSelectDiv").show();
        searchDownload_to(1);
    });

    function searchDownload_to(start) {
        var downloadTitle = $("#titleText").val();
        $.ajax({
            url: "${pageContext.request.contextPath}/searchByDownloadTitle",
            data: {"downloadTitle": downloadTitle, "start": start},
            type: "GET",
            success: function (result) {
                build_downloads_table(result);
                build_searchDownload_nav(result);
                build_searchDownload_jump();
                build_searchDownload_info(result);
            }
        })
    }

    function build_searchDownload_nav(result) {
        build_pages_nav(result, searchDownload_to, "#page_download_nav");
    }

    function build_searchDownload_jump() {
        build_pages_jump("#page_download_jump", "jumpSearchDownloadBtn");
    }

    function build_searchDownload_info(result) {
        build_positions_info(result, "#page_download_info");
    }

    //跳转确认按钮点击函数
    $(document).on("click", ".jumpSearchDownloadBtn", function () {
        var num = $(".jumpSet").val();
        if (num != "" && num != curPage) {
            searchDownload_to(num);
        }
    });

    //点击下载按钮
    $(document).on("click", ".fileDownloadBtn", function () {
        var id = $(this).attr("downloadId");
       window.location.href="${pageContext.request.contextPath}/downloadFile?id=" + id;
    });

</script>
</body>
</html>
