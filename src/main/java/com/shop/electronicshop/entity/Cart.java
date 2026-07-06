package com.shop.electronicshop.entity;
import lombok.Data;
import java.sql.Timestamp;
import java.math.BigDecimal;
@Data
public class Cart {
    private Integer cartId;
    private Integer userId;
    private Integer goodsId;
    private Integer buyNum;
    private Timestamp createTime;
    // 商品信息
    private String goodsName;
    private BigDecimal price;
    private String coverImg;
    private BigDecimal subtotal;
}