package com.farmers.Login;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/messageServlet")
public class MessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Sample data store for messages
    private List<Messages> cmessages = new ArrayList<>();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch messages based on request parameters
        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");
        List<Messages> filteredMessages = getMessages(sender, receiver);
        
        // Convert messages to JSON and send as response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(convertMessagesToJSON(filteredMessages));
        out.flush();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract message data from request parameters
        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");
        String content = request.getParameter("content");
        
        // Create a new message object
        Messages newMessage = new Messages(sender, receiver, content);
        
        // Add the message to the data store
        cmessages.add(newMessage);
        
        // Send success response
        response.setStatus(HttpServletResponse.SC_CREATED);
    }
    
    // Utility method to fetch messages based on sender and receiver
    private List<Messages> getMessages(String sender, String receiver) {
        List<Messages> filteredMessages = new ArrayList<>();
        for (Messages message : cmessages) {
            if (message.getSender().equals(sender) && message.getReceiver().equals(receiver)) {
                filteredMessages.add(message);
            }
        }
        return filteredMessages;
    }
    
    // Utility method to convert messages to JSON format
    private String convertMessagesToJSON(List<Messages> messages) {
        StringBuilder json = new StringBuilder("[");
        for (Messages message : messages) {
            json.append("{");
            json.append("\"sender\":\"").append(message.getSender()).append("\",");
            json.append("\"receiver\":\"").append(message.getReceiver()).append("\",");
            json.append("\"content\":\"").append(message.getContent()).append("\"");
            json.append("},");
        }
        if (!messages.isEmpty()) {
            json.deleteCharAt(json.length() - 1); // Remove the trailing comma
        }
        json.append("]");
        return json.toString();
    }
}
class Messages {
    private String sender;
    private String receiver;
    private String content;
    
    public Messages(String sender, String receiver, String content) {
        this.sender = sender;
        this.receiver = receiver;
        this.content = content;
    }
    
    // Getters and setters
    public String getSender() {
        return sender;
    }
    
    public String getReceiver() {
        return receiver;
    }
    
    public String getContent() {
        return content;
    }
}
