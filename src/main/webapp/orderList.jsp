<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
  <style>
    .order-item{background:#fff;margin:15px 0}
    .order-top{padding:12px 20px;border-bottom:1px #eee solid;display:flex;justify-content:space-between}
    .order-body{padding:15px 20px;display:flex;align-items:center;gap:20px}
    .order-img{width:100px;height:100px;object-fit:cover}
  </style>
</head>
<body class="jd-gray-bg">
<div class="container-main mt-4">
  <h4 class="mb-4"><i class="bi bi-receipt jd-red"></i> 我的全部订单</h4>
  <div id="orderBox"></div>
</div>
<footer class="mt-5">
  <div class="container-main">
    <p>电子商城 ©2026</p>
  </div>
</footer>
<script>
  window.onload = function(){
    if(!checkLogin()) return;
    requestApi("/api/order/my","POST",{},function(res){
      let html = "";
      res.data.forEach(order=>{
        let statusText = "";
        if(order.orderStatus == 0) statusText = "<span class='text-warning'>待付款</span>";
        else if(order.orderStatus == 1) statusText = "<span class='jd-red'>待发货</span>";
        else if(order.orderStatus == 2) statusText = "<span class='text-primary'>已发货</span>";
        else statusText = "<span class='text-secondary'>已完成</span>";
        html += `
            <div class="order-item">
                <div class="order-top">
                    <span>订单号：${order.orderNo}</span>
                    ${statusText}
                </div>
                <div class="order-body">
                    <div style="flex:1">
                        <p>收货地址：${order.receiveAddress}</p>
                        <p class="text-secondary">下单时间：${order.createTime}</p>
                    </div>
                    <div>
                        <p class="jd-red fs-5 fw-bold">¥${order.totalMoney}</p>
                    </div>
                </div>
            </div>`;
      })
      $("#orderBox").html(html);
    })
  }
</script>
</body>
</html>