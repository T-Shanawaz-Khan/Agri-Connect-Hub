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
import javax.servlet.http.HttpSession;

@WebServlet("/contactListServlet")
public class ContactListServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/farmers_data";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Password";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session != null) {
            String currentUser = (String) session.getAttribute("name");

            if (currentUser != null) {
                List<String> contacts = getContactList(currentUser);
                // Convert contact list to JSON manually
                String jsonContacts = "[" + String.join(",", contacts) + "]";
                out.println(jsonContacts);
                System.out.println(jsonContacts);
            } else {
                out.println("User not found.");
            }
        } else {
            out.println("Session expired. Please log in again.");
        }

        out.close();
    }

    // Method to establish a database connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }

    // Method to close database resources
    public static void close(Connection connection, PreparedStatement statement, ResultSet resultSet) {
        try {
            if (resultSet != null)
                resultSet.close();
            if (statement != null)
                statement.close();
            if (connection != null)
                connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to get contact list for the current user
    public static List<String> getContactList(String currentUser) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        List<String> contacts = new ArrayList<>();

        try {
            // Establish a connection to the database
            connection = getConnection();

            // Prepare SQL statement to retrieve contact IDs for the current user
            String sql = "SELECT DISTINCT user_id FROM UserContacts WHERE contact_id = ? " +
                         "UNION " +
                         "SELECT DISTINCT contact_id FROM UserContacts WHERE user_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, currentUser);
            statement.setString(2, currentUser);

            // Execute the query
            resultSet = statement.executeQuery();

            // Iterate through the result set and add contacts to the list
            while (resultSet.next()) {
                String contactId = resultSet.getString("user_id");
                // Ensure current user is not added to the contact list
                if (!contactId.equals(currentUser)) {
                    contacts.add("\"" + contactId + "\"");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close database resources
            close(connection, statement, resultSet);
        }

        return contacts;
    }
}
