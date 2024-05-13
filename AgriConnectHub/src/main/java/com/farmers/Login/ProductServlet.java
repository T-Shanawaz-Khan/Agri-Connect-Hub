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
@WebServlet("/productServlet")
public class ProductServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "SELECT name, price, imageSrc, description,product_id FROM products"; // Include id in the query
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
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
}

class Product {
    private int id; // Include id field
    private String name;
    private double price;
    private String imageSrc;
    private String description;

    public Product(int id, String name, double price, String imageSrc, String description) {
        this.id = id; // Assign id
        this.name = name;
        this.price = price;
        this.imageSrc = imageSrc;
        this.description = description;
    }
    public Product(String name, double price, String imageSrc, String description) {
        this.name = name;
        this.price = price;
        this.imageSrc = imageSrc;
        this.description = description;
    }
    public Product() {
        this.name = name;
        this.price = price;
        this.imageSrc = imageSrc;
        this.description = description;
    }

    public int getId() {
        return id; // Getter for id
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public String getImageSrc() {
        return imageSrc;
    }

    public String getDescription() {
        return description;
    }
	public void setId(int id) {
		// TODO Auto-generated method stub
		this.id=id;
		
	}
	public void setName(String name) {
		// TODO Auto-generated method stub
		this.name=name;
	}
	public void setPrice(double price) {
		// TODO Auto-generated method stub
		this.price=price;
	}
	public void setDescription(String description) {
		// TODO Auto-generated method stub
		this.description=description;
	}
	public void setImageSrc(String imageSrc) {
		// TODO Auto-generated method stub
		this.imageSrc=imageSrc;
	}
}
