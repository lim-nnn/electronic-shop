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
    <a href="goodsManage.jsp" style="background:#e1251b;color:#fff"><i class="bi bi-box-seam"></i> 商品管理</a>
    <a href="userManage.jsp"><i class="bi bi-person"></i> 用户管理</a>
    <a href="orderManage.jsp"><i class="bi bi-receipt"></i> 订单管理</a>
    <a href="../index.jsp"><i class="bi bi-house"></i> 返回商城首页</a>
  </div>
  <!-- 右侧操作区域 -->
  <div class="admin-right">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h4>商品列表管理</h4>
      <button class="jd-red-bg border-0 px-4 py-2">新增商品</button>
    </div>
    <table class="table table-bordered">
      <thead class="table-light">
      <tr>
        <th>商品ID</th>
        <th>商品图片</th>
        <th>商品名称</th>
        <th>分类</th>
        <th>售价</th>
        <th>库存</th>
        <th>操作</th>
      </tr>
      </thead>
      <tbody>
      <tr>
        <td>10001</td>
        <td><img src="https://img14.360buyimg.com/n1/jfs/t1/189677/36/27018/41669/645c3241F86260661/0d64220090644002.jpg" width="60"></td>
        <td>2025新款旗舰智能手机</td>
        <td>手机数码</td>
        <td class="jd-red">¥1999.00</td>
        <td>236</td>
        <td>
          <button class="btn btn-sm btn-primary">编辑</button>
          <button class="btn btn-sm btn-danger">下架删除</button>
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