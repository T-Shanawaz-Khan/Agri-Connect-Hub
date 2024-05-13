package com.farmers.Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RigistrationServlet
 */
@WebServlet("/register")
public class signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uname= request.getParameter("username");
		String uemail = request.getParameter("email");
		String contact = request.getParameter ("phone");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String password = request.getParameter("password");
		PrintWriter out = response.getWriter();
		RequestDispatcher dispatcher = null;
		Connection con =null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/farmers_data?useSSL=false","root","Password");
			PreparedStatement pst = con.prepareStatement("insert into users(uname, uemail, contact, address, city, state, password) values(?,?,?,?,?,?,?)");
			
			pst.setString(1, uname);
			pst.setString(2, uemail);
			pst.setString(3, contact);
			pst.setString(4, address);
			pst.setString(5, city);
			pst.setString(6, state);
			pst.setString(7, password);
			int rowCount = pst.executeUpdate();
			dispatcher =request.getRequestDispatcher("farmer_signup.jsp");
			if (rowCount > 0) {
			request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "failed");
			}
			dispatcher.forward (request, response);
		} catch (Exception e) {
		e.printStackTrace();
		}finally {
		try {
		con.close();
		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
	}
	}

}
