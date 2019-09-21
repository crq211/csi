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
            <form action="updatePermission" method="post">
                权限名称: <input type="text" name="permissionName" value="${permission.permissionName}" /> <br><br>
                权限描述: <input type="text" name="desc" value="${permission.desc}"> <br><br>
                权限对应的url: <input type="text" name="url" value="${permission.url}"> <br><br>
                <input type="hidden" name="id" value="${permission.id}">
                <input type="submit" value="修改">
            </form>
        </div>
    </div>
</div>
</body>
</html>