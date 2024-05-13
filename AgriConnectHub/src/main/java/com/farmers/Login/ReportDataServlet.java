package com.farmers.Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReportDataServlet")
public class ReportDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC URL, username, and password of MySQL server
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        try {
            // Establish a connection to the database
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Fetch data for the reports
            Map<String, Integer> userCountByMonth = fetchCountByMonth(conn, "users");
            Map<String, Integer> productCountByMonth = fetchCountByMonth(conn, "products");
            Map<String, Integer> blogCountByMonth = fetchCountByMonth(conn, "blogs");

            // Convert data to JSON format
            String jsonData = "{ " +
                "\"userCountByMonth\": " + toJsonString(userCountByMonth) + "," +
                "\"productCountByMonth\": " + toJsonString(productCountByMonth) + "," +
                "\"blogCountByMonth\": " + toJsonString(blogCountByMonth) +
                "}";

            // Set response content type to JSON
            response.setContentType("application/json");

            // Send JSON response
            PrintWriter out = response.getWriter();
            out.print(jsonData);
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace(); // Handle potential errors
        } finally {
            // Close the connection
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

 // Utility method to fetch count by month for a given table from the database
    private Map<String, Integer> fetchCountByMonth(Connection conn, String tableName) throws SQLException {
        Map<String, Integer> countByMonth = new HashMap<>();
        String sql = "SELECT MONTHNAME(created_at) AS month, COUNT(*) AS count " +
                     "FROM " + tableName + " " +
                     "GROUP BY MONTH(created_at), YEAR(created_at)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                String month = rs.getString("month");
                int count = rs.getInt("count");
                countByMonth.put(month, count);
            }
        }

        return countByMonth;
    }


    // Utility method to convert a map to JSON string
    private String toJsonString(Map<String, Integer> map) {
        StringBuilder json = new StringBuilder("{");
        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            json.append("\"").append(entry.getKey()).append("\": ").append(entry.getValue()).append(",");
        }
        if (!map.isEmpty()) {
            json.deleteCharAt(json.length() - 1); // Remove the last comma
        }
        json.append("}");
        
        return json.toString();
    }
}
