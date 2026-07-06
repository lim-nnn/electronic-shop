package com.shop.electronicshop.controller;

import com.shop.electronicshop.entity.Result;
import com.shop.electronicshop.util.DBUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Resource
    private DBUtil dbUtil;

    // 登录接口
    @PostMapping("/login")
    public Result login(
            @RequestParam String account,
            @RequestParam String password,
            @RequestParam String captcha,
            HttpServletRequest request,
            HttpSession session
    ) throws SQLException { // 声明SQL异常
        // 1 校验验证码
        String realCode = (String) session.getAttribute(CaptchaController.SESSION_CAPTCHA_KEY);
        if (realCode == null || !realCode.equalsIgnoreCase(captcha)) {
            return Result.fail("图形验证码错误，请刷新图片重新输入");
        }
        // 修复：remove → removeAttribute
        session.removeAttribute(CaptchaController.SESSION_CAPTCHA_KEY);

        // 2 校验账号密码
        List<Map<String, Object>> userList = dbUtil.query(
                "select * from UserInfo where account=? and password=? and status=1",
                account, password
        );
        if (userList.isEmpty()) {
            return Result.fail("账号或密码错误");
        }
        // 修复：变量是userList，取第一条
        Map<String, Object> user = userList.get(0);
        // 存入session登录信息
        session.setAttribute("userId", user.get("userId"));
        session.setAttribute("username", user.get("nickName"));
        session.setAttribute("userType", "user");
        return Result.success("登录成功");
    }

    // 注册接口
    @PostMapping("/register")
    public Result register(
            @RequestParam String account,
            @RequestParam String password,
            @RequestParam(required = false) String nickName,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String address
    ) throws SQLException { // 声明SQL异常
        // 判断账号是否已存在
        List<Map<String, Object>> exist = dbUtil.query("select 1 from UserInfo where account=?", account);
        if (!exist.isEmpty()) {
            return Result.fail("该账号已被注册");
        }
        // 插入用户
        int rows = dbUtil.update(
                "insert into UserInfo(account,password,nickName,phone,address) values (?,?,?,?,?)",
                account, password, nickName, phone, address
        );
        if (rows > 0) {
            return Result.success("注册成功，请前往登录");
        } else {
            return Result.fail("注册失败，请重试");
        }
    }

    // 退出登录
    @PostMapping("/logout")
    public Result logout(HttpSession session) {
        session.invalidate();
        return Result.success("退出成功");
    }
}