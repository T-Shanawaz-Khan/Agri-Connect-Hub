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

@WebServlet("/myProducts")
public class MyProductsServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();
        HttpSession userSession = request.getSession(false);
        String userName = (String) userSession.getAttribute("name");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "SELECT product_id,name, price, imagesrc, description FROM products WHERE uname=?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
            	statement.setString(1, userName);
            	System.out.println("SQL Query: " + statement);
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                    	int id=resultSet.getInt("product_id");
                        String name = resultSet.getString("name");
                        double price = resultSet.getDouble("price");
                        String imageSrc = resultSet.getString("imagesrc");
                        String description = resultSet.getString("description");
						Product product = new Product(id,name, price, imageSrc, description);
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
            json.append("{\"id\":\"").append(product.getId()).append("\",")
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
}