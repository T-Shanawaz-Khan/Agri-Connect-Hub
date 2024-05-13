<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmer Login</title>
    <link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
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

        .login-container {
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

        label {
            display: block;
            margin: 10px 0;
            color: #333;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 14px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .btn-signup {
            background-color: #00ffdd;
            color: #333;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-signup:hover {
            background-color: #00ccaa;
        }
    </style>
</head>
<body>
<input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
    <div class="login-container">
        <h1>Farmer Login</h1>
        
        <form method="post" action="Login" class="register-form" id="login-form">
            <input type="text" id="username" name="username" placeholder="Enter your email" required>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <div class="btn-signup">
					<input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
			</div>
        </form>
    </div>

    <p style="color:white">Don't have an account? <a href="farmer_signup.jsp" style="color:#00ffdd">Sign Up</a></p>
    <script>
        function redirectToPage() {
            // Replace 'target-page.html' with the actual URL of the page you want to redirect to
            window.location.href = 'index.jsp';
        }
    </script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var status = document.getElementById("status").value;
		if (status== "failed") {
			swal ("Sorry", "Wrong Username or Password", "error");
		}
	</script>

</body>
</html>
