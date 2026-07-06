<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
</head>
<body class="jd-gray-bg">
<div class="container-main d-flex mt-3 gap-3">
  <!-- 左侧分类 -->
  <div class="left-menu">
    <div class="menu-item"><i class="bi bi-phone"></i> <a href="goodsList.jsp?typeId=1">手机通讯</a></div>
    <div class="menu-item"><i class="bi bi-laptop"></i> <a href="goodsList.jsp?typeId=2">电脑平板</a></div>
    <div class="menu-item"><i class="bi bi-tv"></i> <a href="goodsList.jsp?typeId=3">服饰鞋包</a></div>
    <div class="menu-item"><i class="bi bi-book"></i> <a href="goodsList.jsp?typeId=4">图书文具</a></div>
    <div class="menu-item"><i class="bi bi-cup-hot"></i> <a href="goodsList.jsp?typeId=5">食品饮料</a></div>
  </div>
  <!-- 轮播 -->
  <div style="flex:1;height:360px;background:#fff;overflow:hidden">
    <div id="carouselExample" class="carousel slide h-100" data-bs-ride="carousel">
      <div class="carousel-inner h-100">
        <div class="carousel-item active h-100">
          <img src="https://picsum.photos/id/1039/1200/360" class="d-block w-100 h-100 object-fit-cover" alt="活动">
        </div>
      </div>
    </div>
  </div>
  <!-- 公告栏 -->
  <div style="width:260px;background:#fff;padding:15px;height:360px">
    <h5 class="border-bottom pb-2">商城公告</h5>
    <div class="mt-3">
      <p class="text-secondary fs-14">1. 全场满99包邮</p>
      <p class="text-secondary fs-14">2. 新用户注册领20元券</p>
    </div>
    <div class="mt-4 text-center">
      <% if(username == null){ %>
      <a href="login.jsp" class="jd-red-bg px-4 py-2 d-block">登录领券</a>
      <% }else{ %>
      <a href="cart.jsp" class="jd-red-bg px-4 py-2 d-block">去购物车</a>
      <% } %>
    </div>
  </div>
</div>

<!-- 爆款商品区域 -->
<div class="container-main mt-5">
  <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-4">
    <h4 class="jd-red"><i class="bi bi-fire"></i> 热卖商品</h4>
    <a href="goodsList.jsp">查看更多 <i class="bi bi-chevron-right"></i></a>
  </div>
  <div class="row g-4" id="goodsBox">
    <!-- AJAX填充商品 -->
  </div>
</div>

<footer>
  <div class="container-main">
    <p>电子商城 ©2026 仿京东购物平台 版权所有</p>
  </div>
</footer>
<script>
  window.onload = function(){
    requestApi("/api/goods/list","GET",{},function(res){
      let html = "";
      if(res.data.length === 0){
        html = "<div class='w-100 text-center py-5 fs-4'>暂无商品数据</div>";
      }else{
        res.data.forEach(item=>{
          // 第一层兜底：字段为空时使用默认图
          let imgSrc = item.coverImg || "https://picsum.photos/id/10/300/300";
          html += `
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="goods-card">
                        <img
                            src="${imgSrc}"
                            class="goods-img"
                            crossorigin="anonymous"
                            onerror="this.src='https://picsum.photos/id/10/300/300'"
                        >
                        <div class="goods-name">${item.goodsName}</div>
                        <div class="goods-price">¥${item.price}</div>
                        <div class="goods-shop">${item.typeName}</div>
                        <button class="jd-red-bg w-100 mt-2 border-0 py-1" onclick="addCart(${item.goodsId})">加入购物车</button>
                    </div>
                </div>`;
        })
      }
      $("#goodsBox").html(html);
    })
  }
  // 添加购物车
  function addCart(goodsId){
    if(!checkLogin()) return;
    requestApi("/api/cart/add","POST",{goodsId:goodsId,buyNum:1},function(res){
      if(res.code==200){
        alert("成功加入购物车");
      }else{
        alert(res.msg);
      }
    })
  }
</script>
</body>
</html>