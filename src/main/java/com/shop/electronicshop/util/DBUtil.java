package com.shop.electronicshop.util;

import jakarta.annotation.Resource;
import org.springframework.stereotype.Component;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class DBUtil {
    @Resource
    private DataSource dataSource;

    // 获取数据库连接
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
}