package com.shop.electronicshop.controller;

import com.alibaba.fastjson2.JSON;
import com.shop.electronicshop.entity.Result;
import com.shop.electronicshop.util.DBUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import jakarta.annotation.Resource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@RestController
@RequestMapping("/api/user")
public class UserController {
    @Resource
    private DBUtil dbUtil;

    // 用户注册
    @PostMapping("/register")
    public Result<Object> register(@RequestParam String account,
                                   @RequestParam String pwd,
                                   @RequestParam String nickname) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = dbUtil.getConn();
            // 判断账号重复
            String checkSql = "select * from UserInfo where account=?";
            pstmt = conn.prepareStatement(checkSql);
            pstmt.setString(1, account);
            rs = pstmt.executeQuery();
            if(rs.next()){
                return Result.fail("账号已存在");
            }
            // 插入用户
            String insertSql = "insert into UserInfo(account,password,nickName) values(?,?,?)";
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, account);
            pstmt.setString(2, pwd);
            pstmt.setString(3, nickname);
            pstmt.executeUpdate();
            return Result.success(null);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.fail("注册失败："+e.getMessage());
        } finally {
            dbUtil.close(conn,pstmt,rs);
        }
    }

    // 用户登录
    @PostMapping("/login")
    public Result<Object> login(@RequestParam String account,
                                @RequestParam String pwd,
                                HttpSession session) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = dbUtil.getConn();
            String sql = "select * from UserInfo where account=? and password=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,account);
            pstmt.setString(2,pwd);
            rs = pstmt.executeQuery();
            if(rs.next()){
                String userType = "member";
                session.setAttribute("userType", userType);
                session.setAttribute("username", rs.getString("nickName"));
                return Result.success(JSON.parseObject("{\"userType\":\""+userType+"\",\"nickname\":\""+rs.getString("nickName")+"\"}"));
            }else{
                return Result.fail("账号或密码错误");
            }
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail("登录失败");
        }finally {
            dbUtil.close(conn,pstmt,rs);
        }
    }
}