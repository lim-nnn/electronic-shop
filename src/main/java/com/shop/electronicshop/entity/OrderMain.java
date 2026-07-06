package com.shop.electronicshop.entity;
import lombok.Data;
import java.math.BigDecimal;
import java.sql.Timestamp;
@Data
public class OrderMain {
    private Integer orderId;
    private String orderNo;
    private Integer userId;
    private BigDecimal totalMoney;
    private String receiveAddress;
    private Integer orderStatus;
    private Timestamp payTime;
    private Timestamp sendTime;
    private Timestamp createTime;
    private String nickName;
}