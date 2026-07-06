package com.shop.electronicshop.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Result<T> {
    private Integer code;
    private String msg;
    private T data;

    // 成功响应
    public static <T> Result<T> success(T data) {
        return new Result<>(200, "操作成功", data);
    }
    public static <T> Result<T> success(String msg, T data) {
        Result<T> r = new Result<>();
        r.setCode(200);
        r.setMsg(msg);
        r.setData(data);
        return r;
    }
    // 失败响应
    public static <T> Result<T> fail(String msg) {
        return new Result<>(500, msg, null);
    }
}