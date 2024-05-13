package com.farmers.Login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uemail = request.getParameter("username");
		String password = request.getParameter("password");
		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;
		try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection ("jdbc:mysql://localhost:3306/farmers_data?useSSL=false","root","Password");
		PreparedStatement pst = con.prepareStatement("select * from users where uemail = ? and password = ?");
		pst.setString(1, uemail);
		pst.setString(2, password);
		System.out.println("SQL Query: " + pst);
		ResultSet rs = pst.executeQuery();
		if(uemail.equals("admin") && password.equals("admin")) {
			dispatcher =request.getRequestDispatcher("admin.jsp");
		}
		else if (rs.next()) {
		session.setAttribute("name", rs.getString("uname"));
		session.setAttribute("email", rs.getString("uemail"));
		session.setAttribute("contact", rs.getString("contact"));
		session.setAttribute("address", rs.getString("address"));
		session.setAttribute("city", rs.getString("city"));
		session.setAttribute("state", rs.getString("state"));
		session.setAttribute("aboutMe", rs.getString("about_me"));
		session.setAttribute("interests", rs.getString("intrests"));
		session.setAttribute("photoFileName", rs.getString("profile_pic"));
		dispatcher =request.getRequestDispatcher("index.jsp");
		} else {
			request.setAttribute("status", "failed");
			dispatcher =request.getRequestDispatcher("farmer_login.jsp");
			}
			dispatcher.forward (request, response);
		} catch (Exception e) {
			e.printStackTrace();
			}
	}

}
