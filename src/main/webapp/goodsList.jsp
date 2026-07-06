<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
</head>
<body class="jd-gray-bg">
<div class="container-main">
  <!-- 删掉下方重复的filter-bar分类栏，只使用head.jsp顶部红色分类导航 -->
  <div class="row g-4 mt-3" id="goodsWrap">
  </div>
</div>

<footer class="mt-5">
  <div class="container-main">
    <p>E-SHOP商城 ©2026</p>
  </div>
</footer>

<script>
  window.onload = function(){
    let urlParams = new URLSearchParams(location.search);
    let typeId = urlParams.get("typeId");
    let key = urlParams.get("key");
    let param = {};
    if(typeId){
      param.typeId = typeId;
    }

    requestApi("/api/goods/list","GET",param,function(res){
      let html = "";
      let goodsArr = res.data;
      if(key){
        goodsArr = res.data.filter(function(item){
          return item.goodsName.indexOf(key) > -1;
        });
      }

      if(goodsArr.length === 0){
        html = "<div class='w-100 text-center py-5 fs-4'>暂无该分类商品</div>";
      }else{
        goodsArr.forEach(function(item){
          let imgSrc = item.coverImg || "https://picsum.photos/id/10/300/300";
          html +=
                  '<div class="col-lg-3 col-md-4 col-sm-6">'+
                  '<div class="goods-card">'+
                  '<img src="'+imgSrc+'" class="goods-img" crossorigin="anonymous" onerror="this.src=\'https://picsum.photos/id/10/300/300\'">'+
                  '<div class="goods-name">'+item.goodsName+'</div>'+
                  '<div class="goods-desc">'+item.goodsDesc+'</div>'+
                  '<div class="goods-price">¥'+item.price+'</div>'+
                  '<div class="goods-shop">'+item.typeName+'</div>'+
                  '<button class="jd-red-bg w-100 mt-2 border-0 py-1" onclick="addCart('+item.goodsId+')">加入购物车</button>'+
                  '</div>'+
                  '</div>';
        });
      }
      $("#goodsWrap").html(html);
    });
  }

  function addCart(goodsId){
    if(!checkLogin()) return;
    requestApi("/api/cart/add","POST",{goodsId:goodsId,buyNum:1},function(res){
      if(res.code === 200){
        alert("商品成功加入购物车！");
      }else{
        alert(res.msg);
      }
    });
  }
</script>
</body>
</html>