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


@WebServlet("/editBlogServlet")
@MultipartConfig
public class EditBlogServlet extends HttpServlet {
    // Database connection details
	public static String blogId="";
    private static final String UPLOAD_DIR = "blog_images";
	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle GET request to fetch blog information by id
        blogId = request.getParameter("id");
        Blog blog = fetchBlogById();
        
        // Construct JSON response
        String jsonResponse = blog != null ? "{"
            + "\"id\":\"" + blog.getId() + "\","
            + "\"title\":\"" + escapeJson(blog.gettitle()) + "\","
            + "\"content\":\"" + escapeJson(blog.getContent()) + "\","
            + "\"imageSrc\":\"" + escapeJson(blog.getImageSrc()) + "\""
            + "}" : "{}";
        
        // Set response content type
        response.setContentType("application/json");
        // Write JSON response to the client
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
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

        // Update the blog information in the database with the new image file path
        updateBlog(title, content, imageFileName);
        response.sendRedirect("myWorks.jsp");
        // Send a response back to the client
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{ \"success\": true }");
    }
    
    // Method to fetch blog information by id from the database
    private Blog fetchBlogById() {
        Blog blog = null;
        
        try {
        	
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String sql = "SELECT * FROM blogs WHERE blog_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, blogId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                blog = new Blog();
                blog.setId(resultSet.getInt("blog_id"));
                blog.setTitle(resultSet.getString("title"));
                blog.setContent(resultSet.getString("content"));
                blog.setImageSrc(resultSet.getString("imageSrc"));
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }
    
    // Method to update blog information in the database
    private void updateBlog( String title, String content, String imageSrc) {
        try {
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            String sql = "UPDATE blogs SET title = COALESCE(?, title), content = COALESCE(?, content), imageSrc = COALESCE(?, imageSrc) WHERE blog_id = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, title);
            statement.setString(2, content);
            statement.setString(3,  UPLOAD_DIR + "/" +imageSrc);
            statement.setString(4, blogId);
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
