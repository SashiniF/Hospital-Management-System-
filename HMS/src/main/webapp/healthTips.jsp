<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Tips - Healthcare</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-image: url('img/health.png'); /* Update to your background image */
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

        .logo-container img {
            height: 50px;
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
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .title {
            color: #003366;
            font-size: 2rem;
            margin-bottom: 20px;
            text-align: center;
        }

        .tips-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .tip {
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
            transition: transform 0.2s;
        }

        .tip:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .tip h3 {
            margin: 0 0 10px;
            font-size: 1.5rem;
            color: #003c71;
        }

        .tip p {
            margin: 0;
            font-size: 14px;
            line-height: 1.5;
        }

        .current-date-time {
            margin-top: 20px;
            font-size: 14px;
            color: #003c71;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/img/h.jpg" alt="Hospital Logo">
        </div>
        <ul class="nav-links" id="navLinks">
            <li><a href="Home.jsp" onclick="setActive(this)">Home</a></li>
            <li><a href="viewMedicalServices.jsp" onclick="setActive(this)">Medical Services</a></li>
            <li><a href="viewServAppo.jsp" onclick="setActive(this)">Hospital Services</a></li>
            <li><a href="viewTreatment.jsp" onclick="setActive(this)">Treatments</a></li>
            <li><a href="information.jsp" onclick="setActive(this)" class="active">Information</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact Us</a></li>
        </ul>
    </div>

    <div class="container">
        <h1 class="title">Health Tips</h1>

        <div class="tips-grid" id="tipsGrid">
            <div class="tip">
                <h3>Stay Hydrated</h3>
                <p>Drink plenty of water throughout the day to keep your body hydrated.</p>
            </div>

            <div class="tip">
                <h3>Balanced Diet</h3>
                <p>Include a variety of fruits and vegetables in your diet for essential nutrients.</p>
            </div>

            <div class="tip">
                <h3>Regular Exercise</h3>
                <p>Engage in at least 30 minutes of physical activity most days of the week.</p>
            </div>

            <div class="tip">
                <h3>Get Enough Sleep</h3>
                <p>Aim for 7-9 hours of quality sleep each night for optimal health.</p>
            </div>

            <div class="tip">
                <h3>Manage Stress</h3>
                <p>Practice stress management techniques such as meditation or deep breathing.</p>
            </div>

            <div class="tip">
                <h3>Avoid Smoking</h3>
                <p>Quit smoking to improve your overall health and reduce the risk of disease.</p>
            </div>

            <div class="tip">
                <h3>Regular Check-ups</h3>
                <p>Schedule regular health check-ups to catch any potential issues early.</p>
            </div>

            <div class="tip">
                <h3>Limit Alcohol Intake</h3>
                <p>Drink in moderation to maintain good health.</p>
            </div>
        </div>

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