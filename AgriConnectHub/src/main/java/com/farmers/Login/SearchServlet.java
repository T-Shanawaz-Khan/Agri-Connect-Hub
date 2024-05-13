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

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/searchServlet")
public class SearchServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String query = request.getParameter("query");

        List<SearchResult> searchResults = performSearch(query);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(searchResultsToJson(searchResults));
        out.flush();
    }

    private List<SearchResult> performSearch(String query) {
        List<SearchResult> searchResults = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT product_id AS id,name AS title, description, imagesrc,'product' AS type FROM products WHERE name LIKE ? " +
                         "UNION " +
                         "SELECT blog_id AS id,title, content AS description, imagesrc,'blog' AS type FROM blogs WHERE title LIKE ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, "%" + query + "%");
                stmt.setString(2, "%" + query + "%");
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        SearchResult result = new SearchResult();
                        result.setId(rs.getInt("id"));
                        result.setTitle(rs.getString("title"));
                        result.setDescription(rs.getString("description"));
                        result.setImageSrc(rs.getString("imagesrc"));
                        result.setType(rs.getString("type"));
                        searchResults.add(result);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return searchResults;
    }

    private String searchResultsToJson(List<SearchResult> searchResults) {
        StringBuilder jsonSearchResults = new StringBuilder("[");
        for (int i = 0; i < searchResults.size(); i++) {
            SearchResult result = searchResults.get(i);
            jsonSearchResults.append("{\"id\":\"").append(result.getId()).append("\",")
            				  .append("\"title\":\"").append(result.getTitle()).append("\",")
                              .append("\"description\":\"").append(result.getDescription()).append("\",")
                              .append("\"imageSrc\":\"").append(result.getImageSrc()).append("\",")
            				  .append("\"type\":\"").append(result.getType()).append("\"}");
            if (i < searchResults.size() - 1) {
                jsonSearchResults.append(",");
            }
        }
        jsonSearchResults.append("]");
        return jsonSearchResults.toString();
    }
}

class SearchResult {
	private int id; 
    private String title;
    private String description;
    private String imageSrc;
    private String type;

    // Getters and setters
    public int getId() {
        return id;
    }

	public void setId(int id) {
        this.id = id;
    }
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageSrc() {
        return imageSrc;
    }

    public void setImageSrc(String imageSrc) {
        this.imageSrc = imageSrc;
    }
    
    public String getType() {
    	return type;
    }
    
    public void setType(String type) {
		this.type=type;
		
	}
    
}
