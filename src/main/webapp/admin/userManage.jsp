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
    <div class="admin-left">
        <a href="goodsManage.jsp"><i class="bi bi-box-seam"></i> 商品管理</a>
        <a href="userManage.jsp" style="background:#e1251b;color:#fff"><i class="bi bi-person"></i> 用户管理</a>
        <a href="../index.jsp"><i class="bi bi-house"></i> 返回商城首页</a>
    </div>
    <div class="admin-right">
        <h4>注册用户列表（读取UserInfo表）</h4>
        <table class="table table-bordered mt-4" id="userTable">
            <thead class="table-light">
            <tr>
                <th>用户ID</th>
                <th>登录账号</th>
                <th>昵称</th>
                <th>手机号</th>
                <th>注册时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</div>
<footer>
    <div class="container-main">
        <p>商家管理后台 ©2026</p>
    </div>
</footer>
<script>
    window.onload = function(){
        requestApi("/api/admin/user/all","GET",{},res=>{
            let html = "";
            res.data.forEach(item=>{
                html += `
            <tr>
                <td>${item.userId}</td>
                <td>${item.account}</td>
                <td>${item.nickName}</td>
                <td>${item.phone||"无"}</td>
                <td>${item.createTime}</td>
                <td>${item.status==1?"正常":"禁用"}</td>
                <td>
                    <button class="btn btn-sm btn-danger" onclick="delUser(${item.userId})">删除</button>
                </td>
            </tr>`;
            })
            $("#userTable tbody").html(html);
        })
    }
    function delUser(userId){
        if(!confirm("确定删除该用户？关联数据会报错！")) return;
        requestApi("/api/admin/user/del","POST",{userId:userId},res=>{
            location.reload();
        })
    }
</script>
</body>
</html>