<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
  <style>
    .login-box{width:380px;background:#fff;padding:35px;border-radius:4px;box-shadow:0 0 15px #eee;margin:80px auto}
    .login-title{text-align:center;font-size:24px;margin-bottom:30px;color:#e1251b}
    .input-item{margin-bottom:20px}
    .input-item input{width:100%;height:44px;border:1px solid #ddd;padding:0 14px;outline:none}
    .input-item input:focus{border-color:#e1251b}
    .login-btn{width:100%;height:46px;border:none;background:#e1251b;color:#fff;font-size:16px;font-weight:bold}
    .tip-text{text-align:center;margin-top:20px;color:#666}
    .tip-text a{color:#e1251b}
  </style>
</head>
<body class="jd-gray-bg">
<div class="login-box">
  <h2 class="login-title">商城账号登录</h2>
  <div id="errorTip" class="text-danger text-center mb-3"></div>
  <form id="loginForm">
    <div class="input-item">
      <input type="text" name="account" placeholder="请输入账号" required>
    </div>
    <div class="input-item">
      <input type="password" name="pwd" placeholder="请输入密码" required>
    </div>
    <button class="login-btn" type="submit">登录</button>
  </form>
  <div class="tip-text">
    没有账号？<a href="register.jsp">立即注册</a>
  </div>
</div>
<script>
  $("#loginForm").submit(function(e){
    e.preventDefault();
    let data = {
      account:this.account.value,
      pwd:this.pwd.value
    }
    requestApi("/api/user/login","POST",data,function(res){
      if(res.code == 200){
        alert("登录成功！");
        location.href="index.jsp"
      }else{
        $("#errorTip").text(res.msg)
      }
    })
  })
</script>
</body>
</html>