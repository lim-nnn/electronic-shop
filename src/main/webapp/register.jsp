<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <%@ include file="head.jsp" %>
  <style>
    .reg-box{width:380px;background:#fff;padding:35px;border-radius:4px;box-shadow:0 0 15px #eee;margin:80px auto}
    .reg-title{text-align:center;font-size:24px;margin-bottom:30px;color:#e1251b}
    .input-item{margin-bottom:20px}
    .input-item input{width:100%;height:44px;border:1px solid #ddd;padding:0 14px;outline:none}
    .input-item input:focus{border-color:#e1251b}
    .reg-btn{width:100%;height:46px;border:none;background:#e1251b;color:#fff;font-size:16px;font-weight:bold}
    .tip-text{text-align:center;margin-top:20px;color:#666}
    .tip-text a{color:#e1251b}
  </style>
</head>
<body class="jd-gray-bg">
<div class="reg-box">
  <h2 class="reg-title">新用户注册</h2>
  <div id="errorTip" class="text-danger text-center mb-3"></div>
  <form id="regForm">
    <div class="input-item">
      <input type="text" name="account" placeholder="设置登录账号" required>
    </div>
    <div class="input-item">
      <input type="password" name="pwd" placeholder="设置登录密码" required>
    </div>
    <div class="input-item">
      <input type="text" name="nickname" placeholder="设置昵称" required>
    </div>
    <button class="reg-btn" type="submit">完成注册</button>
  </form>
  <div class="tip-text">
    已有账号？<a href="login.jsp">去登录</a>
  </div>
</div>
<script>
  $("#regForm").submit(function(e){
    e.preventDefault();
    let data = {
      account:this.account.value,
      pwd:this.pwd.value,
      nickname:this.nickname.value
    }
    requestApi("/api/user/register","POST",data,function(res){
      if(res.code == 200){
        alert("注册成功，请登录");
        location.href="login.jsp"
      }else{
        $("#errorTip").text(res.msg)
      }
    })
  })
</script>
</body>
</html>