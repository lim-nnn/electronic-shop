<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
  <style>
    .filter-bar{background:#fff;padding:15px;margin:15px 0}
    .filter-item{display:inline-block;margin:0 10px}
    .filter-item a{padding:4px 12px;border:1px solid #eee}
    .filter-item a.active{background:#e1251b;color:#fff;border-color:#e1251b}
  </style>
</head>
<body class="jd-gray-bg">
<!-- 公共头部导航已引入head.jsp -->
<div class="container-main">
  <!-- 筛选栏 -->
  <div class="filter-bar">
    <div class="filter-item"><a href="#" class="active">全部</a></div>
    <div class="filter-item"><a href="#">手机</a></div>
    <div class="filter-item"><a href="#">电脑</a></div>
    <div class="filter-item"><a href="#">家电</a></div>
    <div class="filter-item"><a href="#">耳机</a></div>
    <div class="float-end">
      <select class="form-select d-inline w-auto">
        <option>综合排序</option>
        <option>价格从低到高</option>
        <option>价格从高到低</option>
        <option>销量优先</option>
      </select>
    </div>
  </div>

  <!-- 商品网格 -->
  <div class="row g-4 mt-3">
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img14.360buyimg.com/n1/jfs/t1/189677/36/27018/41669/645c3241F86260661/0d64220090644002.jpg" class="goods-img">
        <div class="goods-name">2025新款旗舰智能手机 超长续航高清拍照全网通5G手机</div>
        <div class="goods-price">¥ 1999.00</div>
        <div class="goods-shop">官方自营旗舰店</div>
        <button class="jd-red-bg w-100 mt-2 border-0 py-1">加入购物车</button>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img10.360buyimg.com/n1/jfs/t1/192300/10/26789/37766/645c3320F7d0d2292/8920d22002d22099.jpg" class="goods-img">
        <div class="goods-name">超薄笔记本电脑 16G大内存学生办公轻薄本</div>
        <div class="goods-price">¥ 3299.00</div>
        <div class="goods-shop">数码官方旗舰店</div>
        <button class="jd-red-bg w-100 mt-2 border-0 py-1">加入购物车</button>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img12.360buyimg.com/n1/jfs/t1/184664/12/27477/54663/645c3390F0d9d2900/0d9d40432d0d2299.jpg" class="goods-img">
        <div class="goods-name">家用变频空调 一级能效静音省电冷暖挂机</div>
        <div class="goods-price">¥ 2499.00</div>
        <div class="goods-shop">家电自营店</div>
        <button class="jd-red-bg w-100 mt-2 border-0 py-1">加入购物车</button>
      </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6">
      <div class="goods-card">
        <img src="https://img14.360buyimg.com/n1/jfs/t1/186322/32/27301/46669/645c3420F2d0d2299/9d2929040d9d4043.jpg" class="goods-img">
        <div class="goods-name">无线蓝牙耳机 主动降噪超长续航运动入耳式耳机</div>
        <div class="goods-price">¥ 299.00</div>
        <div class="goods-shop">音频数码专营店</div>
        <button class="jd-red-bg w-100 mt-2 border-0 py-1">加入购物车</button>
      </div>
    </div>
  </div>
</div>

<footer class="mt-5">
  <div class="container-main">
    <p>电子商城 ©2026 仿京东购物平台 版权所有</p>
  </div>
</footer>
</body>
</html>