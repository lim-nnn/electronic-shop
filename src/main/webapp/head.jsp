<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userType = (String) session.getAttribute("userType");
    String username = (String) session.getAttribute("username");
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<title>E-SHOP商城 -</title>
<style>
    /* 全局重置 仿京东配色 */
    *{margin:0;padding:0;box-sizing:border-box}
    a{text-decoration:none;color:#333}
    a:hover{color:#e1251b}
    .jd-red{color:#e1251b}
    .jd-red-bg{background:#e1251b;color:#fff}
    .jd-gray-bg{background:#f4f4f4}
    .container-main{width:1300px;margin:0 auto}

    /* 顶部导航栏 */
    .top-nav{height:30px;background:#f3f3f3;font-size:13px;line-height:30px}
    .top-nav a{margin:0 8px;color:#666}
    .top-nav a:hover{color:#e1251b}

    /* 头部搜索栏 */
    .header-bar{height:100px;display:flex;align-items:center;justify-content:space-between;padding:0 10px}
    .logo{font-size:32px;font-weight:bold;color:#e1251b}
    .search-box{display:flex;width:520px;height:36px}
    .search-input{flex:1;border:2px solid #e1251b;padding:0 12px;outline:none}
    .search-btn{width:80px;border:none;background:#e1251b;color:#fff;font-weight:bold}
    .cart-icon{font-size:22px;margin-left:20px}

    /* 分类导航 */
    .category-bar{height:40px;background:#e1251b;display:flex;align-items:center}
    .all-category{width:220px;height:40px;background:#c81623;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:bold}
    .category-item{padding:0 22px;color:#fff}
    .category-item:hover{background:#c81623}

    /* 侧边商品分类 */
    .left-menu{width:220px;background:#fff;padding:10px 0}
    .menu-item{height:34px;line-height:34px;padding-left:20px;font-size:14px}
    .menu-item:hover{background:#f4f4f4;color:#e1251b}

    /* 商品卡片 */
    .goods-card{border:1px solid #eee;padding:10px;transition:0.3s}
    .goods-card:hover{box-shadow:0 0 12px #ddd}
    .goods-img{width:100%;height:220px;object-fit:cover;margin-bottom:8px}
    .goods-name{font-size:14px;height:40px;overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical}
    .goods-price{font-size:18px;color:#e1251b;font-weight:bold;margin:6px 0}
    .goods-shop{font-size:12px;color:#999}

    /* 底部页脚 */
    footer{margin-top:50px;padding:40px 0;background:#f4f4f4;text-align:center;color:#666;font-size:14px}
</style>
<script>
    // 全局AJAX请求工具（适配你后端api）
    function requestApi(url,method,data,callback){
        $.ajax({
            url:url,
            type:method,
            data:data,
            dataType:"json",
            success:function(res){callback(res)},
            error:function(){alert("网络请求失败，请刷新重试")}
        })
    }
    // 退出登录
    function logout(){
        if(confirm("确定退出登录？")){
            requestApi("/api/user/logout","POST",{},function(res){
                location.href="index.jsp"
            })
        }
    }
</script>
<!-- 顶部公共导航 -->
<div class="top-nav">
    <div class="container-main d-flex justify-content-between">
        <div>欢迎来到电子商城！</div>
        <div>
            <% if(username == null){ %>
            <a href="login.jsp">请登录</a>
            <a href="register.jsp">免费注册</a>
            <% }else{ %>
            <span class="jd-red">Hi, <%=username%></span>
            <a href="cart.jsp"><i class="bi bi-cart"></i> 我的购物车</a>
            <a href="orderList.jsp">我的订单</a>
            <a href="javascript:logout()">退出登录</a>
            <% } %>
            <% if("admin".equals(userType)){ %>
            <a href="admin/goodsManage.jsp">商家后台管理</a>
            <% } %>
        </div>
    </div>
</div>
<!-- Logo+搜索栏 -->
<div class="container-main header-bar">
    <div class="logo">E-SHOP商城</div>
    <div class="search-box">
        <input class="search-input" placeholder="搜索手机、电脑、家电...">
        <button class="search-btn">搜索</button>
    </div>
    <div class="cart-icon"><a href="cart.jsp"><i class="bi bi-cart4"></i> 购物车</a></div>
</div>
<!-- 红色分类导航栏 -->
<div class="category-bar">
    <div class="all-category"><i class="bi bi-list"></i> 全部商品分类</div>
    <a href="goodsList.jsp" class="category-item">手机数码</a>
    <a href="goodsList.jsp" class="category-item">电脑办公</a>
    <a href="goodsList.jsp" class="category-item">家用电器</a>
    <a href="goodsList.jsp" class="category-item">服饰鞋包</a>
    <a href="goodsList.jsp" class="category-item">美妆护肤</a>
    <a href="goodsList.jsp" class="category-item">生鲜食品</a>
</div>