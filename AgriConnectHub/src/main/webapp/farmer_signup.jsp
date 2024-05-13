<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmer Sign Up</title>
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #333;
            text-align: center;
            margin: 0;
        }

        .signup-container {
            background-color: #fff;
            width: 400px;
            padding: 40px;
            border: 1px solid #00ffdd;
            border-radius: 8px;
            text-align: center;
        }

        h1 {
            color: #00ffdd;
            font-size: 24px;
        }

        .input-container {
            position: relative;
            margin: 10px 0;
        }

        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="password"] {
            width: 100%;
            padding: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            transition: 0.2s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="tel"]:focus,
        input[type="password"]:focus {
            border-color: #00ffdd;
        }

        input[type="text"]::placeholder,
        input[type="email"]::placeholder,
        input[type="tel"]::placeholder,
        input[type="password"]::placeholder {
            color: #777;
        }

        .btn-signup, #getLocationButton {
            background-color: #00ffdd;
            color: #333;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-signup:hover, #getLocationButton:hover {
            background-color: #00ccaa;
        }
    </style>
</head>
<body>
<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
    <div class="signup-container">
        <h1>Farmer Sign Up</h1>
        
        <form method="post" action="register" class="register-form" id="register-form">
            <div class="input-container">
                <input type="text" id="username" name="username" placeholder="Username" required>
            </div>

            <div class="input-container">
                <input type="email" id="email" name="email" placeholder="Email" required>
            </div>

            <div class="input-container">
                <input type="tel" id="phone" name="phone" placeholder="Phone number" required>
            </div>

            <button id="getLocationButton">Get My Location</button>
            
            <div class="input-container">
                <input type="text" id="address" name="address" placeholder="Address" required>
            </div>

            <div class="input-container">
                <input type="text" id="city" name="city" placeholder="City" required>
            </div>

            <div class="input-container">
                <input type="text" id="state" name="state" placeholder="State" required>
            </div>

            <div class="input-container">
                <input type="password" id="password" name="password" placeholder="Password" required>
            </div>

            <div class="input-container">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
            </div>

            <div class="btn-signup">
				<input type="submit" name="signup" id="signup" class="form-submit" value="Register" />
			</div>
        </form>
    </div>
        <p style="color:white">Already have an account? <a href="farmer_login.jsp" style="color:#00ffdd">LOGIN</a></p>

    <script>
        document.getElementById("getLocationButton").addEventListener("click", getUserLocation);

        function getUserLocation() {
            if ("geolocation" in navigator) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;

                    // Use reverse geocoding to get location details
                    reverseGeocode(latitude, longitude);
                });
            } else {
                alert("Geolocation is not available in this browser.");
            }
        }

        function reverseGeocode(latitude, longitude) {
            const apiUrl = `https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}`;

            fetch(apiUrl)
                .then(response => response.json())
                .then(data => {
                    if (data.address) {
                        const address = data.display_name;
                        const city = data.address.city || "City not found";
                        const state = data.address.state || "State not found";

                        document.getElementById("address").value = address;
                        document.getElementById("city").value = city;
                        document.getElementById("state").value = state;
                    } else {
                        document.getElementById("address").value = "";
                        document.getElementById("city").value = "";
                        document.getElementById("state").value = "";
                        alert("Address, city, and state not found for this location.");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    document.getElementById("address").value = "";
                    document.getElementById("city").value = "";
                    document.getElementById("state").value = "";
                    alert("Error fetching location data.");
                });
        }
    </script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var status = document.getElementById("status").value;
		if(status == "success"){
			swal ("Congrats","Account Created Successfully","success");
		}
</script>
</body>
</html>
