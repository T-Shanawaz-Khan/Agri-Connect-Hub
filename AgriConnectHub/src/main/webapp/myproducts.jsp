<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String userName = (String) userSession.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>myproducts</title>
    
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
            top: 100%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border: 2px solid #f06;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
        }

        .close {
            position: absolute;
            top: 0;
            right: 0;
            padding: 10px;
            cursor: pointer;
        }
        #add-product-form label {
    color: #f06; /* Label text color */
    display: block;
    margin-bottom: 10px;
    font-weight: bold;
}

#add-product-form input[type="text"],
#add-product-form input[type="number"],
#add-product-form textarea,
#add-product-form button {
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ccc;
    width: 100%;
    margin-bottom: 20px;
    font-size: 16px;
}

#add-product-form button {
    background-color: #f06; /* Button background color */
    color: #fff; /* Button text color */
    border: none;
    padding: 12px 24px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#add-product-form button:hover {
    background-color: #ff3333; /* Button hover background color */
}
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 20px;
            justify-content: center;
        }

        .product {
            position: relative;
            display: grid;
            grid-template-columns: 1fr 2fr;
            background-color: #333;
            border: 2px solid #f06;
            border-radius: 10px;
            overflow: hidden;
            width: 100%;
            box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s;
            cursor: pointer;
        }

        .product:hover {
            transform: scale(1.03);
        }

        .product-image {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .product-image img {
            max-width: 100%;
            max-height: 100%;
        }

        .product-details {
            padding: 20px;
        }

        .product-details h2 {
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
            top: 95%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fff;
            border: 2px solid #f06;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
        }

        .close {
            position: absolute;
            top: 0;
            right: 0;
            padding: 10px;
            cursor: pointer;
        }

        /* Additional Styles */
        .buy-rent-button {
            background-color: #f06;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .buy-rent-button:hover {
            background-color: #ff3333;
        }

        .star-rating {
            font-size: 24px;
        }

        .star {
            color: #f06; /* Filled star color */
        }

        .empty-star {
            color: #ccc; /* Empty star color */
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
        /* Add styling for input fields and buttons */
.modal-content input[type="text"],
.modal-content input[type="number"],
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
	
    <h1> Your Product</h1>
    <div id="product-container" class="product-grid">
        <!-- Product listings will be added dynamically by JavaScript -->
    </div>
    <div id="product-modal" class="modal">
        <div class="modal-content">
            <span class="close" id="close-modal">&times;</span>
            <div id="modal-product-image" class="product-image">
                <img src="" alt="">
            </div>
            <div id="modal-product-details" class="product-details">
                <h2></h2>
                <h4>Price:</h4>
                <p id="modal-product-description">Description: </p>
                <button id="buy-rent-button" class="buy-rent-button">add to kart</button>
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
        <div id="edit-product-modal" class="modal">
    <div class="modal-content">
        <span class="close" id="close-edit-modal">&times;</span>
        <h2>Edit Product</h2>
        <form action="editProductServlet" method="post" enctype="multipart/form-data">
        	<div class="input-container">
		            <label for="name">title:</label>
		            <input type="text" id="name" name="name"  >
		        </div>
		        
		        <div class="input-container">
		            <label for="price">Price:</label>
		            <input type="number" id="price" name="price"  >
		        </div>
		        <div class="input-container">
		            <label for="description">Content:</label>
            		<textarea id="description" name="description" rows="4"></textarea>		        </div>
		        <div class="input-container">
		            <img id="edit-Product-image-preview" src="" alt="Image Preview" style="max-width: 100%; max-height: 200px; margin-bottom: 10px;">
            
    				<label for="imageSrc">Replace Image:</label>
    				<input type="file" id="imageSrc" name="imageSrc" accept="Product_image/*">
    				
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
        // script.js
        function addProduct(id,name, price, imageSrc, description) {
            const productContainer = document.getElementById("product-container");

            const productListing = document.createElement("div");
            productListing.classList.add("product");

            const productImageContainer = document.createElement("div");
            productImageContainer.classList.add("product-image");

            const productImage = document.createElement("img");
            productImage.src = imageSrc;
            productImage.alt = name + " Image";

            const productDetails = document.createElement("div");
            productDetails.classList.add("product-details");

            const productName = document.createElement("h2");
            productName.textContent = name;
            
            const productPrice = document.createElement("h4");
            productPrice.textContent ="Price: \u20B9" + price;;
            
            const productDescription = document.createElement("p");
            productDescription.textContent = "Description: " + description;
            
            
            
            const buttonsContainer = document.createElement("div");
            buttonsContainer.classList.add("buttons-container");
            
            const editButton = document.createElement("button");
            editButton.textContent = "Edit";
            editButton.classList.add("edit-button"); // Add specific class for edit button
            editButton.addEventListener("click", (event) => {
                event.stopPropagation(); // Stop event propagation
                editProduct(id);
            }); // Call editBlog function with blog id

            const deleteButton = document.createElement("button");
            deleteButton.textContent = "Delete";
            deleteButton.classList.add("delete-button"); // Add specific class for delete button
            deleteButton.addEventListener("click", (event) => {
                event.stopPropagation(); // Stop event propagation
                deleteProduct(id);
            });
            
            buttonsContainer.appendChild(editButton);
            buttonsContainer.appendChild(deleteButton);


            productImageContainer.appendChild(productImage);
            productDetails.appendChild(productName);

            productDetails.appendChild(productPrice);
            productDetails.appendChild(productDescription);

            productListing.appendChild(productImageContainer);
            productListing.appendChild(productDetails);
            productDetails.appendChild(buttonsContainer);

            productContainer.appendChild(productListing);

            // Add a click event listener to each product card
            productListing.addEventListener("click", () => {
                // Show the modal with product details
                const modal = document.getElementById("product-modal");
                const modalProductImage = document.getElementById("modal-product-image");
                const modalProductName = document.querySelector("#modal-product-details h2");
                const modalProductPrice = document.querySelector("#modal-product-details h4"); 
                const modalProductDescription = document.getElementById("modal-product-description");
                const modalStarRating = document.querySelector("#modal-product-details .star-rating");
                const modalReviews = document.getElementById("modal-reviews");
                const userRatingInput = document.getElementById("rating");
                const userReviewInput = document.getElementById("user-review");
                const submitReviewButton = document.getElementById("submit-review");

                modalProductImage.innerHTML = productImageContainer.innerHTML;
                modalProductName.textContent = productName.textContent;

                modalProductPrice.textContent = "Price: \u20B9" + price;
                modalProductDescription.textContent = productDescription.textContent;

                // Set a default star rating (4 out of 5 stars)
                modalStarRating.innerHTML = "Star Rating: ";
                for (let i = 0; i < 4; i++) {
                    modalStarRating.innerHTML += "<span class='star'>&#9733;</span>";
                }
                for (let i = 0; i < 1; i++) {
                    modalStarRating.innerHTML += "<span class='empty-star'>&#9733;</span>";
                }

                // Add a default review
                const defaultReview = document.createElement("div");
                defaultReview.classList.add("review");
                defaultReview.innerHTML = "<p>Example Review: This is a great product!</p>";
                modalReviews.innerHTML = "";
                modalReviews.appendChild(defaultReview);

                // Clear user input fields
                userRatingInput.value = "";
                userReviewInput.value = "";

                // Handle review submission
                submitReviewButton.addEventListener("click", () => {
                    const userRating = userRatingInput.value;
                    const userReview = userReviewInput.value;

                    // Check if userRating and userReview are provided and within valid ranges
                    if (userRating >= 1 && userRating <= 5 && userReview) {
                        const userReviewElement = document.createElement("div");
                        userReviewElement.classList.add("review");
                        userReviewElement.innerHTML = `<p>Rating: ${userRating}/5</p><p>${userReview}</p>`;
                        modalReviews.appendChild(userReviewElement);

                        // Clear user input fields
                        userRatingInput.value = "";
                        userReviewInput.value = "";
                    }
                });

                modal.style.display = "block";
            });
        }

        // Close the modal when the close button is clicked
        document.getElementById("close-modal").addEventListener("click", () => {
            const modal = document.getElementById("product-modal");
            modal.style.display = "none";
        });

        // Close the modal when clicking outside of it
        window.addEventListener("click", (event) => {
            const modal = document.getElementById("product-modal");
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });
    </script>
    <script>
    // Function to fetch product data from the server
function fetchProductData() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                var data = JSON.parse(xhr.responseText);
                // Assuming data is an array of product objects
                data.forEach(product => {
                    addProduct(product.id,product.name, product.price, product.imageSrc, product.description);
                });
            } else {
                console.error('Error fetching product data. Status:', xhr.status);
            }
        }
    };

    xhr.open('GET', 'myProducts', true);
    xhr.send();
}

// Call the fetchProductData function when the page loads
window.addEventListener('load', fetchProductData);

function editProduct(id) {
	console.log(id);
    // Get the blog information from the server using AJAX
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                var product = JSON.parse(xhr.responseText);
                displayEditPopup(product);
                
            } else {
                console.error('Error fetching blog data for editing. Status:', xhr.status);
            }
        }
    };

    xhr.open('GET', 'editProductServlet?id=' + id, true); // Assuming there's an endpoint to fetch blog info by id

    xhr.send();
}

function displayEditPopup(product) {
    // Display the modal popup for editing the blog
    const modal = document.getElementById("edit-product-modal");
    const productNameInput = document.getElementById("name");
    const productPriceInput = document.getElementById("price");
    const ProductDescriptionInput = document.getElementById("description");
    const productImageInput = document.getElementById("imageSrc");
    const productImagePreview = document.getElementById("edit-Product-image-preview");
    console.log(product);
    // Set the input fields with the product information
    productNameInput.value = product.name;
    productPriceInput.value = product.price;
    ProductDescriptionInput.value = product.description;
    productImagePreview.src = product.imageSrc;
    

    // Show the modal
    modal.style.display = "block";
    
    productImageInput.addEventListener("change", function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                productImagePreview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
}
function deleteProduct(productId) {
    // Send AJAX request to delete the product with productId from the shopping cart table
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                // Product deleted successfully
                console.log("Product deleted successfully.");
                window.location.reload();
                
            } else {
                console.error('Error deleting product. Status:', xhr.status);
            }
        }
    };
    xhr.open('POST', 'deleteProduct', true); // Adjust the URL and method as per your server-side implementation
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xhr.send('productId=' + productId);
}

// Close the edit modal when the close button is clicked
document.getElementById("close-edit-modal").addEventListener("click", () => {
    const modal = document.getElementById("edit-product-modal");
    modal.style.display = "none";
});

// Close the edit modal when clicking outside of it
window.addEventListener("click", (event) => {
    const modal = document.getElementById("edit-product-modal");
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
