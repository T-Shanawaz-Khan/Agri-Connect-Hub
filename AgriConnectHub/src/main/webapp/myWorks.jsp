<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String userName = (String) userSession.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
    <title>myWork</title>
    
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
            max-width:50%;
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
    background-color: rgba(0, 0, 0, 0.7);
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

.close {
    position: absolute;
    top: 0;
    right: 0;
    padding: 10px;
    cursor: pointer;
}

/* Add styling for input fields and buttons */
.modal-content input[type="text"],
.modal-content textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.modal-content button {
    background-color: #f06;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.modal-content button:hover {
    background-color: #ff3333;
}

        .buttons-container {
    display: flex;
    justify-content: space-between;
    margin-top: 10px; /* Add some margin to separate from other content */
}

.edit-button,
.delete-button {
    background-color: #2196F3; /* Blue color for edit button */
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
}

.delete-button {
    background-color: #f44336; /* Red color for delete button */
    margin-left: 10px; /* Add margin between the buttons */
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
    <h1>Blog Page</h1>
    <div id="blog-container" class="blog-grid">
        <!-- Blog listings will be added dynamically by JavaScript -->
    </div>
    <div id="edit-blog-modal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-edit-modal">&times;</span>
        <h2>Edit Blog</h2>
        <form action="editBlogServlet" method="post" enctype="multipart/form-data">
        	<div class="input-container">
		            <label for="title">title:</label>
		            <input type="text" id="title" name="title"  >
		        </div>
		        <div class="input-container">
		            <label for="content">Content:</label>
            		<textarea id="content" name="content" rows="4"></textarea>		        </div>
		        <div class="input-container">
		            <img id="edit-blog-image-preview" src="" alt="Image Preview" style="max-width: 100%; max-height: 200px; margin-bottom: 10px;">
            
    				<label for="imageSrc">Replace Image:</label>
    				<input type="file" id="imageSrc" name="imageSrc" accept="blog_image/*">
    				
		       </div>
		       <div class="input-container">
		            <button type="submit" class="btn-save" id="save-edit">Save Changes</button>
		        </div>
        </form>
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
    const saveButton = document.getElementById("save-edit");
        function fetchBlogData() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        var data = JSON.parse(xhr.responseText);
                        // Assuming data is an array of product objects
                        data.forEach(blog => {
                        	addBlog(blog.id,blog.title, blog.imageSrc, blog.content);
                        });
                    } else {
                        console.error('Error fetching blogs data. Status:', xhr.status);
                    }
                }
            };

            xhr.open('GET', 'myWork', true);
            xhr.send();
        }
        
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
            
            const buttonsContainer = document.createElement("div");
            buttonsContainer.classList.add("buttons-container");
            
            const editButton = document.createElement("button");
            editButton.textContent = "Edit";
            editButton.classList.add("edit-button"); // Add specific class for edit button
            editButton.addEventListener("click", (event) => {
                event.stopPropagation(); // Stop event propagation
                editBlog(id);
            }); // Call editBlog function with blog id

            const deleteButton = document.createElement("button");
            deleteButton.textContent = "Delete";
            deleteButton.classList.add("delete-button"); // Add specific class for delete button
            deleteButton.addEventListener("click", (event) => {
                event.stopPropagation(); // Prevent the click event from propagating to the parent (productListing)

                // Confirm deletion
                const confirmDelete = confirm("Are you sure you want to delete this Blog?");
                if (confirmDelete) {
                    // Remove product from UI
                    
                    // Send AJAX request to delete product from the shopping cart table
                    deleteBlog(id);
                }
            });
            
            buttonsContainer.appendChild(editButton);
            buttonsContainer.appendChild(deleteButton);

            blogImageContainer.appendChild(blogImage);
            blogDetails.appendChild(blogTitle);
            blogDetails.appendChild(blogContent);
            blogDetails.appendChild(buttonsContainer);

            blogListing.appendChild(blogImageContainer);
            blogListing.appendChild(blogDetails); // Move the details after the image

            blogContainer.appendChild(blogListing);

            // Add a click event listener to each blog card
            blogListing.addEventListener("click", function() {
    			console.log("ID =", id); // Ensure id is converted to a string
    
    			const url = "displayBlog.jsp?id=" + id; // Construct the URL without using template literals
    			console.log("url=" + url);
    
    			// Redirecting to the constructed URL
    			window.location.href = url;
		});
        }

         

        // Close the modal when clicking outside of it
        window.addEventListener("click", (event) => {
            const modal = document.getElementById("blog-modal");
            if (event.target === modal) {
                const thumbsUpCountElement = document.getElementById("up-count");
                const thumbsDownCountElement = document.getElementById("down-count");
                thumbsUpCount = 0;
                thumbsDownCount = 0;
                thumbsUpCountElement.textContent = thumbsUpCount;
                thumbsDownCountElement.textContent = thumbsDownCount;
                modal.style.display = "none";
            }
        });
		window.addEventListener('load', fetchBlogData);
		function editBlog(id) {
			console.log(id);
		    // Get the blog information from the server using AJAX
		    var xhr = new XMLHttpRequest();
		    xhr.onreadystatechange = function () {
		        if (xhr.readyState == 4) {
		            if (xhr.status == 200) {
		                var blog = JSON.parse(xhr.responseText);
		                displayEditPopup(blog);
		                
		            } else {
		                console.error('Error fetching blog data for editing. Status:', xhr.status);
		            }
		        }
		    };

		    xhr.open('GET', 'editBlogServlet?id=' + id, true); // Assuming there's an endpoint to fetch blog info by id

		    xhr.send();
		}
		function deleteBlog(blogId) {
            // Send AJAX request to delete the product with productId from the shopping cart table
            const xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        // Product deleted successfully
                        console.log("blog deleted successfully.");
                        window.location.reload();
                    } else {
                        console.error('Error deleting blog. Status:', xhr.status);
                    }
                }
            };
            xhr.open('POST', 'deleteBlog', true); // Adjust the URL and method as per your server-side implementation
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.send('blogId=' + blogId);
        }

		function displayEditPopup(blog) {
		    // Display the modal popup for editing the blog
		    const modal = document.getElementById("edit-blog-modal");
		    const blogTitleInput = document.getElementById("title");
		    const blogContentInput = document.getElementById("content");
		    const blogImageInput = document.getElementById("imageSrc");
		    const blogImagePreview = document.getElementById("edit-blog-image-preview");

		    // Set the input fields with the blog information
		    blogTitleInput.value = blog.title;
		    blogContentInput.value = blog.content;
		    blogImagePreview.src = blog.imageSrc;
		    

		    // Show the modal
		    modal.style.display = "block";
		    
		    blogImageInput.addEventListener("change", function(event) {
		        const file = event.target.files[0];
		        if (file) {
		            const reader = new FileReader();
		            reader.onload = function(e) {
		                blogImagePreview.src = e.target.result;
		            };
		            reader.readAsDataURL(file);
		        }
		    });
		}
		

		// Close the edit modal when the close button is clicked
		document.getElementById("close-edit-modal").addEventListener("click", () => {
		    const modal = document.getElementById("edit-blog-modal");
		    modal.style.display = "none";
		});

		// Close the edit modal when clicking outside of it
		window.addEventListener("click", (event) => {
		    const modal = document.getElementById("edit-blog-modal");
		    if (event.target === modal) {
		        modal.style.display = "none";
		    }
		});
		
		function handleResponse(response) {
		    var jsonResponse = JSON.parse(response);
		    if (jsonResponse.success) {
		        // If the response indicates success, reload the page
		        window.location.reload();
		    } else {
		        // Handle other responses if needed
		    }
		}
		

    </script>

</body>
</html>
