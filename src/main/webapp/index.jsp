<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
</head>
<body class="jd-gray-bg">
<div class="container-main d-flex mt-3 gap-3">
  <!-- 左侧商品分类侧边栏 -->
  <div class="left-menu">
    <div class="menu-item"><i class="bi bi-phone"></i> 手机通讯</div>
    <div class="menu-item"><i class="bi bi-laptop"></i> 电脑平板</div>
    <div class="menu-item"><i class="bi bi-tv"></i> 大家电</div>
    <div class="menu-item"><i class="bi bi-headphones"></i> 数码配件</div>
    <div class="menu-item"><i class="bi bi-watch"></i> 智能手表</div>
    <div class="menu-item"><i class="bi bi-camera"></i> 相机影像</div>
    <div class="menu-item"><i class="bi bi-printer"></i> 办公设备</div>
    <div class="menu-item"><i class="bi bi-gamepad"></i> 游戏设备</div>
  </div>
  <!-- 中间轮播广告 -->
  <div style="flex:1;height:360px;background:#fff;overflow:hidden">
    <div id="carouselExample" class="carousel slide h-100" data-bs-ride="carousel">
      <div class="carousel-inner h-100">
        <div class="carousel-item active h-100">
          <img src="https://img14.360buyimg.com/imagetools/jfs/t1/208324/33/25669/108423/647d2251F3200f390/9d2929040d9d4043.jpg" class="d-block w-100 h-100 object-fit-cover" alt="活动1">
        </div>
        <div class="carousel-item h-100">
          <img src="https://img12.360buyimg.com/imagetools/jfs/t1/196560/20/26433/112637/642f8d77F16f0d891/2d409924900088d2.jpg" class="d-block w-100 h-100 object-fit-cover" alt="活动2">
        </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
      </button>
    </div>
  </div>
  <!-- 右侧公告小栏 -->
  <div style="width:260px;background:#fff;padding:15px;height:360px">
    <h5 class="border-bottom pb-2">商城公告</h5>
    <div class="mt-3">
      <p class="text-secondary fs-14">1. 全场满99包邮</p>
      <p class="text-secondary fs-14">2. 新用户注册领20元券</p>
      <p class="text-secondary fs-14">3. 每日限时秒杀晚8点开抢</p>
    </div>
    <div class="mt-4 text-center">
      <% if(username == null){ %>
      <a href="login.jsp" class="jd-red-bg px-4 py-2 d-block">立即登录领券</a>
      <% }else{ %>
      <a href="cart.jsp" class="jd-red-bg px-4 py-2 d-block">去购物车结算</a>
      <% } %>
    </div>
  </div>
</div>

<!-- 爆款商品推荐区域 -->
<div class="container-main mt-5">
  <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-4">
    <h4 class="jd-red"><i class="bi bi-fire"></i> 爆款热卖</h4>
    <a href="goodsList.jsp">查看更多 <i class="bi bi-chevron-right"></i></a>
  </div>
  <div class="row g-4">
    <!-- 商品卡片循环模板 -->
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img14.360buyimg.com/n1/jfs/t1/189677/36/27018/41669/645c3241F86260661/0d64220090644002.jpg" class="goods-img">
        <div class="goods-name">2025新款旗舰智能手机 超长续航高清拍照全网通5G手机</div>
        <div class="goods-price">¥ 1999.00</div>
        <div class="goods-shop">官方自营旗舰店</div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img10.360buyimg.com/n1/jfs/t1/192300/10/26789/37766/645c3320F7d0d2292/8920d22002d22099.jpg" class="goods-img">
        <div class="goods-name">超薄笔记本电脑 16G大内存学生办公轻薄本</div>
        <div class="goods-price">¥ 3299.00</div>
        <div class="goods-shop">数码官方旗舰店</div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img12.360buyimg.com/n1/jfs/t1/184664/12/27477/54663/645c3390F0d9d2900/0d9d40432d0d2299.jpg" class="goods-img">
        <div class="goods-name">家用变频空调 一级能效静音省电冷暖挂机</div>
        <div class="goods-price">¥ 2499.00</div>
        <div class="goods-shop">家电自营店</div>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img14.360buyimg.com/n1/jfs/t1/186322/32/27301/46669/645c3420F2d0d2299/9d2929040d9d4043.jpg" class="goods-img">
        <div class="goods-name">无线蓝牙耳机 主动降噪超长续航运动入耳式耳机</div>
        <div class="goods-price">¥ 299.00</div>
        <div class="goods-shop">音频数码专营店</div>
      </div>
    </div>
  </div>
</div>

<!-- 页脚 -->
<footer>
  <div class="container-main">
    <p>电子商城 ©2026 版权所有</p>
    <p>客服热线：400-123-4567 | 隐私协议 | 用户服务条款</p>
  </div>
</footer>
</body>
</html>