<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userType = (String) session.getAttribute("userType");
    String username = (String) session.getAttribute("username");
    Integer userId = (Integer) session.getAttribute("userId");
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%-- 替换为国内稳定CDN，解决境外地址无法访问 --%>
<link href="https://cdn.bootcdn.net/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<title>电子商城 - 仿京东购物平台</title>
<style>
    *{margin:0;padding:0;box-sizing:border-box}
    a{text-decoration:none;color:#333}
    a:hover{color:#e1251b}
    .jd-red{color:#e1251b}
    .jd-red-bg{background:#e1251b;color:#fff;border:0}
    .jd-gray-bg{background:#f4f4f4}
    .container-main{width:1300px;margin:0 auto}
    .top-nav{height:30px;background:#f3f3f3;font-size:13px;line-height:30px}
    .top-nav a{margin:0 8px;color:#666}
    .header-bar{height:100px;display:flex;align-items:center;justify-content:space-between;padding:0 10px}
    .logo{font-size:32px;font-weight:bold;color:#e1251b}
    .search-box{display:flex;width:520px;height:36px}
    .search-input{flex:1;border:2px solid #e1251b;padding:0 12px;outline:none}
    .search-btn{width:80px;border:none;background:#e1251b;color:#fff;font-weight:bold}
    .cart-icon{font-size:22px;margin-left:20px}
    .category-bar{height:40px;background:#e1251b;display:flex;align-items:center}
    .all-category{width:220px;height:40px;background:#c81623;display:flex;align-items:center;justify-content:center;color:#fff;font-weight:bold}
    .category-item{padding:0 22px;color:#fff}
    .category-item:hover{background:#c81623}
    .left-menu{width:220px;background:#fff;padding:10px 0}
    .menu-item{height:34px;line-height:34px;padding-left:20px;font-size:14px}
    .menu-item:hover{background:#f4f4f4;color:#e1251b}

    /* 合并你提供的商品卡片全部样式 */
    .goods-img{
        width:100%;
        height:220px;
        object-fit:cover;
        display:block;
    }
    .goods-card{
        border:1px solid #eee;
        padding:10px;
        transition:0.3s;
    }
    .goods-card:hover{
        box-shadow:0 0 12px #ddd;
    }
    .goods-name{
        font-size:14px;
        height:40px;
        overflow:hidden;
        text-overflow:ellipsis;
        display:-webkit-box;
        -webkit-line-clamp:2;
        -webkit-box-orient:vertical;
    }
    .goods-price{
        font-size:18px;
        color:#e1251b;
        font-weight:bold;
        margin:6px 0;
    }
    .goods-shop{
        font-size:12px;
        color:#999;
    }
    /* 新增商品描述样式，用于展示goodsDesc */
    .goods-desc{
        font-size:12px;
        color:#666;
        height:36px;
        overflow:hidden;
        text-overflow:ellipsis;
        display:-webkit-box;
        -webkit-line-clamp:2;
        -webkit-box-orient:vertical;
        margin:4px 0;
    }
    .filter-item{
        display:inline-block;
        margin:0 10px;
    }
    .filter-item a{
        padding:4px 12px;
        border:1px solid #eee;
    }
    .filter-item a.active{
        background:#e1251b;
        color:#fff;
        border-color:#e1251b;
    }

    footer{margin-top:50px;padding:40px 0;background:#f4f4f4;text-align:center;color:#666;font-size:14px}
    .order-item{background:#fff;margin:15px 0}
    .order-top{padding:12px 20px;border-bottom:1px #eee solid;display:flex;justify-content:space-between}
    .order-body{padding:15px 20px;display:flex;align-items:center;gap:20px}
    .order-img{width:100px;height:100px;object-fit:cover}
    .admin-wrap{display:flex}
    .admin-left{width:200px;background:#222;color:#fff;min-height:600px;padding-top:30px}
    .admin-left a{display:block;color:#ccc;padding:14px 30px}
    .admin-left a:hover{background:#e1251b;color:#fff}
    .admin-right{flex:1;padding:30px}
    .login-box{width:380px;background:#fff;padding:35px;border-radius:4px;box-shadow:0 0 15px #eee;margin:80px auto}
    .input-item{margin-bottom:20px}
    .input-item input{width:100%;height:44px;border:1px solid #ddd;padding:0 14px;outline:none}
    .input-item input:focus{border-color:#e1251b}
</style>
<script>
    // 全局AJAX工具
    function requestApi(url,method,data,callback){
        $.ajax({
            url:url,
            type:method,
            data:data,
            dataType:"json",
            success:function(res){callback(res)},
            error:function(){alert("网络请求失败，请检查数据库连接")}
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
    // 未登录拦截跳转
    function checkLogin(){
        <% if(userId == null) { %>
        alert("请先登录");
        location.href="login.jsp";
        return false;
        <% } %>
        return true;
    }
</script>
<!-- 顶部导航 -->
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
<!-- Logo搜索栏 -->
<div class="container-main header-bar">
    <div class="logo">E-SHOP商城</div>
    <div class="search-box">
        <input class="search-input" placeholder="搜索手机、电脑、家电..." id="searchKey">
        <button class="search-btn" onclick="searchGoods()">搜索</button>
    </div>
    <div class="cart-icon"><a href="cart.jsp"><i class="bi bi-cart4"></i> 购物车</a></div>
</div>
<!-- 分类导航 -->
<div class="category-bar">
    <div class="all-category"><i class="bi bi-list"></i> 全部商品分类</div>
    <a href="goodsList.jsp?typeId=1" class="category-item">手机数码</a>
    <a href="goodsList.jsp?typeId=2" class="category-item">电脑办公</a>
    <a href="goodsList.jsp?typeId=3" class="category-item">服饰鞋包</a>
    <a href="goodsList.jsp?typeId=4" class="category-item">图书文具</a>
    <a href="goodsList.jsp?typeId=5" class="category-item">食品饮料</a>
    <a href="goodsList.jsp" class="category-item">全部商品</a>
</div>
<script>
    // 搜索商品
    function searchGoods(){
        let key = $("#searchKey").val();
        location.href="goodsList.jsp?key="+key;
    }
</script>