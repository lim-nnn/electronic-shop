package com.shop.electronicshop.entity;
import lombok.Data;
import java.math.BigDecimal;
import java.sql.Timestamp;
@Data
public class Goods {
    private Integer goodsId;
    private Integer typeId;
    private String goodsName;
    private BigDecimal price;
    private Integer stock;
    private Integer lockedStock;
    private String coverImg;
    private String goodsDesc;
    private Integer status;
    private Timestamp createTime;
    // 分类名称 关联查询使用
    private String typeName;
}