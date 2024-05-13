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

@WebServlet("/userChatServlet")
public class UserChatServlet extends HttpServlet {
    // Database connection parameters
	private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Password";
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the userId parameter from the request
        String userId = request.getParameter("userId");
        HttpSession userSession = request.getSession(false);
        String currentUser = (String) userSession.getAttribute("name");

        // Fetch chat messages for the specified user
        List<Message> messages = fetchChatMessagesForUser(userId,currentUser);

        // Convert the list of messages to JSON format
        String jsonMessages = convertMessagesToJson(messages);

        // Set the content type of the response to application/json
        response.setContentType("application/json");

        // Write the JSON response to the PrintWriter
        PrintWriter out = response.getWriter();
        out.print(jsonMessages);
        out.flush();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Extract sender ID, receiver ID, and message from request parameters
        String senderId = request.getParameter("senderId");
        String receiverId = request.getParameter("receiverId");
        String message = request.getParameter("message");
        HttpSession userSession = request.getSession(false);
        String currentUser = (String) userSession.getAttribute("name");

        // Insert the message into the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO Messages (sender_id, receiver_id, message) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, senderId);
                stmt.setString(2, receiverId);
                stmt.setString(3, message);
                stmt.executeUpdate();
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Handle the exception properly in your application
        }

        // Send a success response back to the client
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print("Message sent successfully!");
        out.flush();
    }

    // Method to fetch chat messages for a specific user from the database
    private List<Message> fetchChatMessagesForUser(String userId, String currentUser) {
        List<Message> messages = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String query = "SELECT sender_id, receiver_id, message, timestamp FROM Messages " +
                           "WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, currentUser);
            stmt.setString(2, userId);
            stmt.setString(3, userId);
            stmt.setString(4, currentUser);
            rs = stmt.executeQuery();
            while (rs.next()) {
                String senderId = rs.getString("sender_id");
                String receiverId = rs.getString("receiver_id");
                String content = rs.getString("message");
                String timestamp = rs.getString("timestamp");
                
                // Determine the displayed user based on sender and receiver IDs
                String displayedUser = senderId.equals(currentUser) ? senderId : senderId;
                System.out.println("Sender: " + senderId + ", Receiver: " + receiverId + ", Displayed User: " + displayedUser);
                messages.add(new Message(displayedUser, content, timestamp));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return messages;
    }

    // Method to convert a list of messages to JSON format
    private String convertMessagesToJson(List<Message> messages) {
        StringBuilder jsonBuilder = new StringBuilder("[");
        for (Message message : messages) {
            jsonBuilder.append("{\"sender\":\"").append(message.getname()).append("\",")
                    .append("\"content\":\"").append(message.getContent()).append("\",")
                    .append("\"timestamp\":\"").append(message.gettimestamp()).append("\"},");
        }
        if (!messages.isEmpty()) {
            jsonBuilder.deleteCharAt(jsonBuilder.length() - 1);
        }
        jsonBuilder.append("]");
        return jsonBuilder.toString();
    }
}
