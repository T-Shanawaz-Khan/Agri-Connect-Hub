package com.farmers.Login;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/updateProfile")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5 MB
public class profile extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "users_profiles";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession userSession = request.getSession(false);
        String userName = (String) userSession.getAttribute("name");

        String userEmail = request.getParameter("email");
        String userPhone = request.getParameter("phone");
        String userAddress = request.getParameter("address");
        String userCity = request.getParameter("city");
        String userState = request.getParameter("state");
        String aboutMe = request.getParameter("aboutMe");
        String interests = request.getParameter("interests");

        Part photoPart = request.getPart("photo");
        String photoFileName = uploadPhoto(userName, photoPart);

        String jdbcUrl = "jdbc:mysql://localhost:3306/farmers_data?useSSL=true";
        String dbUsername = "root";
        String dbPassword = "Password";

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

            // Create a SQL statement
            String sql = "UPDATE users SET uemail=?, contact=?, address=?, city=?, state=?, about_me=?, intrests=?, profile_pic=? WHERE uname=?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, userEmail);
                preparedStatement.setString(2, userPhone);
                preparedStatement.setString(3, userAddress);
                preparedStatement.setString(4, userCity);
                preparedStatement.setString(5, userState);
                preparedStatement.setString(6, aboutMe);
                preparedStatement.setString(7, interests);
                preparedStatement.setString(8, photoFileName);
                preparedStatement.setString(9, userName);

                // Execute the update
                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    // Update successful
                    response.sendRedirect("profile.jsp");
                } else {
                    // Update failed
                    response.getWriter().println("Failed to update profile.");
                }
            }

            // Close the connection
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error updating profile.");
        }
    }

    private String uploadPhoto(String userName, Part part) throws IOException {
        String fileName = userName + "_" + new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())
                + getExtension(part.getSubmittedFileName());

        Path uploadPath = getUploadPath();
        try (InputStream input = part.getInputStream()) {
            Files.copy(input, uploadPath.resolve(fileName), StandardCopyOption.REPLACE_EXISTING);
        }

        return fileName;
    }

    private String getExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        return (dotIndex == -1) ? "" : fileName.substring(dotIndex);
    }

    private Path getUploadPath() throws IOException {
        Path uploadPath = Paths.get(getServletContext().getRealPath(""), UPLOAD_DIRECTORY);
        if (!Files.exists(uploadPath)) {
            Files.createDirectory(uploadPath);
        }
        return uploadPath;
    }
}
