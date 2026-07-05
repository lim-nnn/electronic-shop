<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String username = (String) session.getAttribute("username");
  if(username == null){
    response.sendRedirect("login.jsp");
    return;
  }
%>
<html>
<head>
  <%@ include file="head.jsp" %>
  <style>
    .order-item{background:#fff;margin:15px 0}
    .order-top{padding:12px 20px;border-bottom:1px #eee solid;display:flex;justify-content:space-between}
    .order-body{padding:15px 20px;display:flex;align-items:center;gap:20px}
    .order-img{width:100px;height:100px;object-fit:cover}
    .order-status{color:#e1251b;font-weight:bold}
  </style>
</head>
<body class="jd-gray-bg">
<div class="container-main mt-4">
  <h4 class="mb-4"><i class="bi bi-receipt jd-red"></i> 我的全部订单</h4>

  <!-- 订单1 -->
  <div class="order-item">
    <div class="order-top">
      <span>订单号：202607050001</span>
      <span class="order-status">已发货</span>
    </div>
    <div class="order-body">
      <img class="order-img" src="https://img14.360buyimg.com/n1/jfs/t1/189677/36/27018/41669/645c3241F86260661/0d64220090644002.jpg">
      <div style="flex:1">
        <p>2025新款旗舰智能手机 5G全网通</p>
        <p class="text-secondary">数量：1 | 单价：¥1999.00</p>
      </div>
      <div>
        <p class="jd-red fs-5 fw-bold">¥1999.00</p>
        <button class="btn btn-sm btn-outline-danger mt-2">查看物流</button>
      </div>
    </div>
  </div>

  <!-- 订单2 -->
  <div class="order-item">
    <div class="order-top">
      <span>订单号：202607040008</span>
      <span class="text-secondary">已完成</span>
    </div>
    <div class="order-body">
      <img class="order-img" src="https://img14.360buyimg.com/n1/jfs/t1/186322/32/27301/46669/645c3420F2d0d2299/9d2929040d9d4043.jpg">
      <div style="flex:1">
        <p>无线蓝牙耳机 主动降噪运动款</p>
        <p class="text-secondary">数量：1 | 单价：¥299.00</p>
      </div>
      <div>
        <p class="jd-red fs-5 fw-bold">¥299.00</p>
        <button class="btn btn-sm btn-outline-secondary mt-2">再次购买</button>
      </div>
    </div>
  </div>
</div>

<footer class="mt-5">
  <div class="container-main">
    <p>电子商城 ©2026 版权所有</p>
  </div>
</footer>
</body>
</html>