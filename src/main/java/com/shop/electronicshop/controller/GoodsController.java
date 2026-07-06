package com.shop.electronicshop.controller;

import com.shop.electronicshop.entity.Result;
import com.shop.electronicshop.util.DBUtil;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/goods")
public class GoodsController {
    // 你的工具类变量是 dbUtil，统一使用
    @Resource
    private DBUtil dbUtil;

    // 修复1：required只能填true/false，不能写Integer
    @GetMapping("/list")
    public Result<List<Map<String,Object>>> getGoodsList(
            @RequestParam(value = "typeId", required = false) Integer typeId
    ){
        try{
            List<Map<String,Object>> list;
            if(typeId == null){
                // 修复2：把 db.query → dbUtil.query
                list = dbUtil.query("select * from v_GoodsList where status=1");
            }else{
                list = dbUtil.query("select * from v_GoodsList where status=1 and typeId=?", typeId);
            }
            return Result.success(list);
        }catch (Exception e){
            e.printStackTrace();
            return Result.fail("商品查询失败");
        }
    }
}