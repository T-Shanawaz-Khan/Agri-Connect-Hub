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

@WebServlet("/addToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    	    throws ServletException, IOException {
    	HttpSession userSession = request.getSession(false);
        String userName = (String) userSession.getAttribute("name");
    	    // Retrieve product ID from request parameter
    	    String productId = request.getParameter("productId");
    	    System.out.println("productId:"+productId);
    	    // Insert product into shopping_cart table
    	    try {
    	        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/farmers_data", "root", "Password");
    	        String query = "INSERT INTO shopping_cart (uname,product_id, quantity) VALUES (?, ?, 1)";
    	        PreparedStatement pstmt = conn.prepareStatement(query);
    	        pstmt.setString(1, userName);
    	        pstmt.setString(2, productId);
    	        pstmt.executeUpdate();
    	        conn.close();
    	    } catch (SQLException e) {
    	        e.printStackTrace();
    	        // Handle SQL exception
    	    }

    	    // Send response with success status
    	    response.setStatus(HttpServletResponse.SC_OK);
    	}

}
