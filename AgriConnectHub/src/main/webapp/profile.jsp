<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String userName = (String) userSession.getAttribute("name");
    String userEmail =  (String) userSession.getAttribute("email"); // Add the necessary logic to retrieve user email from the session or database
    String userPhone =  (String) userSession.getAttribute("contact"); // Add the necessary logic to retrieve user phone from the session or database
    String userAddress =  (String) userSession.getAttribute("address"); // Add the necessary logic to retrieve user address from the session or database
    String userCity =  (String) userSession.getAttribute("city"); // Add the necessary logic to retrieve user city from the session or database
    String userState =  (String) userSession.getAttribute("state"); // Add the necessary logic to retrieve user state from the session or database
    String aboutMe =  (String) userSession.getAttribute("aboutMe"); // Add the necessary logic to retrieve user about me from the session or database
    String interests = (String) userSession.getAttribute("interests"); // Add the necessary logic to retrieve user interests from the session or database
    String photoFileName=(String) userSession.getAttribute("photoFileName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="search.css">
    <title>User Profile</title>
    <style>
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
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .profile-container {
            background-color: #fff;
            width: 90%; /* Increased width */
            margin: 20px auto; /* Centered with some top margin */
            padding: 40px;
            border: 1px solid #00ffdd;
            border-radius: 8px;
            text-align: center;
        }
        h1 {
            color: #00ffdd;
            font-size: 24px;
        }
        .user-photo-container {
            position: relative;
        }
        .user-photo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin: 10px auto;
        }
        .photo-actions {
            margin-bottom: 20px;
        }
        .photo-actions label {
            color: #00ffdd;
            cursor: pointer;
            text-decoration: underline;
            margin-right: 5px;
        }
        .photo-actions input[type="file"] {
            display: none;
        }
        fieldset {
            border: 1px solid #00ffdd;
            border-radius: 8px;
            margin-top: 20px;
        }
        legend {
            background-color: #00ffdd;
            color: #333;
            padding: 5px 10px;
            border: 1px solid #00ffdd;
            border-radius: 4px;
        }
        .input-container {
            position: relative;
            margin: 10px 0;
            text-align: left;
        }
        label {
            display: block; /* To make labels take full width */
            color: #333;
            font-weight: bold;
            margin-bottom: 5px; /* Add some spacing */
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"] {
            width: 100%;
            padding: 14px;
            border: 1px solid #171717;
            border-radius: 4px;
            box-sizing: border-box;
            transition: 0.2s;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus {
            border-color: #00ffdd;
        }
        .btn-save {
            background-color: #00ffdd;
            color: #333;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-save:hover {
            background-color: #00ccaa;
        }
    </style>
</head>
<body>
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
    <div class="profile-container">
        <h1>User Profile</h1>
		<form action="updateProfile" method="post" enctype="multipart/form-data">
		    <input type="hidden" name="username" value="<%=userName %>">
		    <div class="user-photo-container">
		        <img src="users_profiles/<%=photoFileName %>" alt="User Photo" class="user-photo">
		    </div>
		
		    <div class="photo-actions">
		        <label for="photo">Change Photo</label>
		        <input type="file" id="photo" name="photo" accept="image/*">
		    </div>
		
		    <fieldset>
		        <legend>User Personal Details</legend>
		        <div class="input-container">
		            <label for="username">Username:</label>
		            <input type="text" id="username" name="username" placeholder="E.g., JohnDoe" value="<%=userName %>" required readonly>
		        </div>
		        <div class="input-container">
		            <label for="email">Email:</label>
		            <input type="email" id="email" name="email" placeholder="E.g., user@example.com" value="<%=userEmail %>" required>
		        </div>
		        <div class="input-container">
		            <label for="phone">Phone number:</label>
		            <input type="tel" id="phone" name="phone" placeholder="E.g., 123-456-7890" value="<%=userPhone %>" required>
		        </div>
		    </fieldset>
		
		    <fieldset>
		        <legend>Address</legend>
		        <div class="input-container">
		            <label for="address">Address:</label>
		            <input type="text" id="address" name="address" placeholder="E.g., 123 Main St" value="<%=userAddress %>" required>
		        </div>
		        <div class="input-container">
		            <label for="city">City:</label>
		            <input type="text" id="city" name="city" placeholder="E.g., Sample City" value="<%=userCity %>" required>
		        </div>
		        <div class="input-container">
		            <label for="state">State:</label>
		            <input type="text" id="state" name="state" placeholder="E.g., Sample State" value="<%=userState %>" required>
		        </div>
		    </fieldset>
		
		    <fieldset>
		        <legend>Other Details</legend>
		        <div class="input-container">
		            <label for="aboutMe">About Me:</label>
		            <input type="text" id="aboutMe" name="aboutMe" placeholder="E.g., I'm a farmer passionate about organic farming." value="<%=aboutMe %>" required>
		        </div>
		        <div class="input-container">
		            <label for="interests">Interests:</label>
		            <input type="text" id="interests" name="interests" placeholder="E.g., Organic farming, gardening, sustainability" value="<%=interests %>" required>
		        </div>
		        <div class="input-container">
		            <button type="submit" class="btn-save">Save Changes</button>
		        </div>
		    </fieldset>
		</form>

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
<script src="https://kit.fontawesome.com/c103b7df21.js" crossorigin="anonymous"></script>
    <script>
        const photoInput = document.getElementById("photo");
        const userPhoto = document.querySelector(".user-photo");

        photoInput.addEventListener("change", function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    userPhoto.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
</body>
</html>
