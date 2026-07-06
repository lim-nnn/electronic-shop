package com.shop.electronicshop.entity;
import lombok.Data;
import java.sql.Timestamp;
@Data
public class Admin {
    private Integer adminId;
    private String adminAccount;
    private String adminPwd;
    private String adminName;
    private Timestamp createTime;
}