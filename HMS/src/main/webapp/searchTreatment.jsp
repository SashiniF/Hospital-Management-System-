<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Treatment Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        .treatment-details {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .header img {
            width: 100px;
            height: auto;
        }
        h1, h2 {
            margin: 0;
            text-align: center;
        }
        .result {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #007BFF;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .search-bar {
            margin-bottom: 20px;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
        .edit-btn, .print-btn {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
            text-decoration: none;
            display: inline-block;
        }
        .edit-btn:hover, .print-btn:hover {
            background-color: #0056b3;
        }
        .formal-report {
            margin-top: 20px;
            border-top: 2px solid #007BFF;
            padding-top: 20px;
        }
        .formal-report p {
            margin: 5px 0;
        }
        @media print {
            body {
                margin: 0;
                padding: 0;
            }
            .search-bar, .edit-btn, .print-btn {
                display: none;
            }
            .result {
                border: none;
                background-color: transparent;
                margin-top: 0;
                padding: 0;
            }
            h1 {
                display: none; /* Hide the Search Treatment heading when printing */
            }
        }
    </style>
    <script>
        function printReport() {
            window.print();
        }
    </script>
</head>
<body>
    <div class="treatment-details">
        <h1>Search Treatment</h1>
        <div class="search-bar">
            <form method="get" action="">
                <label for="treatmentId">Treatment ID:</label>
                <input type="text" id="treatmentId" name="treatmentId" placeholder="Enter Treatment ID (e.g. T001)" required>
                <input type="submit" value="Search">
            </form>
        </div>

        <%
            String jdbcURL = "jdbc:mysql://localhost:3306/hospital";
            String jdbcUsername = "root";
            String jdbcPassword = "@Sashini123";
            String treatmentIdInput = request.getParameter("treatmentId");
            String editId = request.getParameter("editId");

            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                String currentDate = dateFormat.format(new Date());
                String currentTime = timeFormat.format(new Date());

                if (editId != null) {
                    // Handle the edit request
                } else if (treatmentIdInput != null && !treatmentIdInput.isEmpty()) {
                    if (!treatmentIdInput.matches("^T\\d{3}$")) {
                        throw new Exception("Invalid Treatment ID format. Please use T followed by 3 digits (e.g. T001).");
                    }
                    
                    String sql = "SELECT * FROM TreatmentDetails WHERE treatment_id = ?";
                    preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1, treatmentIdInput.toUpperCase());

                    resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        String treatmentId = resultSet.getString("treatment_id");
                        String patientId = resultSet.getString("patient_id");
                        String doctorId = resultSet.getString("doctor_id");
                        String date = resultSet.getString("appointment_date");
                        String time = resultSet.getString("appointment_time");
                        String description = resultSet.getString("description");
                        String prescriptions = resultSet.getString("prescriptions");
        %>
                        <div class="result">
                            <div class="header">
                                <img src="img/h.jpg" alt="Hospital Logo">
                         
                            </div>
                            <div class="formal-report">
                                <h1>Treatment Details</h1>
                                <p><strong>Date:</strong> <%= currentDate %></p>
                                <p><strong>Time:</strong> <%= currentTime %></p>
                                <p><strong>Treatment ID:</strong> <%= treatmentId %></p>
                                <p><strong>Patient ID:</strong> <%= patientId %></p>
                                <p><strong>Doctor ID:</strong> <%= doctorId %></p>
                                <p><strong>Appointment Date:</strong> <%= date %></p>
                                <p><strong>Appointment Time:</strong> <%= time %></p>
                                <p><strong>Description:</strong> <%= description != null && !description.isEmpty() ? description : "N/A" %></p>
                                <p><strong>Prescriptions:</strong> <%= prescriptions != null && !prescriptions.isEmpty() ? prescriptions : "N/A" %></p>
                            </div>
                            <a href="?editId=<%= treatmentId %>" class="edit-btn">Edit Treatment</a>
                            <button class="print-btn" onclick="printReport()">Print Report</button>
                        </div>
        <%
                    } else {
        %>
                        <p class="error">No treatment found with ID: <%= treatmentIdInput.toUpperCase() %></p>
        <%
                    }
                }
            } catch (Exception e) {
        %>
                <p class="error"><%= e.getMessage() %></p>
        <%
            } finally {
                if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>