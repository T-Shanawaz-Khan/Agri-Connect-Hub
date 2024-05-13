<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%
	if(session.getAttribute("name")==null){
		response.sendRedirect("farmer_login.jsp");
	}
    String highlightUserId = request.getParameter("highlightUserId");
    if (highlightUserId == null || highlightUserId.isEmpty()) {
        highlightUserId = "";
    }
%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    HttpSession userSession = request.getSession(false);
    String userName = (String) userSession.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>community</title>

    <link rel="stylesheet" href="search.css">
<style>

	* {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body {
    height: 100%;
    margin: 0;
    overflow: hidden; /* Prevent scrolling of the entire page */
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
        

.contact-list {
    margin-top: 20px;
}

.contact {
    cursor: pointer;
    margin-bottom: 10px;
}

.contact-info {
    display: flex;
    align-items: center;
}

.contact-info img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin-right: 10px;
}

.contact-name {
    font-weight: bold;
}

.contact-status {
    font-size: 12px;
    color: #ccc;
}
        

.container {
    display: flex;
    height: 100%;
    overflow: hidden; /* Prevent scrolling of the entire container */
}

.sidebar {
    width: 20%;
    background-color: #333;
    color: #fff;
    padding: 20px;
    height: 100vh;
    overflow-y: auto;
}
#communityLink{
	cursor:pointer;
	color :white;
	padding:10px;
}
.main-content {
    width: 80%;
}

.chat-container {
    background-color: #222;
    color: #fff;
    padding: 20px;
    height: 100vh;
}

        .chat-messages {
            max-height: 100%;
            overflow-y: auto;
            margin-bottom: 20px;
        }
        .message {
            margin-bottom: 10px;
        }
        .current-user-message {
    background-color: #007bff;
    color: white;
    align-self: flex-end;
    margin-left: 50%;
    border-radius: 10px;
}
.current-user-message p{
    color: white;
    
}
.current-user-message p{
    color: white;
    
}

.other-user-message {
    background-color: #e9ecef;
    color: #000000;
    align-self: flex-start;
    margin-right: 50%;
    border-radius: 10px;
}

.user-info {
    display: flex;
    align-items: center;
    margin-bottom: 5px;
}

.user-info img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin-right: 10px;
}

.user-name {
    font-weight: bold;
}

.message-content {
    padding: 10px;
    border-radius: 10px;
    margin: 5px;
}

.timestamp {
    color: #666;
    font-size: 12px;
    margin-top: 5px;
}
.current-user-message .timestamp{
    color: white;
    
}
.chat-container {
    position: fixed;
    bottom: 0;
    right: 0;
    width: 80%; /* Adjust width as needed */
    max-height: 92%; /* Adjust height as needed */
    background-color: #222;
    color: #fff;
    padding: 20px;
    padding-bottom: 60px; /* Add padding to accommodate chat input */
}

.chat-input {
    position: fixed; /* Change position to fixed */
    bottom: 0;
    left: 20%; /* Adjust left position to match sidebar width */
    width: 80%; /* Adjust width to match main content width */
    display: flex;
    align-items: center;
    background-color: #333;
    padding: 10px;
}

#message-input {
    flex: 1;
    padding: 10px;
    border: 2px solid #00ffdd;
    border-radius: 5px;
    background-color: #222;
    color: #fff;
    margin-right: 10px;
}

#send-button {
    border: none;
    background-color: #00ffdd;
    color: #0f0e0e;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
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
    <div class="container">
        <div class="sidebar">
        	<div class="nav-link" id="communityLink" ><i class="fas fa-users"></i> Community</div>
            <h2>Contacts</h2>
            
            <div class="contact-list" id="contact-list">
                <!-- Contacts will be dynamically added here -->
            </div>
        </div>
        <div class="main-content">
            <div class="chat-container">
            	<div class="chat-container" id="groupChatContainer" style="display: none;">
        			<!-- Group message content will be displayed here -->
        			<div class="chat-messages">
                    <!-- Messages will be displayed here -->
                </div>
    			</div>
    			<!-- Individual chat container -->
    			<div class="chat-container" id="individualChatContainer" style="display: none;">
        			<!-- Individual chat content will be displayed here -->
        			<div class="chat-messages">
                    <!-- Messages will be displayed here -->
                </div>
    			</div>
                
                <div class="chat-input">
                    <input type="text" id="message-input" placeholder="Type your message...">
                    <button id="send-button">Send</button>
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
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    
        <script>
        var receiver="";
     // Inside your JavaScript script
     // Variable to store the previously clicked link
     var previousLink = null;
     var previousContact = null;

     // Function to handle click on the community link
     function handleCommunityLinkClick(event) {
         var link = event.currentTarget;
         
         // Remove styling from the previously clicked link
         if (previousLink !== null && previousContact !== null) {
             previousLink.style.backgroundColor = ''; // Remove background color
             previousContact.style.backgroundColor = '';
         }
         // Apply background color to the clicked link
         link.style.backgroundColor = '#444'; // Change background color to your preferred color
         // Update the previously clicked link
         previousLink = link

         // Update the URL without reloading the page
         history.pushState(null, null, 'chatAPP.jsp');
     }

     // Add event listener for the community link
     document.getElementById("communityLink").addEventListener("click", function(event) {
    	 console.log("Community link clicked");
    	 window.location.href = "chatAPP.jsp";
         sessionStorage.setItem("activeChatContainer", "group");
         fetchGroupMessages();
         
         // Call the function to handle the link click
         handleCommunityLinkClick(event);
     });

    function fetchGroupMessages() {
    	console.log("fetching messages.....");
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "chatServlet", true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var messages = JSON.parse(xhr.responseText);
                var messagesContainer = document.querySelector(".chat-messages");
                messagesContainer.innerHTML = ""; // Clear previous messages
                messages.forEach(function(message) {
                    var messageElement = document.createElement("div");
                    messageElement.classList.add("message");

                    // Check if message belongs to current user
                    var isCurrentUserMessage = message.name === "<%= userName %>";

                    // Apply different CSS classes for current user and other user messages
                    if (isCurrentUserMessage) {
                        messageElement.classList.add("current-user-message");
                    } else {
                        messageElement.classList.add("other-user-message");
                    }

                    // Create user info element
                    var userInfo = document.createElement("div");
                    userInfo.classList.add("user-info");
                    var userName = document.createElement("div");
                    userName.classList.add("user-name");
                    userName.innerText = message.name;
                    userInfo.appendChild(userName);

                    // Create message content element
                    var messageContent = document.createElement("div");
                    messageContent.classList.add("message-content");
                    var contentParagraph = document.createElement("p");
                    contentParagraph.innerText = message.content;
                    var timestamp = document.createElement("div");
                    timestamp.classList.add("timestamp");
                    timestamp.innerText = message.timestamp;
                    messageContent.appendChild(contentParagraph);
                    messageContent.appendChild(timestamp);

                    // Append user info and message content to message element
                    messageElement.appendChild(userInfo);
                    messageElement.appendChild(messageContent);

                    // Append message element to messages container
                    messagesContainer.appendChild(messageElement);
                });
            }
        };
        xhr.send();
    }


  

        // Function to send message to individual user
        function sendToUser() {
            var message = document.getElementById("message-input").value;
            var receiverId = receiver; // Set the receiver ID for individual chat

            var data = {
                senderId: "<%= userName %>",
                receiverId: receiverId,
                message: message
            };

            $.ajax({
                url: "userChatServlet",
                type: "POST",
                data: data,
                success: function(response) {
                    console.log(response);
                    // Optionally, update UI or perform other actions after sending the message
                    fetchUserMessages(receiverId);
                    // Clear the message input field
                    document.getElementById("message-input").value = "";
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                    // Handle errors if needed
                }
            });
        }

        // Function to send message to group
        function sendToGroup() {
        	var message = document.getElementById("message-input").value;
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "chatServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Handle response if needed
                    console.log(xhr.responseText);
                    fetchGroupMessages();
                    // Clear the message input field
                    document.getElementById("message-input").value = "";
                }
            };
            xhr.send("message-input=" + encodeURIComponent(message));
        }
        const currentUser="<%= userName %>";
    // Function to fetch and display chat messages for a specific user
    function fetchUserMessages(userId) {
        // Make an AJAX request to fetch chat messages for the specified user
    	$.get("userChatServlet?userId=" + userId, function(messages) {
            var messagesContainer = $(".chat-messages");
            messagesContainer.empty(); // Clear previous messages
            messages.forEach(function(message) {
                var messageElement = $("<div class='message'>").html(
                    "<div class='user-info'>" +
                    "<span class='user-name'>" + message.sender + "</span>" +
                    "</div>" +
                    "<div class='message-content'>" + message.content + "</div>"+
                    "<div class='timestamp'>" + message.timestamp + "</div>" 
                );

                // Apply different styles for current user and other user messages
                if (message.sender === currentUser) {
                    messageElement.addClass("current-user-message");
                } else {
                    messageElement.addClass("other-user-message");
                }

                messagesContainer.append(messageElement);
            });
        });
    }

    // Function to handle click on a contact
    
    function handleContactClick(userId) {
        fetchUserMessages(userId); // Fetch and display chat messages for the clicked user
        receiver=userId;
        var element = event.currentTarget;
     // Remove styling from the previously clicked contact
        if (previousContact !== null && previousLink !== null) {
            previousContact.style.backgroundColor = '';
            previousLink.style.backgroundColor = '';// Remove background color
        }
        
        // Apply background color to the clicked contact
        element.style.backgroundColor = '#444'; // Change background color to your preferred color
        
        // Update the previously clicked contact
        previousContact = element;
    }

    // Function to fetch contacts initially
    function fetchContacts() {
        $.get("contactListServlet", function(data) {
            var contactListContainer = $("#contact-list");
            contactListContainer.empty(); // Clear previous contacts
            data.forEach(function(contact) {
                var contactElement = $("<div class='contact'>").html(
                    "<div class='contact-info' id='" + contact + "' onclick='handleContactClick(\"" + contact + "\",event)'>"+
                    "<img src='images/user.jpg' alt='Profile Pic'>" +
                    "<span class='contact-name'>" + contact + "</span>" +
                    "</div>"
                );
                contactListContainer.append(contactElement);
            });
        });
    }

    // Fetch contacts initially
    fetchContacts();

    
    function fetchMessages() {
        $.get("messageServlet", function(data) {
            // Update the message container with received messages
            $("#message-container").empty(); // Clear previous messages
            data.forEach(function(message) {
                $("#message-container").append("<div>" + message.sender + ": " + message.content + "</div>");
            });
        });
    }

    // Function to send message to Servlet
    $("#message-form").submit(function(event) {
        event.preventDefault(); // Prevent form submission
        var message = $("#message-input").val();
        $.post("messageServlet", { sender: "<%= userName %>", receiver: "group", content: message })
         .done(function() {
            // Message sent successfully, clear input field
            $("#message-input").val("");
            // Optionally, fetch updated messages after sending
            fetchMessages();
         });
    });

    // Fetch messages initially and every 5 seconds
    fetchMessages();
    setInterval(fetchMessages, 5000);
    
    document.getElementById("send-button").addEventListener("click", function() {
        // Determine whether to send message to individual or group based on the selected chat mode
        if (!receiver=="") {
            sendToUser(); // Call function to send message to individual
        } else {
            sendToGroup(); // Call function to send message to group
        }
    });
    
    window.addEventListener("load", function() {
        var activeChatContainer = sessionStorage.getItem("activeChatContainer");
        var highlightUserId = "<%= highlightUserId %>";
    	console.log(highlightUserId);
        
       
        if (highlightUserId==="" && activeChatContainer === "group") {
            document.getElementById("groupChatContainer").style.display = "block";
            fetchGroupMessages();
			highlightUserId = null;
        }else {
        	console.log("activeChatContainer is : "+activeChatContainer);
        	if(highlightUserId!==""){
    			document.getElementById("individualChatContainer").style.display = "block";
    			document.getElementById(highlightUserId).click();
    			highlightUserId=null;
            }else {
            document.getElementById("individualChatContainer").style.display = "block";
			highlightUserId = null;
            fetchUserMessages(receiver);
            }
        }
        // You can add similar logic for other chat containers if needed
    });
        

</script>

</body>
</html>