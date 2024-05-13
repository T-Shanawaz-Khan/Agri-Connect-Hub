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

@WebServlet("/myWork")
public class mywork extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Blog> blogList = new ArrayList<>();
        HttpSession userSession = request.getSession(false);
        String userName = (String) userSession.getAttribute("name");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "SELECT blog_id,title, imagesrc, content FROM blogs WHERE uname=?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
            	statement.setString(1, userName);
            	System.out.println("SQL Query: " + statement);
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                    	int id = resultSet.getInt("blog_id");
                        String name = resultSet.getString("title");
                        String imageSrc = resultSet.getString("imagesrc");
                        String description = resultSet.getString("content");

                        Blog blog = new Blog(id, name, imageSrc, description);
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
        	json.append("{\"id\":\"").append(blog.getId()).append("\",")
        	.append("\"title\":\"").append(blog.gettitle()).append("\",")
            .append("\"imageSrc\":\"").append(blog.getImageSrc()).append("\",")
            .append("\"content\":\"").append(blog.getContent()).append("\"},");
        }
        if (json.charAt(json.length() - 1) == ',') {
            json.deleteCharAt(json.length() - 1); // Remove the trailing comma
        }
        json.append("]");
        return json.toString();
    }
}