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

@WebServlet("/DisplayShoppingCart")
public class myOrders extends HttpServlet {
	 private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
	    private static final String JDBC_USER = "root";
	    private static final String JDBC_PASSWORD = "Password";

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        List<Product> productList = new ArrayList<>();
	        HttpSession userSession = request.getSession(false);
	        String userName = (String) userSession.getAttribute("name");

	        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
	            String sql = "SELECT products.product_id, products.name, products.price,products.imageSrc,products.description "+
	            		"FROM shopping_cart "+
	            		"INNER JOIN products ON shopping_cart.product_id = products.product_id "+
	            		"WHERE shopping_cart.uname = ?"; // Include id in the query
	            try (PreparedStatement statement = connection.prepareStatement(sql)) {
	            	statement.setString(1, userName);
	            	System.out.println("SQL Query: " + statement);
	                try (ResultSet resultSet = statement.executeQuery()) {
	                	
	                    while (resultSet.next()) {
	                        int id = resultSet.getInt("product_id"); // Retrieve the product ID
	                        String name = resultSet.getString("name");
	                        double price = resultSet.getDouble("price");
	                        String imageSrc = resultSet.getString("imageSrc");
	                        String description = resultSet.getString("description");

	                        Product product = new Product(id, name, price, imageSrc, description); // Pass id to Product constructor
	                        productList.add(product);
	                    }
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        response.setContentType("application/json");
	        try (PrintWriter out = response.getWriter()) {
	            out.println(toJson(productList));
	        }
	    }

	    private String toJson(List<Product> productList) {
	        StringBuilder json = new StringBuilder("[");
	        for (Product product : productList) {
	            json.append("{\"id\":").append(product.getId()).append(",") // Include id in the JSON
	                .append("\"name\":\"").append(product.getName()).append("\",")
	                .append("\"price\":").append(product.getPrice()).append(",")
	                .append("\"imageSrc\":\"").append(product.getImageSrc()).append("\",")
	                .append("\"description\":\"").append(product.getDescription()).append("\"},");
	        }
	        if (json.charAt(json.length() - 1) == ',') {
	            json.deleteCharAt(json.length() - 1); // Remove the trailing comma
	        }
	        json.append("]");
	        return json.toString();
	    }
	        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	            // Get the product ID from the request parameter
	            String productId = request.getParameter("productId");
	            
	            // Perform deletion operation
	            boolean deleted = deleteProductFromDatabase(productId);
	            
	            // Send response back to the client
	            response.setContentType("text/html");
	            PrintWriter out = response.getWriter();
	            if (deleted) {
	                out.println("<h1>Product deleted successfully!</h1>");
	            } else {
	                out.println("<h1>Failed to delete product.</h1>");
	            }
	        }
	        
	        // Method to delete a product from the database
	        private boolean deleteProductFromDatabase(String productId) {
	            // Database connection parameters
	            String url = "jdbc:mysql://localhost:3306/farmers_data";
	            String username = "root";
	            String password = "Password";

	            // SQL query to delete a product by its ID
	            String sql = "DELETE FROM shopping_cart WHERE product_id = ?";

	            try (
	                // Establish database connection
	                Connection connection = DriverManager.getConnection(url, username, password);
	                // Create a prepared statement
	                PreparedStatement statement = connection.prepareStatement(sql);
	            ) {
	                // Set the product ID parameter in the prepared statement
	                statement.setInt(1, Integer.parseInt(productId));

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

