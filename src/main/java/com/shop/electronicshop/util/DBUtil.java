package com.shop.electronicshop.util;

import jakarta.annotation.Resource;
import org.springframework.stereotype.Component;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class DBUtil {
    @Resource
    private DataSource dataSource;

    // 获取连接
    public Connection getConn() throws SQLException {
        return dataSource.getConnection();
    }

    // 关闭资源
    public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 通用查询 返回List<Map> 适配所有表
    public List<Map<String, Object>> query(String sql, Object... params) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        Connection conn = getConn();
        PreparedStatement pstmt = conn.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            pstmt.setObject(i + 1, params[i]);
        }
        ResultSet rs = pstmt.executeQuery();
        ResultSetMetaData meta = rs.getMetaData();
        int colCount = meta.getColumnCount();
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            for (int i = 1; i <= colCount; i++) {
                String colName = meta.getColumnLabel(i);
                row.put(colName, rs.getObject(i));
            }
            list.add(row);
        }
        close(conn, pstmt, rs);
        return list;
    }

    // 增删改通用方法
    public int update(String sql, Object... params) throws SQLException {
        Connection conn = getConn();
        PreparedStatement pstmt = conn.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            pstmt.setObject(i + 1, params[i]);
        }
        int rows = pstmt.executeUpdate();
        close(conn, pstmt, null);
        return rows;
    }
}