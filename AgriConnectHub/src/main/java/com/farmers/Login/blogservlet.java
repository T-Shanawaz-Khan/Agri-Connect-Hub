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

@WebServlet("/blogs1")
public class blogservlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Blog> blogList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "SELECT blog_id, title, imageSrc, content FROM blogs";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                    	int id = resultSet.getInt("blog_id");
                        String title = resultSet.getString("title");
                        String imageSrc = resultSet.getString("imageSrc");
                        String description = resultSet.getString("content");
                        Blog blog = new Blog(id, title, imageSrc, description);
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

class Blog {
	private int id;
    private String title;
    private String imageSrc;
    private String content;

    public Blog(String title, String imageSrc, String content) {
        this.title = title;
        this.imageSrc = imageSrc;
        this.content = content;
    }

    public Blog(int id, String name, String imageSrc, String description) {
		// TODO Auto-generated constructor stub
    	this.id=id;
    	this.title = name;
        this.imageSrc = imageSrc;
        this.content = description;
	}

	public Blog() {
		// TODO Auto-generated constructor stub
		
	}

	public String gettitle() {
        return title;
    }

    public String getImageSrc() {
        return imageSrc;
    }

    public String getContent() {
        return content;
    }

	public Object getDescription() {
		// TODO Auto-generated method stub
		return content;
	}

	public Object getId() {
		// TODO Auto-generated method stub
		return id;
	}

	public void setId(int id) {
		// TODO Auto-generated method stub
		this.id = id;
		
	}

	public void setTitle(String title) {
		// TODO Auto-generated method stub
		this.title=title;
	}

	public void setContent(String content) {
		// TODO Auto-generated method stub
		this.content=content;
	}

	public void setImageSrc(String imageSrc) {
		// TODO Auto-generated method stub
		this.imageSrc=imageSrc;
	}
}
