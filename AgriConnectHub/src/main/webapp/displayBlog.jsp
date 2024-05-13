<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String userName = (String) userSession.getAttribute("name");
%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Blog Post</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <link rel="stylesheet" href="search.css">
    <style>
                /* style.css */
        body {
            font-family: Arial, sans-serif;
            background-color: #333;
            text-align: center;
        }
        .navbar {
            background-color: #333;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            margin-top: 0;
            position: sticky;
        }
        .logo {
            color: #00ffdd;
            font-size: 24px;
            text-decoration: none;
        }
        .search-container {
            flex: 0.9;
            display: flex;
            align-items: center;
            margin: 0 10px;
            padding: 5px 10px;
            border: 2px solid #00ffdd;
            border-radius: 5px;
            background-color: #222;
            color: #fff;
        }
        .search-bar {
            flex: 1;
            border: none;
            background-color: transparent;
            color: #fff;
            width: 100%;
        }
        .search-button {
            border: none;
            background-color: #00ffdd;
            color: #0f0e0e;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-link {
            margin-right: 20px;
            text-decoration: none;
            color: #00ffdd;
            font-size: 18px;
        }
        .profile-pic {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
            vertical-align: middle;
        }
        #profileLink {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #00ffdd;
            font-size: 18px;
        }
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #333;
            min-width: 160px;
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: #00ffdd;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #555;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
        .blog {
            margin-bottom: 20px;
            background-color: black;
            padding: 20px;
            border-radius: 5px;
            color: #f06;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .blog .user-info {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .blog .user-info img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }
        .blog .user-info .user-name {
            font-weight: bold;
            margin-right: 10px;
            color: #00ffdd;
        }
        .blog .date {
            color: #666;
            margin-right: 10px;
        }
        .blog .likes {
            margin-right: 10px;
        }
        .blog .like-button {
            cursor: pointer;
        }
        .blog .heading {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .blog .content img {
            max-width: 100%;
            margin-bottom: 10px;
        }
        .blog .content p {
            margin-bottom: 10px;
        }
        .blog .thumbs-up, .blog .thumbs-down {
            cursor: pointer;
            margin-left: 10px;
        }

    </style>
</head>
<body>
    <!-- Navbar -->
    	<nav class="navbar">
		<div class="navbar">
        <a class="logo" href="index.jsp" data-section="home"><i class="fas fa-home"></i> Agri-Connect Hub</a>
        <div class="search-container">
            <input class="search-bar" id="searchInput" type="text" placeholder="Search...">
            <button onclick="search()">Search</button>
        </div>
        <div class="nav-links">
            <a class="nav-link" href="mart.jsp" data-section="mart"><i class="fas fa-shopping-cart"></i> Mart</a>
            <a class="nav-link" href="blogs.jsp" data-section="blogs"><i class="fa-regular fa-newspaper"></i> Blogs</a>
			<div class="dropdown">
                <a class="nav-link" id="profileLink" style="cursor: pointer;"><i class="fas fa-user"></i><%=userName %></a>
                <div class="dropdown-content">
                    <a href="profile.jsp">Profile</a>
                    <a href="Logout">Logout</a>
                </div>
            </div>
        </div>
    </div>
    </nav>
    <div id="searchResults" class="blog-grid">
    <!-- Search results will be dynamically added here -->
	</div>
	<div id="mainContent">

    <!-- Blog content -->
    <div class="blog">
        <% 
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int blogId = Integer.parseInt(request.getParameter("id"));
            System.out.println(blogId);
            try {
                // Get blogId from request parameter
                
                // Establish database connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/farmers_data?useSSL=false", "root", "Password");
                
                // Prepare SQL statement
                String sql = "SELECT * FROM blogs WHERE blog_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, blogId);

        		System.out.println("SQL Query: " + pstmt);
                // Execute query
                rs = pstmt.executeQuery();

                // Iterate through the result set
                if (rs.next()) {
                    String writerName = rs.getString("uname");
                    String heading = rs.getString("title");
                    String content = rs.getString("content");
                    String image = rs.getString("imagesrc");
        %>
        <!-- Display user info -->
        <div class="user-info">
            <span class="user-name">written by: <%= writerName %></span>
            <button class="add-to-favorites" type="button" data-blog-id="<%= blogId %>">Add to Favorites</button>
        </div>
        <!-- Display blog heading -->
        <h2 class="heading"><%= heading %></h2>
        <!-- Display blog content -->
        <div class="content">
            <!-- Display the image if available -->
    		<%
        		if (image != null && !image.isEmpty()) {
    		%>
    			<img src="<%= image %>" alt="Blog Image">
    		<%
        		}
    		%>
            <p><%= content %></p>
            <!-- You can display images or other content here -->
            
        </div>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
    </div>
    
    <!------Footer---->
    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <!-- Your logo or brand image -->
                <img src="images/logo.jpg" alt="Logo" style="width: 50%;">
            </div>
            <div class="footer-links">
                <!-- Links to important pages -->
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="#">About Us</a></li>
                    <li><a href="#">Products</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </div>
            <div class="footer-social">
                <!-- Social media icons -->
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 Agri-Connect Hub. All rights reserved.</p>
        </div>
    </footer>
    <script src="search.js"></script>
    <script>
    $(document).ready(function() {
        // AJAX call when "Add to Favorites" button is clicked
        $('.add-to-favorites').on('click', function() {
            var blogId = $(this).data('blog-id');
            $.ajax({
                url: 'AddToFavoritesServlet', // Relative URL
                method: 'POST',
                data: { blogId: blogId },
                success: function(response) {
                    // Handle success response
                    alert('Blog added to favorites successfully');
                },
                error: function(xhr, status, error) {
                    // Handle error response
                    
                    // If the status code is 409 (conflict), it means the blog is already in favorites
                    alert('This blog is already exist in favorites.');
                    
                }
            });
        });
    });

    </script>
</body>
</html>
    