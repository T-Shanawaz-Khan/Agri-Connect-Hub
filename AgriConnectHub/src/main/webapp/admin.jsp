<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
  <style>
    /* Style for header */
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #333;
      color: white;
      padding: 10px 20px;
    }
    .header .homeIcon {
      cursor: pointer;
    }
    .header .logoutIcon {
      cursor: pointer;
    }
       /* Style for sidebar */
       .sidebar {
      position: fixed;
      left: -250px; /* Start off-screen */
      width: 250px;
      height: 100%;
      background-color: #333;
      transition: all 0.3s ease;
      z-index: 1;
    }
    .admin-profile img {
  width: 100px; /* Adjust size as needed */
  height: 100px; /* Adjust size as needed */
  border-radius: 50%; /* Makes the image round */
  
  

}
    .admin-profile h6{
        color:white ;
        padding: 25px;
    }
    .sidebar.show {
      left: 0;
    }
    .sidebar ul {
      list-style-type: none;
      padding: 0;
    }
    .sidebar ul li {
      padding: 10px 20px;
      color: white;
      cursor: pointer;
    }
    .sidebar ul li:hover {
      background-color: #555;
    }
    canvas {
    height: 200px !important; /* Adjust the height as needed */
    width: 200px !important; /* Adjust the width as needed */
  }
  </style>
</head>
<body>

  <!-- Header with home and logout icons -->
  <div class="header">
    <div class="homeIcon" onclick="toggleSidebar()">
      <i class="fa fa-home"></i> Home
    </div>
    <div class="logoutIcon" onclick="logout()">
      <a href="Logout"><i class="fa fa-sign-out"></i>Logout</a>
    </div>
  </div>

  <!-- Sidebar -->
  <div id="sidebar" class="sidebar">
    <div class="admin-profile">
        <img src="images/admin background.jpg" alt="Admin Profile Picture">
        <h6>ADMIN</h6>
      </div>
    <ul>
      <li><i class="fa fa-users"></i> Users</li>
      <li><i class="fa fa-th-large"></i> Products</li>
      <li><i class="fa fa-th"></i> Blogs</li>
      <li><i class="fa fa-list"></i> UserContacts</li>
      <li><i class="fa fa-th"></i>Report</li>
    </ul>
  </div>

 
<!-- Page Content -->
<div id="main-content" class="container allContent-section py-4">
  <div class="row">
    <div class="col-sm-3">
      <div class="card">
        <i class="fa fa-users mb-2" style="font-size: 70px;"></i>
        <h4>Total Users</h4>
        <h5 id="totalUsers">...</h5> <!-- Placeholder for total users -->
      </div>
    </div>
    <div class="col-sm-3">
      <div class="card">
        <i class="fa fa-th-large mb-2" style="font-size: 70px;"></i>
        <h4>Total Products</h4>
        <h5 id="totalProducts">...</h5> <!-- Placeholder for total products -->
      </div>
    </div>
    <div class="col-sm-3">
      <div class="card">
        <i class="fa fa-th mb-2" style="font-size: 70px;"></i>
        <h4>Total Blogs</h4>
        <h5 id="totalBlogs">...</h5> <!-- Placeholder for total blogs -->
      </div>
    </div>
    <div class="col-sm-3">
      <div class="card">
        <i class="fa fa-list mb-2" style="font-size: 70px;"></i>
        <h4>page activity</h4>
        <h5>50</h5>
      </div>
    </div>
  </div>
  <!-- Users Section -->
    <div id="usersSection" style="display: none;">
      <h2>Users</h2>
      <table id="usersTable" class="table">
        <thead>
  			<tr>
    			<th>User ID</th>
    			<th>Name</th>
    			<th>Email</th>
    			<th>Verified</th>
    			<th>Action</th> <!-- Column for delete button -->
  			</tr>
		</thead>
        <tbody>
          <!-- Table body will be populated dynamically using JavaScript -->
        </tbody>
      </table>
    </div>

    <!-- Products Section -->
    <div id="productsSection" style="display: none;">
      <h2>Products</h2>
      <table id="productsTable" class="table">
        <thead>
  			<tr>
    			<th>Product ID</th>
    			<th>Name</th>
    			
    			<th>Price</th>
    			<th>Added by</th>
        		<th>Action</th> <!-- Column for delete button -->
  			</tr>
		</thead>
        <tbody>
          <!-- Table body will be populated dynamically using JavaScript -->
        </tbody>
      </table>
    </div>
    <!-- Blogs Section -->
    <div id="blogsSection" style="display: none;">
      <h2>Products</h2>
      <table id="blogsTable" class="table">
        <thead>
  			<tr>
    			<th>Blog ID</th>
    			<th>Name</th>
    			<th>Added by</th>
        		<th>Action</th> <!-- Column for delete button -->
  			</tr>
		</thead>
        <tbody>
          <!-- Table body will be populated dynamically using JavaScript -->
        </tbody>
      </table>
    </div>
    <!-- User contacts Section -->
    <div id="contactsSection" style="display: none;">
      <h2>Products</h2>
      <table id="contactsTable" class="table">
        <thead>
  			<tr>
    			<th>username</th>
        		<th>contact</th>
        		<th>product_id</th>
  			</tr>
		</thead>
        <tbody>
          <!-- Table body will be populated dynamically using JavaScript -->
        </tbody>
      </table>
    </div>
<!-- Page Content -->
  <div class="row">
    <!-- Graphs Section -->
    <div id="graphSection" style="display: none;" class="col-sm-12">
      <h2 class="mb-4">Reports</h2>
      <div class="row">
        <div class="col-sm-4">
          <h4 class="mb-3">User Count</h4>
          <canvas id="userGraph" style="height: 200px; width: 200px;"></canvas>
        </div>
        <div class="col-sm-4">
          <h4 class="mb-3">Product Count</h4>
          <canvas id="productGraph" style="height: 200px; width: 200px;"></canvas>
        </div>
        <div class="col-sm-4">
          <h4 class="mb-3">Blog Count</h4>
          <canvas id="blogGraph" style="height: 200px; width: 200px;"></canvas>
        </div>
      </div>
    </div>
  </div>
  </div>



<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


  
  <!-- Scripts -->
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script>
    function toggleSidebar() {
      $("#sidebar").toggleClass("show");
    }
    $(document).ready(function() {
    	  // Function to show/hide sections based on sidebar option clicked
    	  $('.sidebar ul li').click(function() {
    	    // Hide all sections first
    	    $('#usersSection, #productsSection, #blogsSection, #contactsSection,#graphSection').hide();
    	    
    	    // Check which sidebar option is clicked and show the corresponding section
    	    if ($(this).text().trim() === 'Users') {
    	      $('#usersSection').show();
    	      fetchUsersData(); // Call a function to fetch and populate the users table
    	    } else if ($(this).text().trim() === 'Products') {
    	      $('#productsSection').show();
    	      fetchProductsData(); // Call a function to fetch and populate the products table
    	    } else if ($(this).text().trim() === 'Blogs') {
    	      $('#blogsSection').show();
    	      fetchBlogsData(); // Call a function to fetch and populate the blogs table
    	    } else if ($(this).text().trim() === 'UserContacts') {
    	      $('#contactsSection').show();
    	      fetchContactsData(); // Call a function to fetch and populate the user contacts table
    	    }
    	    else if ($(this).text().trim() === 'Report') {
    	        $('#graphSection').show();
    	        generateReports(); // Call function to generate reports
    	      }
    	  });
    	});

    // Function to fetch data and generate graphs
    function generateReports() {
      // AJAX request to fetch data for graphs
      $.ajax({
        url: 'ReportDataServlet',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
          // Data received successfully, now generate graphs
          generateUserGraph(data.userCountByMonth);
          generateProductGraph(data.productCountByMonth);
          generateBlogGraph(data.blogCountByMonth);
        },
        error: function(xhr, status, error) {
          console.error('Error fetching report data:', error);
        }
      });
    }

 // Function to generate user count graph as a bar graph
    function generateUserGraph(data) {
      var ctx = document.getElementById('userGraph').getContext('2d');
      var userGraph = new Chart(ctx, {
        type: 'bar', // Change the type to bar
        data: {
          labels: Object.keys(data),
          datasets: [{
            label: 'Number of Users',
            data: Object.values(data),
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true,
                stepSize: 1, // Set step size to 1 to display only integer values
                precision: 0 
              }
            }]
          }
        }
      });
    }

    // Function to generate product count graph as a bar graph
    function generateProductGraph(data) {
      var ctx = document.getElementById('productGraph').getContext('2d');
      var productGraph = new Chart(ctx, {
        type: 'bar', // Change the type to bar
        data: {
          labels: Object.keys(data),
          datasets: [{
            label: 'Number of Products',
            data: Object.values(data),
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true,
                stepSize: 1 // Set step size to 1 to display only integer values
              }
            }]
          }
        }
      });
    }

    // Function to generate blog count graph as a bar graph
    function generateBlogGraph(data) {
      var ctx = document.getElementById('blogGraph').getContext('2d');
      var blogGraph = new Chart(ctx, {
        type: 'bar', // Change the type to bar
        data: {
          labels: Object.keys(data),
          datasets: [{
            label: 'Number of Blogs',
            data: Object.values(data),
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)',
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true,
                stepSize: 1 // Set step size to 1 to display only integer values
              }
            }]
          }
        }
      });
    }




    function updateTotalNumbers() {
        fetch('DataServlet')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                // Update total numbers
                $('#totalUsers').text(data.totalUsers);
                $('#totalProducts').text(data.totalProducts);
                $('#totalBlogs').text(data.totalBlogs);
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }

    // Call the function initially and set an interval for periodic updates
    updateTotalNumbers();
    setInterval(updateTotalNumbers, 5000); // Update every 5 seconds (adjust as needed)
 // Function to fetch and populate users table
    function fetchUsersData() {
  $.ajax({
    url: 'UserDataServlet',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
      // Clear existing rows from the table
      $('#usersTable tbody').empty();
      
      // Populate the table with data
      data.forEach(user => {
    	  var userId = user.userId;
    	  var name = user.name;
    	  var email = user.email;
    	  var newRow = '<tr>' +
    	                '<td>' + userId + '</td>' +
    	                '<td>' + name + '</td>' +
    	                '<td>' + email + '</td>' +
    	                '<td>yes</td>' +
    	                '<td><button onclick="deleteUser(\'' + name + '\')">Delete</button></td>' +
    	              '</tr>';
    	  $('#usersTable tbody').append(newRow);
    	});
    },
    error: function(xhr, status, error) {
      console.error('Error fetching users data:', error);
    }
  });
}
    
    function fetchProductsData() {
    	  $.ajax({
    	    url: 'ProductDataServlet',
    	    type: 'GET',
    	    dataType: 'json',
    	    success: function(data) {
    	      // Clear existing rows from the table
    	      console.log(data);
    	      $('#productsTable tbody').empty();
    	      
    	      // Populate the table with data
    	      data.forEach(product => {
    	    	  var Id = product.productId;
    	    	  var name = product.name;
    	    	  var price = product.price;
    	    	  var uname=product.uname;
    	    	  var newRow = '<tr>' +
    	    	                '<td>' + Id + '</td>' +
    	    	                '<td>' + name + '</td>' +
    	    	                '<td>' + price + '</td>' +
    	    	                '<td>' + uname + '</td>' +
    	    	                '<td><button onclick="deleteProduct(' + Id + ')">Delete</button></td>' +
    	    	              '</tr>';
    	    	  $('#productsTable tbody').append(newRow);
    	    	});
    	    },
    	    error: function(xhr, status, error) {
    	      console.error('Error fetching users data:', error);
    	    }
    	  });
    	}
    function fetchBlogsData() {
  	  $.ajax({
  	    url: 'BlogDataServlet',
  	    type: 'GET',
  	    dataType: 'json',
  	    success: function(data) {
  	      // Clear existing rows from the table
  	      console.log(data);
  	      $('#blogsTable tbody').empty();
  	      
  	      // Populate the table with data
  	      data.forEach(blog => {
  	    	  var Id = blog.blogId;
  	    	  var name = blog.title;
  	    	  var uname=blog.uname;
  	    	  var newRow = '<tr>' +
  	    	                '<td>' + Id + '</td>' +
  	    	                '<td>' + name + '</td>' +
  	    	                '<td>' + uname + '</td>' +
  	    	                '<td><button onclick="deleteBlog(' + Id + ')">Delete</button></td>' +
  	    	              '</tr>';
  	    	  $('#blogsTable tbody').append(newRow);
  	    	});
  	    },
  	    error: function(xhr, status, error) {
  	      console.error('Error fetching users data:', error);
  	    }
  	  });
  	}
    function fetchContactsData() {
    	  $.ajax({
    	    url: 'ContactDataServlet',
    	    type: 'GET',
    	    dataType: 'json',
    	    success: function(data) {
    	      // Clear existing rows from the table
    	      console.log(data);
    	      $('#contactsTable tbody').empty();
    	      
    	      // Populate the table with data
    	      data.forEach(contact => {
    	    	  var name = contact.username;
    	    	  var conName=contact.contact;
    	    	  var productId=contact.product_id;
    	    	  var newRow = '<tr>' +
    	    	                '<td>' + name + '</td>' +
    	    	                '<td>' + conName + '</td>' +
    	    	                '<td>' + productId + '</td>' +
    	    	              '</tr>';
    	    	  $('#contactsTable tbody').append(newRow);
    	    	});
    	    },
    	    error: function(xhr, status, error) {
    	      console.error('Error fetching users data:', error);
    	    }
    	  });
    	}
    function deleteUser(userName) {
        // Send AJAX request to delete the product with productId from the shopping cart table
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    // Product deleted successfully
                    console.log("User deleted successfully.");
                    
                } else {
                    console.error('Error deleting User. Status:', xhr.status);
                }
            }
        };
        xhr.open('POST', 'deleteUser', true); // Adjust the URL and method as per your server-side implementation
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.send('userName=' + userName);
    }
    function deleteProduct(productId) {
        // Send AJAX request to delete the product with productId from the shopping cart table
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState == 4) {
                if (xhr.status == 200) {
                    // Product deleted successfully
                    console.log("Product deleted successfully.");
                    
                } else {
                    console.error('Error deleting product. Status:', xhr.status);
                }
            }
        };
        xhr.open('POST', 'deleteProduct', true); // Adjust the URL and method as per your server-side implementation
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.send('productId=' + productId);
    }
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
        xhr.open('POST', 'deleteBlog', true); // Adjust the URL and method as per your server-side implementation
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhr.send('blogId=' + blogId);
    }



  </script>
</body>
</html>
