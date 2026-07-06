<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
</head>
<body class="jd-gray-bg">
<div class="container-main bg-white p-4 mt-4">
  <h4 class="border-bottom pb-3 mb-4"><i class="bi bi-cart4 jd-red"></i> 我的购物车</h4>
  <table class="table text-center" id="cartTable">
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
    <tbody></tbody>
  </table>
  <div class="d-flex justify-content-between align-items-center mt-4 border-top pt-4">
    <div><input type="checkbox" id="allCheck"> 全选</div>
    <div class="d-flex align-items-center gap-4">
      <span>合计：<span class="jd-red fs-3 fw-bold" id="totalPrice">¥0.00</span></span>
      <button class="jd-red-bg border-0 px-5 py-2 fs-5" onclick="goOrder()">去结算</button>
    </div>
  </div>
</div>
<footer>
  <div class="container-main">
    <p>电子商城 ©2026</p>
  </div>
  <script>
    let cartData = [];
    window.onload = function(){
      if(!checkLogin()) return;
      requestApi("/api/cart/my","POST",{},function(res){
        cartData = res.data;
        let html = "";
        let total = 0;
        if(cartData.length === 0){
          html = "<tr><td colspan='6' class='py-5 fs-4'>购物车暂无商品</td>";
        }else{
          res.data.forEach(item=>{
            total += Number(item.subtotal);
            let imgSrc = item.coverImg || "https://picsum.photos/id/10/300/300";
            html += `
                <tr data-cartid="${item.cartId}" data-goodsid="${item.goodsId}">
                    <td><input type="checkbox" class="cartCheck" data-sub="${item.subtotal}"></td>
                    <td class="d-flex gap-3 align-items-center">
                        <img
                            src="${imgSrc}"
                            width="80"
                            crossorigin="anonymous"
                            onerror="this.src='https://picsum.photos/id/10/300/300'"
                        >
                        <div>${item.goodsName}</div>
                    </td>
                    <td class="jd-red fw-bold">¥${item.price}</td>
                    <td>
                        <button class="border px-2 minus">-</button>
                        <input value="${item.buyNum}" style="width:40px;text-align:center;border:1px solid #ddd;margin:0 4px" class="numInput">
                        <button class="border px-2 plus">+</button>
                    </td>
                    <td class="jd-red fw-bold subtotal">¥${item.subtotal}</td>
                    <td><a href="javascript:delCart(${item.cartId})" class="text-danger">删除</a></td>
                </tr>`;
          })
        }
        $("#cartTable tbody").html(html);
        $("#totalPrice").text("¥"+total.toFixed(2));
      })
    }
    // 删除购物车
    function delCart(cartId){
      if(!confirm("确认删除？")) return;
      requestApi("/api/cart/del","POST",{cartId:cartId},res=>{
        location.reload();
      })
    }
    // 结算下单
    function goOrder(){
      let address = prompt("请输入收货地址");
      if(!address) return;
      requestApi("/api/order/create","POST",{address:address},res=>{
        if(res.code==200){
          alert("下单成功，订单号："+res.data);
          location.href="orderList.jsp";
        }else{
          alert(res.msg);
        }
      })
    }
  </script>
</body>
</html>