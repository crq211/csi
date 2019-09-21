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
                <tr>
                    <td>id</td>
                    <td>权限名称</td>
                    <td>权限描述</td>
                    <td>权限对应的路径</td>
                    <td>编辑</td>
                    <td>删除</td>
                </tr>
                <c:forEach items="${ps}" var="p">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.permissionName}</td>
                        <td>${p.desc}</td>
                        <td>${p.url}</td>
                        <td><a href="editPermission?id=${p.id}">编辑</a></td>
                        <td><a href="deletePermission?id=${p.id}">删除</a></td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-offset-5">
            <form action="addPermission" method="post">
                权限名称: <input type="text" name="permissionName"> <br><br>
                权限描述: <input type="text" name="desc"> <br><br>
                权限对应的url: <input type="text" name="url"> <br><br>
                <input type="submit" value="增加">
            </form>
        </div>
    </div>
</div>
</body>
</html>