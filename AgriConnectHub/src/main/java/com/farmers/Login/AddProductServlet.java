package com.farmers.Login;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/addProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "product_images";
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("product-name");
        double price = Double.parseDouble(request.getParameter("product-price"));
        String description = request.getParameter("product-description");
        Part imagePart = request.getPart("product-image");
     // Assuming userId is the ID of the authenticated user
        HttpSession session = request.getSession();
        String username=(String) session.getAttribute("name");


        String imageFileName = "";
        String uploadPath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (imagePart != null) {
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

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "INSERT INTO products (name, price, imageSrc, description,uname) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setDouble(2, price);
                statement.setString(3, UPLOAD_DIR + "/" + imageFileName);
                statement.setString(4, description);
                statement.setString(5, username);
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("success");
        // Redirect to a success page
    }
}
