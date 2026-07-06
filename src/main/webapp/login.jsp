<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="head.jsp" %>
<html>
<head>
  <style>
    .login-box {
      width: 420px;
      margin: 100px auto;
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
      margin-bottom: 20px;
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
    .code-row {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    .code-input {
      flex: 1;
    }
    .code-img {
      height: 44px;
      cursor: pointer;
      border: 1px solid #ddd;
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
  <div class="title">用户登录</div>
  <form id="loginForm">
    <div class="item">
      <label>账号</label>
      <input type="text" name="account" placeholder="请输入账号" required>
    </div>
    <div class="item">
      <label>密码</label>
      <input type="password" name="password" placeholder="请输入密码" required>
    </div>
    <div class="item code-row">
      <div class="code-input">
        <label>图形验证码</label>
        <input type="text" name="captcha" maxlength="4" placeholder="4位验证码" required>
      </div>
      <!-- 验证码图片，点击刷新 -->
      <img class="code-img" id="captchaImg" src="/captcha/img">
    </div>
    <div class="item">
      <button type="submit" class="submit-btn">登录</button>
    </div>
    <div class="tip">没有账号？<a href="register.jsp">立即注册</a></div>
  </form>
</div>

<script>
  // 点击刷新验证码
  $("#captchaImg").click(function () {
    // 加时间戳防止浏览器缓存
    $(this).attr("src", "/captcha/img?t=" + new Date().getTime());
  })

  // 表单提交登录
  $("#loginForm").submit(function (e) {
    e.preventDefault();
    let data = $(this).serialize();
    requestApi("/api/user/login", "POST", data, function (res) {
      if (res.code === 200) {
        alert(res.msg);
        location.href = "index.jsp";
      } else {
        alert(res.msg);
        // 登录失败刷新验证码
        $("#captchaImg").attr("src", "/captcha/img?t=" + new Date().getTime());
      }
    })
  })
</script>
</body>
</html>