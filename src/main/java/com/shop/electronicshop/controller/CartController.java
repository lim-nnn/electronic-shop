package com.shop.electronicshop.controller;
import com.shop.electronicshop.entity.Result;
import com.shop.electronicshop.util.DBUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/cart")
public class CartController {
    @Resource
    DBUtil dbUtil;

    // 添加购物车
    @PostMapping("/add")
    public Result<Object> addCart(HttpSession session, @RequestParam Integer goodsId,@RequestParam Integer buyNum){
        Integer userId = (Integer) session.getAttribute("userId");
        if(userId == null) return Result.fail("请先登录");
        try {
            // 调用存储过程 sp_AddCart
            String sql = "exec sp_AddCart ?,?";
            dbUtil.update(sql,userId,goodsId,buyNum);
            return Result.success(null);
        }catch (Exception e){
            return Result.fail(e.getMessage());
        }
    }

    // 获取当前用户购物车
    @PostMapping("/my")
    public Result<List<Map<String,Object>>> myCart(HttpSession session){
        Integer userId = (Integer) session.getAttribute("userId");
        if(userId == null) return Result.fail("请登录");
        try {
            List<Map<String,Object>> list = dbUtil.query("select * from v_CartDetail where userId=?",userId);
            return Result.success(list);
        }catch (Exception e){
            return Result.fail("加载购物车失败");
        }
    }

    // 删除购物车商品
    @PostMapping("/del")
    public Result<Object> delCart(HttpSession session,Integer cartId){
        Integer userId = (Integer) session.getAttribute("userId");
        try {
            dbUtil.update("exec sp_DeleteCart ?,?",cartId,userId);
            return Result.success(null);
        }catch (Exception e){
            return Result.fail("删除失败");
        }
    }
}