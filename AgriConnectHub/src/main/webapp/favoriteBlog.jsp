<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String userName = (String) userSession.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
    <title>favoriteBlog</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <link rel="stylesheet" href="search.css">
    <style>
        /* style.css */
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
            background-color: #333;
            text-align: center;
        }
                .additional-options {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            background-color: #333;
            padding: 10px 20px;
        }

        .additional-option {
            margin-left: 20px;
            text-decoration: none;
            color: #00ffdd;
            font-size: 18px;
            display: flex;
            align-items: center;
        }

        .additional-option i {
            margin-right: 5px;
        }
        

        h1 {
            color: #fff;
        }
        #add-blog-form label {
    color: #f06; /* Label text color */
    display: block;
    margin-bottom: 10px;
    font-weight: bold;
	}

	#add-blog-form input[type="text"],
	#add-blog-form textarea,
	#add-blog-form button {
    	padding: 10px;
    	border-radius: 5px;
    	border: 1px solid #ccc;
    	width: 100%;
    	margin-bottom: 20px;
    	font-size: 16px;
	}

	#add-blog-form button {
    	background-color: #f06; /* Button background color */
    	color: #fff; /* Button text color */
    	border: none;
    	padding: 12px 24px;
    	border-radius: 5px;
    	cursor: pointer;
    	transition: background-color 0.3s ease;
	}

	#add-blog-form button:hover {
    	background-color: #ff3333; /* Button hover background color */
	}
        
        .blog-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            justify-content: center;
        }

        .blog {
            display: flex;
            flex-direction: row; /* Display the image and details in a row */
            position: relative;
            background-color: #333;
            border: 2px solid #f06;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
            cursor: pointer;
        }

        .blog:hover {
            transform: scale(1.03);
        }

        .blog-image {
            display: flex;
            justify-content: center;
            align-items: center;
            order: -1; /* Move the image to the left */
        }

        .blog-image img {
            max-width: 100%;
            max-height: 100%;
        }

        .blog-details {
            padding: 20px;
            display: flex;
            flex-direction: column; /* Display details in a column */
            align-items: flex-start; /* Align details to the start of the column */
        }

        .blog-details h2 {
            color: #f06;
            margin-top: 0;
        }
        
        
        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.7);
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border: 2px solid #f06;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        #add-blog-modal .modal-content{
        	padding:5rem;
        	padding-top:2rem;
        	padding-bottom:2rem;
        	
        }

        .close {
            position: absolute;
            top: 0;
            right: 0;
            padding: 10px;
            cursor: pointer;
        }

        /* Additional Styles */
        .thumbs-container {
            display: flex;
            gap: 10px; /* Adjust the gap as needed */
            margin-top: 10px;
        }

        .thumb-button {
            flex: 1; /* Take equal width within the container */
        }
        .thumb-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 20px;
            border-radius: 10px;
            cursor: pointer;
            margin-top: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .thumb-button:hover {
            background-color: #45a049;
        }

        .thumbs-count {
            color: #333;
            font-size: 18px;
        }
        

        .reviews {
            margin-top: 20px;
            text-align: left;
        }

        .review {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            margin-top: 10px;
        }

        .review p {
            margin: 0;
        }

        .review-form {
            margin-top: 20px;
            text-align: left;
        }

        .review-form label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .review-form input, .review-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .review-form button {
            background-color: #f06;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .review-form button:hover {
            background-color: #ff3333;
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
	
    <h1>favorite</h1>
    <div id="blog-container" class="blog-grid">
        <!-- Product listings will be added dynamically by JavaScript -->
    </div>
    <div id="blog-modal" class="modal">
        <div class="modal-content">
            <span class="close" id="close-modal">&times;</span>
            <div id="modal-blog-image" class="blog-image">
                <img src="" alt="">
            </div>
            <div id="modal-blog-details" class="blog-details">
                <h2></h2>
                <h4></h4>
                <p id="modal-blog-description">Description: </p>
                <button id="check-out" class="check-out">Check Out</button>
                <div class="star-rating">
                    <!-- Stars will be added dynamically -->
                </div>
                <div class="reviews">
                    <h3>Reviews</h3>
                    <div id="modal-reviews">
                        <!-- Reviews will be added dynamically -->
                    </div>
                </div>
                <div class="review-form">
                    <h3>Add Your Review</h3>
                    <label for="rating">Rating:</label>
                    <input type="number" id="rating" min="1" max="5" step="1">
                    <label for="user-review">Review:</label>
                    <textarea id="user-review" rows="4"></textarea>
                    <button id="submit-review">Submit Review</button>
                </div>
            </div>
        </div>
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
        // script.js
                function addBlog(id,title, imageSrc, content) {
            const blogContainer = document.getElementById("blog-container");

            const blogListing = document.createElement("div");
            blogListing.classList.add("blog");

            const blogImageContainer = document.createElement("div");
            blogImageContainer.classList.add("blog-image");

            const blogImage = document.createElement("img");
            blogImage.src = imageSrc;
            blogImage.alt = title + " Image";

            const blogDetails = document.createElement("div");
            blogDetails.classList.add("blog-details");

            const blogTitle = document.createElement("h2");
            blogTitle.textContent = title;

            const blogContent = document.createElement("p");
            blogContent.textContent = "Content: " + content.substring(0, 100) + "...";
            
            const deleteButton = document.createElement("button");
            deleteButton.textContent = "Delete";
            deleteButton.classList.add("delete-button");

            blogImageContainer.appendChild(blogImage);
            blogDetails.appendChild(blogTitle);
            blogDetails.appendChild(blogContent);
            blogDetails.appendChild(deleteButton);
            blogListing.appendChild(blogImageContainer);
            blogListing.appendChild(blogDetails); // Move the details after the image

            blogContainer.appendChild(blogListing);

            deleteButton.addEventListener("click", (event) => {
                event.stopPropagation(); // Prevent the click event from propagating to the parent (productListing)

                // Confirm deletion
                const confirmDelete = confirm("Are you sure you want to delete this Blog?");
                if (confirmDelete) {
                    // Remove product from UI
                    blogContainer.removeChild(blogListing);
                    
                    // Send AJAX request to delete product from the shopping cart table
                    deleteBlog(id);
                }
            });
            // Add a click event listener to each blog card
            blogListing.addEventListener("click", function() {
    			console.log("ID =", id); // Ensure id is converted to a string
    
    			const url = "displayBlog.jsp?id=" + id; // Construct the URL without using template literals
    			console.log("url=" + url);
    
    			// Redirecting to the constructed URL
    			window.location.href = url;
		});
        }
        
        // Function to fetch product data from the server
        function fetchProductData() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {  
                    if (xhr.status == 200) {
                        var data = JSON.parse(xhr.responseText);
                        // Assuming data is an array of product objects
                        data.forEach(blog => {
                            addBlog(blog.id,blog.name, blog.imageSrc, blog.description);
                        });
                    } else {
                        console.error('Error fetching product data. Status:', xhr.status);
                    }
                }
            };

            xhr.open('GET', 'Favorite', true);
            xhr.send();
        }

        // Call the fetchProductData function when the page loads
        window.addEventListener('load', fetchProductData);
        

        // Call the fetchProductData function when the page loads
        window.addEventListener('load', fetchProductData);
        function deleteBlog(blogId) {
            // Send AJAX request to delete the product with productId from the shopping cart table
            const xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        // Product deleted successfully
                        console.log("blog deleted successfully.");
                    } else {
                        console.error('Error deleting blog. Status:', xhr.status);
                    }
                }
            };
            xhr.open('POST', 'Favorite', true); // Adjust the URL and method as per your server-side implementation
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.send('blogId=' + blogId);
        }
    </script>


    
    
    
</body>
</html>
