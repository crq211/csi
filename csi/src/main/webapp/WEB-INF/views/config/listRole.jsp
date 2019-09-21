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
            <table class="table table-hover table-bordered" style="text-align: center">
                <thead>
                <tr>
                    <th>id</th>
                    <th>角色名称</th>
                    <th>角色描述</th>
                    <th>权限</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
                </thead>
                <c:forEach items="${rs}" var="r">
                    <tbody>
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.roleName}</td>
                        <td>${r.desc}</td>
                        <td>
                            <c:forEach items="${role_permissions[r]}" var="p">
                                ${p.permissionName} <br>
                            </c:forEach>
                        </td>
                        <td><a href="editRole?id=${r.id}">编辑</a></td>
                        <td><a href="deleteRole?id=${r.id}">删除</a></td>
                    </tr>
                    </tbody>
                </c:forEach>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-offset-5">
            <form action="addRole" method="post">
                角色名称: <input type="text" name="roleName"> <br><br>
                角色描述: <input type="text" name="desc"> <br><br>
                <input type="submit" value="增加">
            </form>
        </div>
    </div>
</div>
</body>
</html>