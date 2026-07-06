package com.shop.electronicshop.controller;
import com.shop.electronicshop.entity.Result;
import com.shop.electronicshop.util.DBUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    @Resource
    DBUtil dbUtil;

    // 管理员登录
    @PostMapping("/login")
    public Result<Object> login(String account,String pwd,HttpSession session){
        try {
            List<Map<String,Object>> list = dbUtil.query("select * from Admin where adminAccount=? and adminPwd=?",account,pwd);
            if(list.isEmpty()) return Result.fail("管理员账号密码错误");
            session.setAttribute("userType","admin");
            session.setAttribute("adminName",list.get(0).get("adminName"));
            return Result.success(null);
        }catch (Exception e){
            return Result.fail("登录失败");
        }
    }

    // 获取全部普通用户
    @PostMapping("/user/all")
    public Result<List<Map<String,Object>>> allUser(){
        try {
            List<Map<String,Object>> list = dbUtil.query("select userId,account,nickName,phone,createTime,status from UserInfo");
            return Result.success(list);
        }catch (Exception e){
            return Result.fail("查询用户失败");
        }
    }

    // 获取全部商品
    @PostMapping("/goods/all")
    public Result<List<Map<String,Object>>> allGoods(){
        try {
            List<Map<String,Object>> list = dbUtil.query("select * from v_GoodsList");
            return Result.success(list);
        }catch (Exception e){
            return Result.fail("商品列表查询失败");
        }
    }

    // 删除用户
    @PostMapping("/user/del")
    public Result<Object> delUser(Integer userId){
        try {
            dbUtil.update("delete UserInfo where userId=?",userId);
            return Result.success(null);
        }catch (Exception e){
            return Result.fail("删除失败，存在关联订单/购物车数据");
        }
    }
}