package com.shop.electronicshop.controller;

import com.shop.electronicshop.entity.Result;
import com.shop.electronicshop.util.DBUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/order")
public class OrderController {
    @Resource
    private DBUtil dbUtil;

    /**
     * 创建订单
     * @param goodsId 商品id
     * @param num 购买数量
     * @param session 登录用户session
     * @return 订单信息
     */
    @PostMapping("/create")
    public Result createOrder(
            @RequestParam Integer goodsId,
            @RequestParam Integer num,
            HttpSession session
    ) throws SQLException {
        // 1. 判断是否登录
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return Result.fail("请先登录后再下单");
        }
        Integer userId = (Integer) userIdObj;

        // 2. 查询商品信息
        List<Map<String, Object>> goodsList = dbUtil.query("select * from Goods where goodsId=?", goodsId);
        if (goodsList.isEmpty()) {
            return Result.fail("商品不存在");
        }
        Map<String, Object> goods = goodsList.get(0);
        Double price = Double.valueOf(goods.get("price").toString());
        Double totalMoney = price * num;

        // 3. 生成唯一订单号
        String orderNo = UUID.randomUUID().toString().replace("-", "").substring(0, 20);

        // 4. 插入主订单
        String insertOrderSql = "insert into Orders(orderNo,userId,totalMoney,status,createTime) values (?,?,?,1,GETDATE())";
        dbUtil.update(insertOrderSql, orderNo, userId, totalMoney);

        // 5. 插入订单项
        String insertItemSql = "insert into OrderItem(orderNo,goodsId,num,price) values (?,?,?,?)";
        dbUtil.update(insertItemSql, orderNo, goodsId, num, price);

        // 6. 返回订单号给前端
        return Result.success("下单成功", orderNo);
    }

    /**
     * 查询当前登录用户所有订单（含商品信息）
     */
    @GetMapping("/my")
    public Result<List<Map<String, Object>>> getMyOrder(HttpSession session) throws SQLException {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return Result.fail("请先登录");
        }
        Integer userId = (Integer) userIdObj;

        // 联表查询订单+商品
        String sql = """
                select o.*, g.goodsName, g.coverImg, g.price, i.num
                from Orders o
                left join OrderItem i on o.orderNo = i.orderNo
                left join Goods g on i.goodsId = g.goodsId
                where o.userId = ?
                order by o.createTime desc
                """;
        List<Map<String, Object>> orderList = dbUtil.query(sql, userId);
        return Result.success(orderList);
    }

    /**
     * 根据订单号查询订单详情
     */
    @GetMapping("/detail")
    public Result<Map<String, Object>> getOrderDetail(
            @RequestParam String orderNo,
            HttpSession session
    ) throws SQLException {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return Result.fail("请先登录");
        }
        Integer userId = (Integer) userIdObj;

        String sql = """
                select o.*, g.goodsName, g.coverImg, g.price, i.num
                from Orders o
                left join OrderItem i on o.orderNo = i.orderNo
                left join Goods g on i.goodsId = g.goodsId
                where o.orderNo = ? and o.userId = ?
                """;
        List<Map<String, Object>> list = dbUtil.query(sql, orderNo, userId);
        if (list.isEmpty()) {
            return Result.fail("订单不存在或不属于当前用户");
        }
        return Result.success(list.get(0));
    }

    /**
     * 取消订单（仅未付款订单可取消）
     */
    @PostMapping("/cancel")
    public Result cancelOrder(
            @RequestParam String orderNo,
            HttpSession session
    ) throws SQLException {
        Object userIdObj = session.getAttribute("userId");
        if (userIdObj == null) {
            return Result.fail("请先登录");
        }
        Integer userId = (Integer) userIdObj;

        // 查询订单状态
        List<Map<String, Object>> orderInfo = dbUtil.query("select status from Orders where orderNo=? and userId=?", orderNo, userId);
        if (orderInfo.isEmpty()) {
            return Result.fail("订单不存在");
        }
        Integer status = Integer.valueOf(orderInfo.get(0).get("status").toString());
        // 1=待付款，仅待付款可取消
        if (status != 1) {
            return Result.fail("当前订单状态不可取消");
        }
        // 修改状态为取消 0
        dbUtil.update("update Orders set status=0 where orderNo=? and userId=?", orderNo, userId);
        return Result.success("订单已取消");
    }
}