package com.farmers.Login;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet("/editProductServlet")
@MultipartConfig
public class EditProductServlet extends HttpServlet {
    // Database connection details
	public static String productId="";
    private static final String UPLOAD_DIR = "product_images";
	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET request to fetch product information by id
        productId = request.getParameter("id");
        Product product = fetchProductById();
        
        // Construct JSON response
        String jsonResponse = product != null ? "{"
            + "\"id\":\"" + product.getId() + "\","
            + "\"name\":\"" + escapeJson(product.getName()) + "\","
            + "\"price\":\"" + escapeJson(String.valueOf(product.getPrice())) + "\","
            + "\"description\":\"" + escapeJson(product.getDescription()) + "\","
            + "\"imageSrc\":\"" + escapeJson(product.getImageSrc()) + "\""
            + "}" : "{}";
        
        // Set response content type
        response.setContentType("application/json");
        // Write JSON response to the client
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        String name = request.getParameter("name");
        String price=request.getParameter("price");
        String description = request.getParameter("description");
        
        Part imagePart = request.getPart("imageSrc");
        String imageFileName = ""; // To hold the filename
        
        // Get the upload path on the server
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        // Create the upload directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Check if an image was uploaded
        if (imagePart != null && imagePart.getSize() > 0) {
            // Generate a unique filename for the image
            String[] imageSplit = imagePart.getSubmittedFileName().split("\\.");
            String fileExtension = imageSplit[imageSplit.length - 1];
            imageFileName = UUID.randomUUID().toString() + "." + fileExtension;

            // Save the image to the server
            String imagePath = uploadPath + File.separator + imageFileName;
            try (InputStream inputStream = imagePart.getInputStream();
                 FileOutputStream outputStream = new FileOutputStream(imagePath)) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Update the product information in the database with the new image file path
        updateProduct(name,price, description, imageFileName);
        response.sendRedirect("myproducts.jsp");
        // Send a response back to the client
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{ \"success\": true }");
    }
    
    // Method to fetch product information by id from the database
    private Product fetchProductById() {
        Product product = null;
        
        try {
        	
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String sql = "SELECT * FROM products WHERE product_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, productId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                product = new Product();
                product.setId(resultSet.getInt("product_id"));
                product.setName(resultSet.getString("name"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setImageSrc(resultSet.getString("imageSrc"));
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
    
    // Method to update product information in the database
    private void updateProduct( String name,String price, String description, String imageSrc) {
        try {
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String sql = "UPDATE products SET name = COALESCE(?, name),price=COALESCE(?,price), description = COALESCE(?, description), imageSrc = COALESCE(?, imageSrc) WHERE product_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, price);
            statement.setString(3, description);
            statement.setString(4,  UPLOAD_DIR + "/" +imageSrc);
            statement.setString(5, productId);
            statement.executeUpdate();
            statement.close();
            connection.close();
            System.out.println(statement);
            
            } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }
    
    // Method to escape special characters in JSON strings
 // Method to escape special characters in JSON strings
    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        value = value.replace("\\", "\\\\");
        value = value.replace("\"", "\\\"");
        value = value.replace("\b", "\\b");
        value = value.replace("\f", "\\f");
        value = value.replace("\n", "\\n");
        value = value.replace("\r", "\\r");
        value = value.replace("\t", "\\t");
        // More characters can be escaped if needed
        return value;
    }

}
