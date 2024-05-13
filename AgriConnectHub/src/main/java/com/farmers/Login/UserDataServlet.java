package com.farmers.Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserDataServlet")
public class UserDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            // Prepare SQL query
            String sql = "SELECT id, uname, uemail FROM users";
            stmt = conn.prepareStatement(sql);

            // Execute query
            rs = stmt.executeQuery();

            // Construct JSON response
            StringBuilder json = new StringBuilder("[");
            while (rs.next()) {
                json.append("{");
                json.append("\"userId\":").append(rs.getInt("id")).append(",");
                json.append("\"name\":\"").append(rs.getString("uname")).append("\",");
                json.append("\"email\":\"").append(rs.getString("uemail")).append("\"");
                json.append("},");
            }
            if (json.charAt(json.length() - 1) == ',') {
                json.deleteCharAt(json.length() - 1); // Remove trailing comma
            }
            json.append("]");

            // Send JSON response
            out.print(json.toString());
        } catch (ClassNotFoundException | SQLException e) {
            // Handle exceptions
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("{\"error\": \"An error occurred while fetching user data.\"}");
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
