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

@WebServlet("/DataServlet")
public class DataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JDBC URL, username, and password of MySQL server
        String jdbcURL = "jdbc:mysql://localhost:3306/farmers_data";
        String dbUser = "root";
        String dbPassword = "Password";

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Get a connection to the database
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Create SQL statements to fetch total numbers
            String sqlUsers = "SELECT COUNT(*) AS totalUsers FROM users";
            String sqlProducts = "SELECT COUNT(*) AS totalProducts FROM products";
            String sqlBlogs = "SELECT COUNT(*) AS totalBlogs FROM blogs";

            // Execute SQL queries
            statement = connection.prepareStatement(sqlUsers);
            resultSet = statement.executeQuery();
            int totalUsers = 0;
            if (resultSet.next()) {
                totalUsers = resultSet.getInt("totalUsers");
            }

            statement = connection.prepareStatement(sqlProducts);
            resultSet = statement.executeQuery();
            int totalProducts = 0;
            if (resultSet.next()) {
                totalProducts = resultSet.getInt("totalProducts");
            }

            statement = connection.prepareStatement(sqlBlogs);
            resultSet = statement.executeQuery();
            int totalBlogs = 0;
            if (resultSet.next()) {
                totalBlogs = resultSet.getInt("totalBlogs");
            }

            // Create a JSON object to store the total numbers
            String jsonData = "{ \"totalUsers\": " + totalUsers + ", \"totalProducts\": " + totalProducts + ", \"totalBlogs\": " + totalBlogs + " }";

            // Set response content type
            response.setContentType("application/json");

            // Write JSON data to the response
            PrintWriter out = response.getWriter();
            out.print(jsonData);
            out.flush();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            // Close all database resources
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
