<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System - Contact Us</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            line-height: 1.6;
            overflow-x: hidden;
            background-image: url('img/contact.png'); /* Add the background image */
            background-size: cover; /* Cover the entire background */
            background-position: center; /* Center the image */
            background-repeat: no-repeat; /* Do not repeat the image */
        }

        .navbar {
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent background */
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

        .login-btn {
            margin-left: auto;
            color: #003c71;
            text-decoration: none;
            padding: 10px 15px;
        }

        .main-content {
            display: flex;
            gap: 30px;
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .contact-content {
            flex: 2;
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent background for contact section */
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .contact-header {
            font-size: 36px;
            color: #003c71;
            margin-bottom: 30px;
            text-align: center;
        }

        .contact-section {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 40px;
        }

        .contact-card {
            flex: 1;
            min-width: 300px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }

        .contact-card h2 {
            color: #003c71;
            margin-top: 0;
            border-bottom: 2px solid #ff5c00;
            padding-bottom: 10px;
        }

        .contact-info {
            margin-top: 20px;
        }

        .contact-info p {
            margin: 15px 0;
            display: flex;
            align-items: center;
        }

        .contact-info i {
            margin-right: 10px;
            color: #ff5c00;
            font-size: 20px;
        }

        .contact-form {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #003c71;
            font-weight: bold;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        textarea.form-control {
            height: 150px;
            resize: vertical;
        }

        .submit-btn {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #00274d;
        }

        .chatbot-container {
            flex: 1;
            min-width: 350px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .chatbot-header {
            background-color: #003c71;
            color: white;
            padding: 15px;
            border-radius: 8px 8px 0 0;
            margin: -20px -20px 20px -20px;
            display: flex;
            align-items: center;
        }

        .chatbot-header i {
            margin-right: 10px;
            font-size: 24px;
        }

        .chatbot-messages {
            height: 400px;
            overflow-y: auto;
            margin-bottom: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
        }

        .message {
            margin-bottom: 15px;
            padding: 10px 15px;
            border-radius: 18px;
            max-width: 80%;
            word-wrap: break-word;
        }

        .user-message {
            background-color: #e3f2fd;
            margin-left: auto;
            border-bottom-right-radius: 5px;
        }

        .bot-message {
            background-color: #f1f1f1;
            margin-right: auto;
            border-bottom-left-radius: 5px;
        }

        .chatbot-input {
            display: flex;
            gap: 10px;
        }

        .chatbot-input input {
            flex: 1;
            padding: 12px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 16px;
        }

        .chatbot-input button {
            background-color: #003c71;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        .chatbot-input button:hover {
            background-color: #00274d;
        }

        .typing-indicator {
            display: none;
            color: #666;
            font-style: italic;
            margin: 5px 0;
        }

        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
                padding: 0;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo-container">
            <img src="img/h.jpg" alt="Hospital Logo"> <!-- Update with your hospital logo -->
        </div>
        <ul class="nav-links" id="navLinks">
            <li><a href="Home.jsp" onclick="setActive(this)">Home</a></li>
            <li><a href="viewMedicalServices.jsp" onclick="setActive(this)">Medical Services</a></li>
            <li><a href="viewServAppo.jsp" onclick="setActive(this)">Hospital Services</a></li>
            <li><a href="viewTreatment.jsp" onclick="setActive(this)">Treatments</a></li>
            <li><a href="information.jsp" onclick="setActive(this)">Information</a></li>
            <li><a href="contactUs.jsp" onclick="setActive(this)">Contact Us</a></li>
        </ul>
        <a href="login.jsp" class="login-btn">Log in</a>
    </div>

    <div class="main-content">
        <div class="contact-content">
            <h1 class="contact-header">Contact Our Hospital</h1>
            
            <div class="contact-section">
                <div class="contact-card">
                    <h2>Patient Services</h2>
                    <div class="contact-info">
                        <p><i class="fas fa-phone-alt"></i> +94 11 2 123456</p>
                        <p><i class="fas fa-envelope"></i> patientsupport@hospital.com</p>
                        <p><i class="fas fa-clock"></i> 24/7 Support</p>
                    </div>
                </div>
                
                <div class="contact-card">
                    <h2>Administration</h2>
                    <div class="contact-info">
                        <p><i class="fas fa-map-marker-alt"></i> Hospital Headquarters, Main Road, City, Country</p>
                        <p><i class="fas fa-phone-alt"></i> +94 11 2 987654</p>
                        <p><i class="fas fa-envelope"></i> info@hospital.com</p>
                    </div>
                </div>
                
                <div class="contact-card">
                    <h2>Emergency Services</h2>
                    <div class="contact-info">
                        <p><i class="fas fa-phone-alt"></i> +94 11 2 000000</p>
                        <p><i class="fas fa-clock"></i> Emergency support available 24/7</p>
                    </div>
                </div>
            </div>
            
            <div class="contact-form">
                <h2>Send us a Message</h2>
                <form action="contactSubmit.jsp" method="post">
                    <div class="form-group">
                        <label for="name">Your Name</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" class="form-control" required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>
        </div>

        <div class="chatbot-container">
            <div class="chatbot-header">
                <i class="fas fa-robot"></i>
                <h3>Hospital Assistant</h3>
            </div>
            <div class="chatbot-messages" id="chatbotMessages">
                <div class="message bot-message">
                    Hello! I'm your Hospital assistant. I can help with:
                    <ul>
                        <li>Appointment scheduling</li>
                        <li>Doctor availability</li>
                        <li>General health information</li>
                    </ul>
                    How can I assist you today?
                </div>
            </div>
            <div class="typing-indicator" id="typingIndicator">Assistant is typing...</div>
            <div class="chatbot-input">
                <input type="text" id="userInput" placeholder="Ask about appointments or services..." onkeypress="handleKeyPress(event)">
                <button onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
            </div>
        </div>
    </div>

    <script>
        function setActive(element) {
            const allLinks = document.querySelectorAll('#navLinks li a');
            allLinks.forEach(link => link.classList.remove('active'));
            element.classList.add('active');
        }

        document.addEventListener('DOMContentLoaded', function() {
            const currentPage = window.location.pathname.split('/').pop();
            const allLinks = document.querySelectorAll('#navLinks li a');

            allLinks.forEach(link => {
                const linkHref = link.getAttribute('href');
                if (linkHref === currentPage) {
                    link.classList.add('active');
                }
            });
        });

        // Chatbot functions
        function handleKeyPress(event) {
            if (event.key === 'Enter') {
                sendMessage();
            }
        }

        function sendMessage() {
            const userInput = document.getElementById('userInput');
            const message = userInput.value.trim();
            
            if (message === '') return;
            
            // Add user message to chat
            addMessage(message, 'user');
            userInput.value = '';
            
            // Show typing indicator
            document.getElementById('typingIndicator').style.display = 'block';
            
            // Simulate delay for bot response
            setTimeout(() => {
                document.getElementById('typingIndicator').style.display = 'none';
                const botResponse = generateResponse(message);
                addMessage(botResponse, 'bot');
            }, 1000 + Math.random() * 2000);
        }
        
        function addMessage(text, sender) {
            const messagesContainer = document.getElementById('chatbotMessages');
            const messageDiv = document.createElement('div');
            messageDiv.classList.add('message');
            messageDiv.classList.add(sender === 'user' ? 'user-message' : 'bot-message');
            
            messageDiv.textContent = text;
            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }
        
        function generateResponse(userMessage) {
            const lowerMessage = userMessage.toLowerCase();
            
            // Appointment responses
            if (lowerMessage.includes('appointment') || lowerMessage.includes('schedule')) {
                return "You can schedule an appointment by visiting our appointments page or calling our office.";
            }
            
            // Doctor availability
            if (lowerMessage.includes('doctor') || lowerMessage.includes('availability')) {
                return "Please specify which doctor you would like to inquire about, and I can assist you with that.";
            }
            
            // Health information
            if (lowerMessage.includes('health') || lowerMessage.includes('information')) {
                return "I can provide general health information. Please ask your question!";
            }
            
            return "I'm here to help with your healthcare needs. Please ask about appointments or services.";
        }
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>
</html>