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
import javax.servlet.http.HttpSession;

@WebServlet("/AddToFavoritesServlet")
public class AddToFav extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the blog ID from the AJAX request
        int blogId = Integer.parseInt(request.getParameter("blogId"));
        
        // Get the username from the session
        HttpSession session = request.getSession(false);
        String userName = (String) session.getAttribute("name");

        // Insert data into the Fav_blogs table
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/farmers_data?useSSL=false", "root", "Password");

            // Prepare SQL statement
            String sql = "INSERT INTO Fav_blogs (uname, blog_id) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.setInt(2, blogId);

            // Execute the insert statement
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // Success response
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                // Failure response
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Error response
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
