<%--
  Created by IntelliJ IDEA.
  User: crq211
  Date: 2019/7/3
  Time: 12:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <script>
        <%-- JQuery --%>
        $(function () {
            $("div#userDiv").click(function () {
                $("div#userDivs").toggle(500);
                $("div#departmentDivs").hide(500);
                $("div#positionDivs").hide(500);
                $("div#staffDivs").hide(500);
                $("div#noticeDivs").hide(500);
                $("div#downloadDivs").hide(500);
                $("#userSelect").removeAttr("style");
                $("#userAdd").removeAttr("style");
//                $("span#right").prop("class", "glyphicon glyphicon-chevron-down");
            });

            $("div#departmentDiv").click(function () {
                $("div#departmentDivs").toggle(500);
                $("div#userDivs").hide(500);
                $("div#positionDivs").hide(500);
                $("div#staffDivs").hide(500);
                $("div#noticeDivs").hide(500);
                $("div#downloadDivs").hide(500);
                $("#departmentSelect").removeAttr("style");
                $("#departmentAdd").removeAttr("style");
            });

            $("div#positionDiv").click(function () {
                $("div#positionDivs").toggle(500);
                $("div#userDivs").hide(500);
                $("div#departmentDivs").hide(500);
                $("div#staffDivs").hide(500);
                $("div#noticeDivs").hide(500);
                $("div#downloadDivs").hide(500);
            });
            $("div#staffDiv").click(function () {
                $("div#staffDivs").toggle(500);
                $("div#userDivs").hide(500);
                $("div#departmentDivs").hide(500);
                $("div#positionDivs").hide(500);
                $("div#noticeDivs").hide(500);
                $("div#downloadDivs").hide(500);
            });
            $("div#noticeDiv").click(function () {
                $("div#noticeDivs").toggle(500);
                $("div#userDivs").hide(500);
                $("div#departmentDivs").hide(500);
                $("div#positionDivs").hide(500);
                $("div#staffDivs").hide(500);
                $("div#downloadDivs").hide(500);
            });
            $("div#downloadDiv").click(function () {
                $("div#downloadDivs").toggle(500);
                $("div#userDivs").hide(500);
                $("div#departmentDivs").hide(500);
                $("div#positionDivs").hide(500);
                $("div#staffDivs").hide(500);
                $("div#noticeDivs").hide(500);
            });

            //点击左侧的用户查询
            $("#userSelect").click(function () {
                $("div.menuDiv").hide();
                $("#userSelectDiv").show();
                user_to(1);
                $("#userAdd").removeAttr("style");
                $(this).css("background-Color", "#4cae4c");
            });

            //点击左侧的添加用户
            $("#userAdd").click(function () {
                //清空样式
                $("#userAddDiv form")[0].reset();
                $("#userAddDiv form").find("*").removeClass("has-error has-success");
                $("#userAddDiv form").find(".help-block").text("");
                $("div.menuDiv").hide();
                $("div#userAddDiv").show();
                getRoles("#roleOption");
                $("#userSelect").removeAttr("style");
                $(this).css("background-Color", "#4cae4c");
            });

            //点击左侧的部门查询
            $("#departmentSelect").click(function () {
                $("div.menuDiv").hide();
                $("#departmentSelectDiv").show();
                department_to(1);
                $(this).css("background-Color", "#4cae4c");
                $("#departmentAdd").removeAttr("style");
            });

            //点击左侧的添加部门
            $("#departmentAdd").click(function () {
                //清空样式
                $("#departmentAddDiv form")[0].reset();
                $("#departmentAddDiv form").find("*").removeClass("has-error has-success");
                $("#departmentAddDiv form").find(".help-block").text("");
                $("div.menuDiv").hide();
                $("div#departmentAddDiv").show();
                $("#departmentSelect").removeAttr("style");
                $(this).css("background-Color", "#4cae4c");
            });

            //点击左侧的职位查询
            $("#positionSelect").click(function () {
                $("div.menuDiv").hide();
                $("#positionSelectDiv").show();
                position_to(1);
                $(this).css("background-Color", "#4cae4c");
                $("#positionAdd").removeAttr("style");
            });

            //点击左侧的添加职位
            $("#positionAdd").click(function () {
                //清空样式
                $("#positionAddDiv form")[0].reset();
                $("#positionAddDiv form").find("*").removeClass("has-error has-success");
                $("#positionAddDiv form").find(".help-block").text("");
                $("div.menuDiv").hide();
                $("div#positionAddDiv").show();
                $("#positionSelect").removeAttr("style");
                $(this).css("background-Color", "#4cae4c");
            });

            //点击左侧的员工查询
            $("#staffSelect").click(function () {
                $("div.menuDiv").hide();
                $("#staffSelectDiv").show();
                staff_to(1);
                getPositions("#positionStaff");
                getDepartments("#departmentStaff");
                $(this).css("background-Color", "#4cae4c");
                $("#staffAdd").removeAttr("style");
            });

            //点击左侧的添加员工
            $("#staffAdd").click(function () {
                //清空样式
                $("#staffAddDiv form")[0].reset();
                $("#staffAddDiv form").find("*").removeClass("has-error has-success");
                $("#staffAddDiv form").find(".help-block").text("");
                $("div.menuDiv").hide();
                $("div#staffAddDiv").show();
                var optionEle = $("<option></option>").append("--请选择职位--").attr("value", "0");
                optionEle.appendTo("#positionStaff");
                //显示职位和部门的下拉框
                getPositions("#positionOption");
                getDepartments("#departmentOption");
                $("#staffSelect").removeAttr("style");
                $(this).css("background-Color", "#4cae4c");
            });

            //点击左侧的公告查询
            $("#noticeSelect").click(function () {
                $("div.menuDiv").hide();
                $("#noticeSelectDiv").show();
                notice_to(1);
                $(this).css("background-Color", "#4cae4c");
                $("#noticeAdd").removeAttr("style");
            });

            //点击左侧的添加公告
            $("#noticeAdd").click(function () {
                //清空样式
                $("#noticeAddDiv form")[0].reset();
                $("#noticeAddDiv form").find("*").removeClass("has-error has-success");
                $("#noticeAddDiv form").find(".help-block").text("");
                $("div.menuDiv").hide();
                $("div#noticeAddDiv").show();
                $("#noticeSelect").removeAttr("style");
                $(this).css("background-Color", "#4cae4c");
            });

            //点击左侧的文档查询
            $("#downloadSelect").click(function () {
                $("div.menuDiv").hide();
                $("#downloadSelectDiv").show();
                download_to(1);
                $(this).css("background-Color", "#4cae4c");
                $("#downloadAdd").removeAttr("style");
            });

            //点击左侧的上传文档
            $("#downloadAdd").click(function () {
                //清空样式
                $("#downloadAddDiv form")[0].reset();
                $("#downloadAddDiv form").find("*").removeClass("has-error has-success");
                $("#downloadAddDiv form").find(".help-block").text("");
                $("div.menuDiv").hide();
                $("div#downloadAddDiv").show();
                $("#downloadSelect").removeAttr("style");
                $(this).css("background-Color", "#4cae4c");
            });

        });
        //通过ajax得到所有职位信息，并显示在下拉框里面，记得加上.attr("value", item.id);
        function getPositions(ele) {
            $(ele).empty();
            var optionEle = $("<option></option>").append("--请选择职位--").attr("value", "0");
            optionEle.appendTo("#positionStaff");
            $.ajax({
                url: "${pageContext.request.contextPath}/positionsSelect",
                type: "GET",
                success: function (result) {
                    var positionData = result.data.positionList;
                    $.each(positionData, function (index, item) {
                        var optionEle = $("<option></option>").append(item.positionName).attr("value", item.id);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }
        //通过ajax得到所有部门信息，并显示在下拉框里面
        function getDepartments(ele) {
            $(ele).empty();
            var optionEle = $("<option></option>").append("--部门选择--").attr("value", "0");
            optionEle.appendTo("#departmentStaff");
            $.ajax({
                url: "${pageContext.request.contextPath}/departmentSelect",
                type: "GET",
                success: function (result) {
                    var positionData = result.data.departmentList;
                    $.each(positionData, function (index, item) {
                        var optionEle = $("<option></option>").append(item.departmentName).attr("value", item.id);
                        optionEle.appendTo(ele);
//                        var option = "<option value='"+item.id+"'>"+ item.departmentName +"</option>"
//                        $("#departmentStaff").append(option);
                    });
                }
            });
        }
        //通过ajax得到所有角色信息，并显示在下拉框里面
        function getRoles(ele) {
            $(ele).empty();
            $.ajax({
                url: "${pageContext.request.contextPath}/roleSelect",
                type: "GET",
                success: function (result) {
                    var roleData = result.data.roleList;
                    $.each(roleData, function (index, item) {
                        var optionEle = $("<option></option>").append(item.desc).attr("value", item.id);
                        optionEle.appendTo(ele);
                    });
                }
            });
        }
    </script>
</head>
<body>
<div class="categoryWithCarousel">
    <%--<div style="position: static">--%>
    <div class="categoryMenu">
        <div class="eachCategory" id="userDiv">
            <span class="glyphicon glyphicon-star"></span>
            <span>用户管理</span>
            <span class="glyphicon glyphicon-chevron-right" id="right"></span>
        </div>
        <div id="userDivs" class="cardDivs" style="display: block">
            <div class="eachCategory" id="userSelect" style="background-color: #4cae4c">
                <span>用户查询</span>
            </div>
            <div class="eachCategory" id="userAdd">
                <span>添加用户</span>
            </div>
        </div>

        <div class="eachCategory" id="departmentDiv">
            <span class="glyphicon glyphicon-star"></span>
            <span>部门管理</span>
            <span class="glyphicon glyphicon-chevron-right"></span>
        </div>
        <div id="departmentDivs" class="cardDivs">
            <div class="eachCategory" id="departmentSelect">
                <span>部门查询</span>
            </div>
            <div class="eachCategory" id="departmentAdd">
                <span>添加部门</span>
            </div>
        </div>

        <div class="eachCategory" id="positionDiv">
            <span class="glyphicon glyphicon-star"></span>
            <span>职位管理</span>
            <span class="glyphicon glyphicon-chevron-right"></span>
        </div>
        <div id="positionDivs" class="cardDivs">
            <div class="eachCategory" id="positionSelect">
                <span>职位查询</span>
            </div>
            <div class="eachCategory" id="positionAdd">
                <span>添加职位</span>
            </div>
        </div>

        <div class="eachCategory" id="staffDiv">
            <span class="glyphicon glyphicon-star"></span>
            <span>员工管理</span>
            <span class="glyphicon glyphicon-chevron-right"></span>
        </div>
        <div id="staffDivs" class="cardDivs">
            <div class="eachCategory" id="staffSelect">
                <span>员工查询</span>
            </div>
            <div class="eachCategory" id="staffAdd">
                <span>添加员工</span>
            </div>
        </div>

        <div class="eachCategory" id="noticeDiv">
            <span class="glyphicon glyphicon-star"></span>
            <span>公告管理</span>
            <span class="glyphicon glyphicon-chevron-right"></span>
        </div>
        <div id="noticeDivs" class="cardDivs">
            <div class="eachCategory" id="noticeSelect">
                <span>公告查询</span>
            </div>
            <div class="eachCategory" id="noticeAdd">
                <span>添加公告</span>
            </div>
        </div>

        <div class="eachCategory" id="downloadDiv">
            <span class="glyphicon glyphicon-star"></span>
            <span>下载中心</span>
            <span class="glyphicon glyphicon-chevron-right"></span>
        </div>
        <div id="downloadDivs" class="cardDivs">
            <div class="eachCategory" id="downloadSelect">
                <span>文档查询</span>
            </div>
            <div class="eachCategory" id="downloadAdd">
                <span>上传文档</span>
            </div>
        </div>
    </div>
    <%--</div>--%>
</div>
</body>
</html>
