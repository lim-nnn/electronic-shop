package com.shop.electronicshop.entity;
import lombok.Data;
@Data
public class GoodsType {
    private Integer typeId;
    private String typeName;
    private Integer sort;
    private Integer status;
}