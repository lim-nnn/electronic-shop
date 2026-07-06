<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="head.jsp" %>
<html>
<head>
  <style>
    .login-box {
      width: 420px;
      margin: 80px auto;
      background: #fff;
      padding: 40px;
      border-radius: 6px;
      box-shadow: 0 0 15px #eee;
    }
    .title {
      text-align: center;
      font-size: 24px;
      margin-bottom: 30px;
      color: #e1251b;
      font-weight: bold;
    }
    .item {
      margin-bottom: 18px;
    }
    .item label {
      display: block;
      margin-bottom: 6px;
    }
    .item input {
      width: 100%;
      height: 44px;
      border: 1px solid #ddd;
      padding: 0 12px;
      outline: none;
      border-radius: 4px;
    }
    .submit-btn {
      width: 100%;
      height: 46px;
      background: #e1251b;
      color: #fff;
      border: none;
      font-size: 16px;
      border-radius: 4px;
    }
    .tip {
      text-align: center;
      margin-top: 15px;
    }
    .tip a {
      color: #e1251b;
    }
  </style>
</head>
<body class="jd-gray-bg">
<div class="login-box">
  <div class="title">账号注册</div>
  <form id="regForm">
    <div class="item">
      <label>登录账号</label>
      <input type="text" name="account" placeholder="自定义账号" required>
    </div>
    <div class="item">
      <label>登录密码</label>
      <input type="password" name="password" placeholder="设置密码" required>
    </div>
    <div class="item">
      <label>昵称</label>
      <input type="text" name="nickName" placeholder="选填">
    </div>
    <div class="item">
      <label>手机号码</label>
      <input type="text" name="phone" placeholder="选填">
    </div>
    <div class="item">
      <label>收货地址</label>
      <input type="text" name="address" placeholder="选填">
    </div>
    <div class="item">
      <button type="submit" class="submit-btn">完成注册</button>
    </div>
    <div class="tip">已有账号？<a href="login.jsp">返回登录</a></div>
  </form>
</div>

<script>
  $("#regForm").submit(function (e) {
    e.preventDefault();
    let data = $(this).serialize();
    requestApi("/api/user/register", "POST", data, function (res) {
      if (res.code === 200) {
        alert(res.msg);
        location.href = "login.jsp";
      } else {
        alert(res.msg);
      }
    })
  })
</script>
</body>
</html>