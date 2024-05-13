package com.farmers.Login;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/chatServlet")
public class ChatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/farmers_data"; // Change this to your database URL
    private static final String DB_USER = "root"; // Change this to your database username
    private static final String DB_PASSWORD = "Password"; // Change this to your database password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String messageContent =  request.getParameter("message-input");
     // Assuming userId is the ID of the authenticated user
        HttpSession session = request.getSession();
        String username=(String) session.getAttribute("name");
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO group_messages (sender_id,content) VALUES (?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, username);
                statement.setString(2, messageContent);
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Message> messageList = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT sender_id, content, timestamp FROM group_messages";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        String name = resultSet.getString("sender_id");
                        String content = resultSet.getString("content");
                        String timestamp = resultSet.getString("timestamp");
                        Message message = new Message(name,content,timestamp);
                        messageList.add(message);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            out.println(toJson(messageList));
        }
    }

    private String toJson(List<Message> messageList) {
        StringBuilder json = new StringBuilder("[");
        for (Message message : messageList) {
            json.append("{\"name\":\"").append(message.getname()).append("\",")
                .append("\"content\":\"").append(message.getContent()).append("\",")
                .append("\"timestamp\":\"").append(message.gettimestamp()).append("\"},");
        }
        if (json.charAt(json.length() - 1) == ',') {
            json.deleteCharAt(json.length() - 1); // Remove the trailing comma
        }
        json.append("]");
        return json.toString();
    }
}

class Message {
    private String name;
    private String content;
    private String timestamp;

    public Message(String name2, String content2, String timestamp2) {
		// TODO Auto-generated constructor stub
    	this.name=name2;
    	this.content=content2;
    	this.timestamp=timestamp2;
	}

	public String getname() {
        return name;
    }

    public String getContent() {
        return content;
    }

	public Object gettimestamp() {
		// TODO Auto-generated method stub
		return timestamp;
	}
}
