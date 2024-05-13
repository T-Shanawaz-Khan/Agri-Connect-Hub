package com.farmers.Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Favorite")
public class favorite extends HttpServlet {
	 private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
	    private static final String JDBC_USER = "root";
	    private static final String JDBC_PASSWORD = "Password";

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        List<Blog> blogList = new ArrayList<>();
	        HttpSession userSession = request.getSession(false);
	        String userName = (String) userSession.getAttribute("name");

	        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
	            String sql = "SELECT blogs.blog_id, blogs.title,blogs.imageSrc,blogs.content "+
	            		"FROM Fav_blogs "+
	            		"INNER JOIN blogs ON Fav_blogs.blog_id = blogs.blog_id "+
	            		"WHERE Fav_blogs.uname = ?"; // Include id in the query
	            try (PreparedStatement statement = connection.prepareStatement(sql)) {
	            	statement.setString(1, userName);
	            	System.out.println("SQL Query: " + statement);
	                try (ResultSet resultSet = statement.executeQuery()) {
	                	
	                    while (resultSet.next()) {
	                        int id = resultSet.getInt("blog_id"); // Retrieve the product ID
	                        String name = resultSet.getString("title");
	                        
	                        String imageSrc = resultSet.getString("imageSrc");
	                        String content = resultSet.getString("content");

	                        Blog blog = new Blog(id, name, imageSrc, content); // Pass id to Product constructor
	                        blogList.add(blog);
	                    }
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        response.setContentType("application/json");
	        try (PrintWriter out = response.getWriter()) {
	            out.println(toJson(blogList));
	        }
	    }

	    private String toJson(List<Blog> blogList) {
	        StringBuilder json = new StringBuilder("[");
	        for (Blog blog : blogList) {
	            json.append("{\"id\":").append(blog.getId()).append(",") // Include id in the JSON
	                .append("\"name\":\"").append(blog.gettitle()).append("\",")
	                .append("\"imageSrc\":\"").append(blog.getImageSrc()).append("\",")
	                .append("\"description\":\"").append(blog.getDescription()).append("\"},");
	        }
	        if (json.charAt(json.length() - 1) == ',') {
	            json.deleteCharAt(json.length() - 1); // Remove the trailing comma
	        }
	        json.append("]");
	        return json.toString();
	    }
	        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	            // Get the product ID from the request parameter
	            String blogId = request.getParameter("blogId");
	            
	            // Perform deletion operation
	            boolean deleted = deleteBlogFromDatabase(blogId);
	            
	            // Send response back to the client
	            response.setContentType("text/html");
	            PrintWriter out = response.getWriter();
	            if (deleted) {
	                out.println("<h1>Product deleted successfully!</h1>");
	            } else {
	                out.println("<h1>Failed to delete Blog.</h1>");
	            }
	        }
	        
	        // Method to delete a product from the database
	        private boolean deleteBlogFromDatabase(String blogId) {
	            // Database connection parameters
	            String url = "jdbc:mysql://localhost:3306/farmers_data";
	            String username = "root";
	            String password = "Password";

	            // SQL query to delete a product by its ID
	            String sql = "DELETE FROM Fav_blogs WHERE blog_id = ?";

	            try (
	                // Establish database connection
	                Connection connection = DriverManager.getConnection(url, username, password);
	                // Create a prepared statement
	                PreparedStatement statement = connection.prepareStatement(sql);
	            ) {
	                // Set the product ID parameter in the prepared statement
	                statement.setInt(1, Integer.parseInt(blogId));

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

