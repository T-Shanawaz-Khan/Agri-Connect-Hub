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

@WebServlet("/ContactDataServlet")
public class ContactDataServlet extends HttpServlet {
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
            String sql = "SELECT user_id AS username, contact_id AS contact ,product_id FROM UserContacts";
            stmt = conn.prepareStatement(sql);
            
            // Execute query
            rs = stmt.executeQuery();
            
            // Construct JSON response
            StringBuilder json = new StringBuilder("[");
            while (rs.next()) {
                json.append("{");
                json.append("\"username\":\"").append(rs.getString("username")).append("\",");
                json.append("\"contact\":\"").append(rs.getString("contact")).append("\",");
                json.append("\"product_id\":\"").append(rs.getString("Product_id")).append("\"");
                json.append("},");
            }
            if (json.charAt(json.length() - 1) == ',') {
                json.deleteCharAt(json.length() - 1); // Remove trailing comma
            }
            json.append("]");
            
            // Send JSON response
            out.print(json.toString());
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle exceptions
        } finally {
            // Close resources
            try { rs.close(); } catch (Exception e) {}
            try { stmt.close(); } catch (Exception e) {}
            try { conn.close(); } catch (Exception e) {}
        }
    }
}