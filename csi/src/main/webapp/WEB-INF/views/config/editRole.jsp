<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <script src="./static/js/jquery-1.12.4.min.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <style>
        th {
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4">
            <a href="listUser"><h4>用户管理</h4></a>
        </div>
        <div class="col-md-4">
            <a href="listRole"><h4>角色管理</h4></a>
        </div>
        <div class="col-md-4">
            <a href="listPermission"><h4>权限管理</h4></a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <form action="updateRole" method="post">
                角色名: <input type="text" name="roleName" value="${role.roleName}"> <br><br>
                角色描述: <input type="text" name="desc" value="${role.desc}"> <br><br>
                配置权限:<br>
                <div style="text-align:left;width:300px;margin:0px auto;padding-left:20px">
                    <c:forEach items="${ps}" var="p">
                        <c:set var="hasPermission" value="false"/>
                        <c:forEach items="${currentPermissions}" var="currentPermission">
                            <c:if test="${p.id==currentPermission.id}">
                                <c:set var="hasPermission" value="true"/>
                            </c:if>
                        </c:forEach>
                        <input type="checkbox"  ${hasPermission ? "checked='checked'" : ""} name="permissionIds"
                               value="${p.id}"> ${p.permissionName}<br>

                    </c:forEach>
                </div>
                <input type="hidden" name="id" value="${role.id}">
                <input type="submit" value="修改">
            </form>
        </div>
    </div>
</div>
</div>
</body>
</html>