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
  <!-- 后台菜单 -->
  <div class="admin-left">
    <a href="goodsManage.jsp" style="background:#e1251b;color:#fff"><i class="bi bi-box-seam"></i> 商品管理</a>
    <a href="userManage.jsp"><i class="bi bi-person"></i> 用户管理</a>
    <a href="../index.jsp"><i class="bi bi-house"></i> 返回商城首页</a>
  </div>
  <div class="admin-right">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h4>全部商品管理（数据库实时数据）</h4>
    </div>
    <table class="table table-bordered" id="goodsTable">
      <thead class="table-light">
      <tr>
        <th>ID</th>
        <th>图片</th>
        <th>商品名称</th>
        <th>分类</th>
        <th>售价</th>
        <th>库存</th>
        <th>状态</th>
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
    requestApi("/api/admin/goods/all","GET",{},res=>{
      let html = "";
      res.data.forEach(item=>{
        let imgSrc = item.coverImg || "https://picsum.photos/id/10/300/300";
        html += `
            <tr>
                <td>${item.goodsId}</td>
                <td>
                    <img
                        src="${imgSrc}"
                        width="60"
                        crossorigin="anonymous"
                        onerror="this.src='https://picsum.photos/id/10/300/300'"
                    >
                </td>
                <td>${item.goodsName}</td>
                <td>${item.typeName}</td>
                <td class="jd-red">¥${item.price}</td>
                <td>${item.stock - item.lockedStock}</td>
                <td>${item.status==1?"正常上架":"已下架"}</td>
            </tr>`;
      })
      $("#goodsTable tbody").html(html);
    })
  }
</script>
</body>
</html>