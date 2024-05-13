package com.farmers.Login;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/AddContactServlet")
public class AddContactServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session != null) {
            String currentUser = (String) session.getAttribute("name");
            String productId = request.getParameter("productId");

            if (currentUser != null && productId != null) {
                String ownerUsername = getOwnerUsername(productId);

                if (ownerUsername != null) {
                    boolean contactAdded = addContactToUserContacts(ownerUsername, currentUser, Integer.parseInt(productId));

                    session.setAttribute("contactId", ownerUsername);
                    if (contactAdded) {
                    	session.setAttribute("highlightUserId", ownerUsername);
                    } else {
                        out.println("Failed to add contact.");
                    }
                } else {
                    out.println("Owner username not found.");
                }
            } else {
                out.println("User or product ID not found.");
            }
        } else {
            out.println("Session expired. Please log in again.");
        }

        out.close();
    }

    // Method to establish a database connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    // Method to close database resources
    public static void close(Connection connection, PreparedStatement statement, ResultSet resultSet) {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to get owner's username based on product ID
    public static String getOwnerUsername(String productId) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String ownerUsername = null;

        try {
            // Establish a connection to the database
            connection = getConnection();

            // Prepare SQL statement to retrieve owner's username based on product ID
            String sql = "SELECT uname FROM Products WHERE product_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, productId);

            // Execute the query
            resultSet = statement.executeQuery();

            // If a row is found, retrieve the owner's username
            if (resultSet.next()) {
                ownerUsername = resultSet.getString("uname");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close database resources
            close(connection, statement, resultSet);
        }

        return ownerUsername;
    }

    // Method to add contact to UserContacts table
    public static boolean addContactToUserContacts(String ownerUsername, String currentUser, int productId) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean contactAdded = false;

        try {
            // Establish a connection to the database
            connection = getConnection();

            // Prepare SQL statement to insert the contact into UserContacts table
            String sql = "INSERT INTO UserContacts (user_id, contact_id, product_id) VALUES (?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, currentUser);
            statement.setString(2, ownerUsername);
            statement.setInt(3,productId);

            // Execute the update
            int rowsAffected = statement.executeUpdate();

            // If one row is affected, contact is added successfully
            contactAdded = rowsAffected == 1;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close database resources
            close(connection, statement, null);
        }

        return contactAdded;
    }
}