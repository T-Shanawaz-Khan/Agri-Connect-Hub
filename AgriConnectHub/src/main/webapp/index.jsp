<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("farmer_login.jsp");
	}

%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String userName = (String) userSession.getAttribute("name");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agri-Connect Hub</title>
    <link rel="stylesheet" href="search.css">
    
    <style>
        /* Reset some default styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Set a background color for the body */
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
            margin: 0;
            padding: 0;
            background-color: #000000;
            font-family: Arial, sans-serif;
            overflow-x: hidden;
        }

        /* Style for the welcome message text */
        .welcome-message {
            background: url("images/homeimg.jpg") center/cover no-repeat;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: #061412;
            height: 100vh;
        }

        .welcome-message h1 {
            font-size: 36px;
            margin: 20px 0;
        }
        .welcome-message h1:hover {
            transform: translateZ(-50%);
        }

        .welcome-message p {
            font-size: 24px;
            margin-bottom: 30px;
        }

        .contact-button {
            background-color: #6b6f6e; 
            color: #e1d3d3; 
            padding: 10px 20px; 
            border: none; 
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px; 
            transition: background-color 0.2s; 
        }

        /* Hover effect for the button */
        .contact-button:hover {
            background-color: #00ccaa; 
        }
                
        @keyframes showcontent{
            from{
                opacity: 0;
                transform: translate(0,100px);
                filter:blur(33px);
            }to{
                opacity: 1;
                transform: translate(0,0);
                filter:blur(0);
            }
        }
        .buttons{
            position: absolute;
            bottom:30px;
            z-index: 8888;
            text-align: center;
            width:100%;
        }
        .buttons button{
            width:50px;
            height:50px;
            border-radius: 50%;
            border:1px solid #555;
            transition: 0.5s;
        }.buttons button:hover{
            background-color: #bac383;
        }
        

section{
    min-height: 50vh;
    padding: 10rem 9% 2rem;
}

.services h2{
    margin-bottom: 2rem;
  }
  .services{
    padding: 5rem 2rem;
  }
  
  .services-container{
      display: flex;
      justify-content: center;
      align-items: center;
      flex-wrap: wrap;
      gap: 2rem;
  }
  
  .services-container .services-box{
      flex: 1 1 30rem;
      background: #323946;
      padding: 3rem 2rem 4rem;
      border-radius: 2rem;
      text-align: center;
      border: .2rem solid #0a0a0a;
      transition: .5s ease;
  }
  
  .services-container .services-box:hover {
     border-color: #00ffdd;
     transform: scale(1.02);
  }
  
  .services-box i {
      font-size: 5rem;
      color: #00ffdd;
  }
  
  .services-box h3{
      font-size: 1.8rem;
  }
  
  .services-box p{
      font-size: 1.1rem;
      margin: 1rem 0 3rem;
  }

  .division-1 {
    /* Style for the first division */
    display: flex;
    justify-content: center;
    align-items: center;
    padding: .5rem;
    width: 50%;
    gap: 1rem;
}



.card-text {
    /* Style for the text beside the larger card */
    margin-top: 2rem; /* Add margin */
    color: white;
    font-size: 13px;
    text-align: justify;
    word-spacing: -1px;
    line-height: 25px;
}

.division-2 {
    /* Style for the second division */
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    flex-direction: row;
    gap: 1rem;
}

.card {
    /* Common styling for all cards */
    position: relative;
    width: 200px;
    height: 300px;
    border-radius: 7px;
    /* Add other styles like background, border, etc. */
}
.card:hover {
    border: 2px solid #00ccaa;
    border-color: #00ffdd;
    transform: scale(1.06);
}
.divs{
    padding: 1.4rem 2rem 3rem 2rem;
}

.div-containers{
    display: flex;
    justify-content: space-between;
    align-items: center;
    column-width: 50%;
}


.divs h2{
    margin-bottom: 2rem;
}


.larger-card {
    /* Style for the larger card */
    background-image: url("images/p1.png");
    background-size: cover;
    width: 2200px;
    height: 300px;
}

.smaller-card {
    /* Style for the smaller cards */
    background-image: url("images/p22.jpg");
    background-color: #00ccaa;
    object-fit: cover;
}


.card-overlay {
    /* Style for the overlay on hover */
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.4); /* Semi-transparent background */
    display: none;
    text-align: center;
    font-size: 25px;
    /* Add other styles for text alignment, color, etc. */
}

.card:hover .card-overlay {
    /* Show overlay on hover */
    display: block;
}

.heading {
    text-align: center;
    font-size: 4.5rem;
    margin-top: 0;
    color: #00ffdd;
}

.footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    padding: 2rem 9%;
    background: var(--second-bgcolor);
}

.footer-text p {
    font-size: 1.6rem;
}

.footer-iconTop a {
    display: inline-block;
    justify-content: center;
    align-items: center;
    padding: .8rem;
    background: var(--main-color);
    border-radius: .8rem;
    transition: .5s ease;
}

.footer-iconTop a:hover {
    box-shadow: 0 0 1rem var(--main-color);
}

.footer-iconTop a i {
    font-size: 2.4rem;
    color: var(--second-bgcolor);
}

.sticky {
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 10000;
    background-color: #000000;
  }

        /* Style for the footer */
        footer {
            background-color: #00ffdd;
            text-align: center;
            padding: 10px;
        }


        img {
            width: 100%;
            height: 100%;
        }
        
        /* Additional styles for Simple Slideshow */
        .simple-slideshow {
            margin-top: 10px;
            color: #00ffdd;
            padding: 1.5rem;
            background: linear-gradient(to left, #00ffdd, transparent);
            height: 80vh; /* Set the height to 100% of the viewport height */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        
        .slideshow-container {
            max-width: 100%;
            position: relative;
            width: 100%; /* Adjust the width as needed */
            max-height: 100vh; /* Adjust the maximum height as needed */
            overflow: hidden;
        }

        .slide-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: #fff;
            z-index: 1;
        }
        
        .slide-text h2 {
            font-size: 50px;
            margin-bottom: 10px;
            color: black;
        }
        
        .slide-text p {
            font-size: 30px;
            color: #323946;
        }
        
        .prev,
        .next {
            position: absolute;
            top: 50%;
            width: auto;
            padding: 16px;
            margin-top: -22px;
            color: #00ffdd;
            font-size: 24px;
            cursor: pointer;
            user-select: none;
        }
        
        .prev {
            left: 16px;
        }
        
        .next {
            right: 16px;
        }

        footer {
            background-color: #00ffdd;
            color: #fff;
            padding: 20px 0;
            font-size: 14px;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        
        .footer-logo img {
            max-width: 100px;
        }
        
        .footer-links ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }
        
        .footer-links li {
            display: inline;
            margin-right: 20px;
        }
        
        .footer-links a {
            color: #333;
            text-decoration: none;
        }
        
        .footer-social a {
            color: #333;
            text-decoration: none;
            margin-right: 10px;
        }
        
        .footer-bottom {
            background-color: #333;
            text-align: center;
            padding: 10px 0px;
            margin: 30px 0px 0px 0px;
        }
        
    </style>
</head>



<!--------Body-------->>
<body>

	<nav class="navbar">
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
    </nav>
    <div id="searchResults" class="blog-grid">
    <!-- Search results will be dynamically added here -->
	</div>
	<div id="mainContent">
    <section class="welcome-message"> 
            <div class="welcome-message" style="background-size: 100% 100%; color: #000000; display:flex; align-items:center; justify-content:center; background-position: center; height: 50vh; background:none;">
                <h1>Welcome to Agri-Connect Hub</h1>
                <p><i>Your One-Stop Shop for Quality Farming Tools and Equipment</i></p>
                <p><i>Discover the best deals on a wide range of farming tools and equipment</i></p>
                <button class="contact-button">Contact Us</button>
            </div>
    </section>
    
    <section class="simple-slideshow">
        <div class="slideshow-container">
            <div class="slide fade">
                <img src="images/img3.jpg" alt="Slide 1" style="width:100%; height:100%; object-fit:cover;">
                <div class="slide-text">
                    <h2>Cultivating Community Bonds</h2>
                    <p style="color: white;">Foster Stronger Relationships, Share Knowledge, and Support Fellow Farmers in Our Community.</p>
                </div>
            </div>
            <div class="slide fade">
                <img src="images/img1.jpeg" alt="Slide 2" style="width:100%; height:100%; object-fit:cover;">
                <div class="slide-text">
                    <h2>Connecting Farmers, Cultivating Growth</h2>
                    <p style="color: white;">Through Shared Experiences and Knowledge Exchange, Our Community Paves the Way for Collective Growth and Success.</p>
                </div>
            </div>
            <div class="slide fade">
                <img src="images/img2.jpg" alt="Slide 3" style="width:100%; height:100%; object-fit:cover;">
                <div class="slide-text">
                    <h2>Collaborative Farming Solutions</h2>
                    <p style="color: white;"> Collaborate, Innovate, and Find Solutions Together with Like-Minded Farmers in Our Vibrant Community.</p>
                </div>
            </div>
            <!-- Navigation arrows -->
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>
    </section>

       
    <section class="services" id="services">
        <h2 class="heading"><span>Blogs & Discussion Forum</span></h2>
    
        <div class="services-container">
    
            <div class="services-box">
                <i class="far fa-newspaper"></i>
                <h3>Blogs</h3>
                <p>Our blog section is dedicated to providing you with valuable insights, tips, and news related to agriculture, farming practices, success stories
                     and rural development. <br><br>
                    What can you expect : <b style="color: rgb(141, 141, 23);">Success Stories,Practical Tips,Industrial News.</b>
                </p>
                <a href="blogs.jsp" target="_blank" class="btn" style="color: #00ffdd; text-decoration:none; font-size:large"><b>More</b></a>
            </div>
    
            <div class="services-box">
                <i class="fas fa-comments"></i>
                <h3>Discussion Forum</h3>
                <p>Our discussion forum is the perfect place for farmers, agriculture enthusiasts, and industry experts to come together, share knowledge, and engage in meaningful conversations.<br><br> What can you expect: <b style="color: rgb(141, 141, 23);">Knowledge Sharing and Problem Solving.</b>
                </p>
                <a href="chatAPP.jsp" target="_blank" class="btn" style="color: #00ffdd; text-decoration:none; font-size:large"><b>More</b></a>
            </div>
    
        </div>
       </section>

       <!----product cards---->
       <section class="divs">

        <h2 class="heading"><span>Products</span></h2>

        <div class="div-containers">
        <div class="division-1">
            <!-- Larger card with hover effect -->
            <div class="card larger-card">
                <div class="card-overlay">
                    <!-- Additional text on hover -->
                    <h2> Combine Harvester</h2>
                    <p>The modern combine harvester, or simply combine, is a machine designed to harvest a variety of grain crops.</p>
                </div>
            </div>
            <div class="card-text">
                <h2 style="color: white; font-size:medium;"><i>Explore our diverse range of high-quality products designed to meet the needs of farmers and agricultural enthusiasts alike. From essential tools and equipment to innovative solutions that streamline farming processes. we have everything you need to optimize your operations and achieve greater yields.</i> </h2>
            </div>
        </div>
        <div class="division-2">
            <!-- Four smaller cards with hover effect -->
            <div class="card smaller-card" style="background-image: url('images/p2.webp'); background-size:cover;">
                <div class="card-content">
                    <!-- Content of the first smaller card -->
                </div>
                <div class="card-overlay">
                    <!-- Additional text on hover -->
                    <h2 style="align-items: center; margin-top:2rem;">Manure Spreader</h2>
                    <p style="align-items: center; margin-top:2rem; color:white;">Hello this is Suresh. My name is Khan. May I know Your name Suresh?</p>
                </div>
            </div>
            <div class="card smaller-card" style="background-image: url('images/p33.png'); background-size:cover;">
                <div class="card-content">
                    <!-- Content of the first smaller card -->
                </div>
                <div class="card-overlay">
                    <!-- Additional text on hover -->
                    <h2 style="align-items: center; margin-top:2rem;">Cultivator</h2>
                    <p style="align-items: center; margin-top:2rem; color:white;">Hello this is Suresh. My name is Khan. May I know Your name Suresh?</p>
                </div>
            </div>
            <div class="card smaller-card" style="background-image: url('images/p22.jpg'); background-size:cover;">
                <div class="card-content">
                    <!-- Content of the first smaller card -->
                </div>
                <div class="card-overlay">
                    <!-- Additional text on hover -->
                    <h2 style="align-items: center; margin-top:2rem;">Sickle</h2>
                    <p style="align-items: center; margin-top:2rem; color:white;">Hello this is Suresh. My name is Khan. May I know Your name Suresh?</p>
                </div>
            </div>
            
        </div>
        </div>
    </section>
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
    <script src="https://unpkg.com/scrollreveal@3.3.2/dist/scrollreveal.min.js"></script>
    <script>

        ScrollReveal({
            //reset: true,
            distance: '80px',
            duration: 2000,
            delay: 200
        });
        
        ScrollReveal().reveal('.welcome-message p, .welcome-message h1,.contact-button', { origin: 'top',opacity: 0.1,color:'black'});

        //sticky navbar
        

    let slideIndex = 0;

    function showSlides() {
        let slides = document.getElementsByClassName("slide fade");
        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }

        slideIndex++;
        if (slideIndex > slides.length) {
            slideIndex = 1;
        }

        slides[slideIndex - 1].style.display = "block";
        setTimeout(showSlides, 3000); // Change this value to adjust the interval time in milliseconds
    }

    // Next/previous controls
    function plusSlides(n) {
        showSlides((slideIndex += n));
    }

    // Start the slideshow when the page loads
    showSlides();
    </script>
</body>
</html>
