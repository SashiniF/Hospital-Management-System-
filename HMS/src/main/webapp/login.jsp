<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital - Healthcare</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-image: url('img/login.png');
            background-size: cover;
            overflow-x: hidden;
        }

        .navbar {
            background-color: white;
            border-bottom: 1px solid #e0e0e0;
            display: flex;
            align-items: center;
            padding: 10px 20px;
            position: relative;
            z-index: 100;
        }

        .logo-container {
            display: flex;
            align-items: center;
        }

        .navbar img {
            height: 50px;
            margin-right: 10px;
        }
        
        .nav-links {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
            flex-grow: 1;
        }
        
        .nav-links li {
            padding: 15px;
            position: relative;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #003c71;
            font-weight: 500;
            padding: 10px 15px;
            display: block;
        }
        
        .nav-links a:hover {
            background-color: #f0f0f0;
        }
        
        .nav-links a.active {
            color: #003c71;
            border-bottom: 2px solid #ff5c00;
        }

        .container {
            max-width: 400px; /* Adjusted max-width */
            margin: 30px 0 30px 20px; /* Adjusted margin to push left */
            padding: 20px; /* Adjusted padding */
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .title {
            color: #003366;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #003c71;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .submit-btn {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 14px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .submit-btn:hover {
            background-color: #00274d;
        }

        .forgot-password {
            text-align: right;
            margin-top: -15px;
            margin-bottom: 20px;
        }

        .forgot-password a {
            color: #003c71;
            text-decoration: none;
            font-size: 14px;
        }

        .register-link {
            margin-top: 20px;
            color: #003c71;
        }

        .register-link a {
            color: #003c71;
            text-decoration: none;
            font-weight: bold;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 20px;
        }

        .current-date-time {
            margin-top: 20px;
            font-size: 14px;
            color: #003c71;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/img/h.jpg" alt="Hospital Logo">
        </div>
        <div class="nav-container">
            <ul class="nav-links" id="navLinks">
                <li><a href="viewMedicalServices.jsp" onclick="setActive(this)">Medical Services</a></li>
            <li><a href="viewServAppo.jsp" onclick="setActive(this)">Hospital Services</a></li>
            <li><a href="viewTreatment.jsp" onclick="setActive(this)">Treatments</a></li>
            <li><a href="information.jsp" onclick="setActive(this)">Information</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact Us</a></li>
            </ul>
        </div>
    </div>

    <div class="container">
        <h1 class="title">Welcome</h1>
       
        <%
            // Check for login credentials
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String errorMessage = request.getParameter("error");

            if (username != null && password != null) {
                if (username.equals("admin") && password.equals("admin123")) {
                    response.sendRedirect("information.jsp");
                    return; // Stop further processing
                } else if (username.equals("sashini") && password.equals("sashini123")) {
                    response.sendRedirect("information.jsp");
                    return; // Stop further processing
                } else {
                    errorMessage = "Invalid credentials";
                }
            }

            if (errorMessage != null) { 
        %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <%
            }
        %>

        <form class="login-form" action="login.jsp" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="forgot-password">
                <a href="forgotPassword.jsp">Forgot password?</a>
            </div>
            
            <button type="submit" class="submit-btn">Log in</button>
            
            <div class="register-link">
                Don't have an account? <a href="createAcc.jsp">Register now</a>
            </div>
        </form>

        <div id="currentDateTime" class="current-date-time"></div>
    </div>
    
    <script>
        function displayDateTime() {
            const now = new Date();
            const options = { year: 'numeric', month: 'long', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric', hour12: true };
            const dateTimeString = now.toLocaleString('en-US', options);
            
            document.getElementById('currentDateTime').innerText = dateTimeString;
        }

        displayDateTime();

        // Highlight active navigation item
        document.addEventListener('DOMContentLoaded', function() {
            const navLinks = document.querySelectorAll('.nav-links a');
            navLinks.forEach(link => {
                link.addEventListener('click', function() {
                    navLinks.forEach(l => l.classList.remove('active'));
                    this.classList.add('active');
                });
            });
        });
    </script>
</body>
</html>