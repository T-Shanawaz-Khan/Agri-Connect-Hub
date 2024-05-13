package com.farmers.Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class deleteProduct
 */
@WebServlet("/deleteUser")
public class DeleteUsers extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Get the product ID from the request parameter
            String userName = request.getParameter("userName");
            System.out.println("username = "+userName);            // Perform deletion operation
            boolean deleted = deleteUserFromDatabase(userName);
            
            // Send response back to the client
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (deleted) {
                out.println("<h1>User deleted successfully!</h1>");
            } else {
                out.println("<h1>Failed to delete User.</h1>");
            }
        }
        
        // Method to delete a product from the database
        private boolean deleteUserFromDatabase(String userName) {
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/farmers_data";
            String username = "root";
            String password = "Password";

            // SQL query to delete a product by its ID
            String sql = "DELETE FROM users WHERE uname = ?";

            try (
                // Establish database connection
                Connection connection = DriverManager.getConnection(url, username, password);
                // Create a prepared statement
                PreparedStatement statement = connection.prepareStatement(sql);
            ) {
                // Set the product ID parameter in the prepared statement
                statement.setString(1,userName);

                // Execute the delete operation
                int rowsAffected = statement.executeUpdate();

                // If one or more rows were affected, deletion was successful
                return rowsAffected > 0;
            } catch (SQLException e) {
                // Handle any SQL exceptions
                e.printStackTrace();
                return false;
            }
        }
	}
