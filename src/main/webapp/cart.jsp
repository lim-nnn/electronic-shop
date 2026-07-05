<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
</head>
<body class="jd-gray-bg">
<div class="container-main bg-white p-4 mt-4">
  <h4 class="border-bottom pb-3 mb-4"><i class="bi bi-cart4 jd-red"></i> 我的购物车</h4>
  <table class="table text-center">
    <thead>
    <tr>
      <th width="10%">选择</th>
      <th width="40%">商品信息</th>
      <th width="15%">单价</th>
      <th width="15%">数量</th>
      <th width="15%">小计</th>
      <th width="5%">操作</th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td><input type="checkbox"></td>
      <td class="d-flex gap-3 align-items-center">
        <img src="https://img14.360buyimg.com/n1/jfs/t1/189677/36/27018/41669/645c3241F86260661/0d64220090644002.jpg" width="80">
        <div>2025新款旗舰智能手机 5G全网通</div>
      </td>
      <td class="jd-red fw-bold">¥1999.00</td>
      <td>
        <button class="border px-2">-</button>
        <input value="1" style="width:40px;text-align:center;border:1px solid #ddd;margin:0 4px">
        <button class="border px-2">+</button>
      </td>
      <td class="jd-red fw-bold">¥1999.00</td>
      <td><a href="#" class="text-danger">删除</a></td>
    </tr>
    </tbody>
  </table>
  <div class="d-flex justify-content-between align-items-center mt-4 border-top pt-4">
    <div><input type="checkbox"> 全选</div>
    <div class="d-flex align-items-center gap-4">
      <span>合计：<span class="jd-red fs-3 fw-bold">¥1999.00</span></span>
      <button class="jd-red-bg border-0 px-5 py-2 fs-5">去结算</button>
    </div>
  </div>
</div>
<footer>
  <div class="container-main">
    <p>电子商城 ©2026 版权所有</p>
  </div>
</footer>
</body>
</html>