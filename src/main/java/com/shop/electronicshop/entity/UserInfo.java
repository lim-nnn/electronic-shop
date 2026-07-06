package com.shop.electronicshop.entity;
import lombok.Data;
import java.sql.Timestamp;
@Data
public class UserInfo {
    private Integer userId;
    private String account;
    private String password;
    private String nickName;
    private String phone;
    private String address;
    private Timestamp createTime;
    private Integer status;
}