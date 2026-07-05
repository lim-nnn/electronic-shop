<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userType = (String)session.getAttribute("userType");
    if(!"admin".equals(userType)){
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<html>
<head>
    <%@ include file="../head.jsp" %>
    <style>
        .admin-wrap{display:flex}
        .admin-left{width:200px;background:#222;color:#fff;min-height:600px;padding-top:30px}
        .admin-left a{display:block;color:#ccc;padding:14px 30px}
        .admin-left a:hover{background:#e1251b;color:#fff}
        .admin-right{flex:1;padding:30px}
    </style>
</head>
<body class="jd-gray-bg">
<div class="admin-wrap container-main mt-4 bg-white">
    <!-- 后台左侧菜单 -->
    <div class="admin-left">
        <a href="goodsManage.jsp"><i class="bi bi-box-seam"></i> 商品管理</a>
        <a href="userManage.jsp" style="background:#e1251b;color:#fff"><i class="bi bi-person"></i> 用户管理</a>
        <a href="orderManage.jsp"><i class="bi bi-receipt"></i> 订单管理</a>
        <a href="../index.jsp"><i class="bi bi-house"></i> 返回商城首页</a>
    </div>
    <!-- 右侧用户管理表格 -->
    <div class="admin-right">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4>全部注册用户管理</h4>
            <div>
                <input placeholder="输入账号搜索" class="px-2 py-1 border">
                <button class="jd-red-bg border-0 px-3 py-1">搜索</button>
            </div>
        </div>
        <table class="table table-bordered">
            <thead class="table-light">
            <tr>
                <th>用户ID</th>
                <th>登录账号</th>
                <th>用户昵称</th>
                <th>注册时间</th>
                <th>用户类型</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>1</td>
                <td>zhangsan123</td>
                <td>张三</td>
                <td>2026-06-20</td>
                <td>普通会员</td>
                <td>
                    <button class="btn btn-sm btn-danger">删除用户</button>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>admin001</td>
                <td>管理员</td>
                <td>2026-06-01</td>
                <td>管理员</td>
                <td><span class="text-secondary">不可操作</span></td>
            </tr>
            <tr>
                <td>3</td>
                <td>lisi456</td>
                <td>小莉</td>
                <td>2026-07-01</td>
                <td>普通会员</td>
                <td>
                    <button class="btn btn-sm btn-danger">删除用户</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<footer>
    <div class="container-main">
        <p>商家管理后台 ©2026 电子商城</p>
    </div>
</footer>
</body>
</html>