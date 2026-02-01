<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Database configuration
    final String DB_URL = "jdbc:mysql://localhost:3306/hospital";
    final String DB_USER = "root";
    final String DB_PASSWORD = "@Sashini123";

    String patientBillId = "";
    String patientId = "";
    String admissionId = "";
    String dischargeDate = "";
    double doctorCharges = 0;
    double medicineCharges = 0;
    double serviceCharges = 0;
    double roomCharges = 0;
    double hospitalCharges = 0;
    double discount = 0;
    double netValue = 0;

    List<String> patientIds = new ArrayList<>();

    // Fetching the last bill ID from the database
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        
        // Get the last bill ID
        String idQuery = "SELECT bill_id FROM InPatientBills ORDER BY bill_id DESC LIMIT 1";
        Statement idStmt = conn.createStatement();
        ResultSet idRs = idStmt.executeQuery(idQuery);
        
        if (idRs.next()) {
            String lastBillId = idRs.getString("bill_id");
            if (lastBillId != null && lastBillId.startsWith("IPB")) {
                int lastIdNumber = Integer.parseInt(lastBillId.substring(3));
                patientBillId = "IPB" + String.format("%03d", lastIdNumber + 1);
            }
        } else {
            patientBillId = "IPB001"; // First bill ID if no entries exist
        }

        idRs.close();
        idStmt.close();

        // Fetching patient IDs
        String query = "SELECT patient_id FROM InPatients";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
            patientIds.add(rs.getString("patient_id"));
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Error fetching patient data: " + e.getMessage());
    }

    // Handling form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO InPatientBills (bill_id, patient_id, admission_id, discharge_date, doctor_charges, medicine_charges, service_charges, room_charges, hospital_charges, discount, net_value, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            
            patientId = request.getParameter("patientId");
            admissionId = request.getParameter("admissionId");
            dischargeDate = request.getParameter("dischargeDate");
            doctorCharges = Double.parseDouble(request.getParameter("doctorCharges"));
            medicineCharges = Double.parseDouble(request.getParameter("medicineCharges"));
            serviceCharges = Double.parseDouble(request.getParameter("serviceCharges"));
            roomCharges = Double.parseDouble(request.getParameter("roomCharges"));
            hospitalCharges = Double.parseDouble(request.getParameter("hospitalCharges"));
            discount = Double.parseDouble(request.getParameter("discount"));
            netValue = doctorCharges + medicineCharges + serviceCharges + roomCharges + hospitalCharges - discount;
            String notes = request.getParameter("notes");

            pstmt.setString(1, patientBillId);
            pstmt.setString(2, patientId);
            pstmt.setString(3, admissionId);
            pstmt.setString(4, dischargeDate);
            pstmt.setDouble(5, doctorCharges);
            pstmt.setDouble(6, medicineCharges);
            pstmt.setDouble(7, serviceCharges);
            pstmt.setDouble(8, roomCharges);
            pstmt.setDouble(9, hospitalCharges);
            pstmt.setDouble(10, discount);
            pstmt.setDouble(11, netValue);
            pstmt.setString(12, notes);

            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            // ✅ Stay on the same page and show message
            request.setAttribute("success", "Successfully saved the bill!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error saving bill: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Details</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('img/dapps.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            padding: 20px;
            line-height: 1.6;
            color: #34495e;
        }
        .logo {
            position: absolute;
            top: 20px;
            left: 20px;
            width: 120px;
            height: auto;
            z-index: 100;
        }
        .home-button {
            position: absolute;
            top: 20px;
            right: 20px;
            width: 40px;
            height: 40px;
            cursor: pointer;
            transition: transform 0.2s;
            z-index: 100;
        }
        .home-button:hover {
            transform: scale(1.1);
        }
        .bill-details {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 80px auto 0;
        }
        .bill-details h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 2rem;
            font-weight: 600;
        }
        .bill-details h2 {
            color: #3498db;
            margin-top: 2rem;
            margin-bottom: 1.5rem;
            font-size: 1.4rem;
            border-bottom: 2px solid #ecf0f1;
            padding-bottom: 0.5rem;
        }
        .bill-details label {
            display: block;
            margin-bottom: 0.8rem;
            font-weight: 500;
        }
        .bill-details input[type="text"],
        .bill-details input[type="number"],
        .bill-details input[type="date"],
        .bill-details select,
        .bill-details textarea {
            width: 100%;
            padding: 0.8rem 1rem;
            margin-bottom: 1.2rem;
            border: 2px solid #bdc3c7;
            border-radius: 6px;
            transition: border-color 0.3s ease;
        }
        .bill-details textarea {
            resize: vertical;
            min-height: 80px;
        }
        .bill-details input:focus,
        .bill-details select:focus,
        .bill-details textarea:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        .action-buttons {
            display: flex;
            gap: 0.75rem;
            margin-top: 1.5rem;
            justify-content: center;
        }
        .action-buttons button {
            padding: 0.8rem 1.5rem;
            border-radius: 6px;
            font-size: 0.95rem;
            cursor: pointer;
            color: white;
            font-weight: 500;
        }
        .action-buttons .add-btn { background-color: #2980b9; }
        .action-buttons .refresh-btn { background-color: #95a5a6; }
        .action-buttons .close-btn { background-color: #7f8c8d; }
        .action-buttons button:hover {
            filter: brightness(0.9);
        }

        .success-message {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: 500;
        }
        .error-message {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .bill-details {
                padding: 1.5rem;
                margin-top: 60px;
            }
            .logo {
                width: 100px;
                top: 15px;
                left: 15px;
            }
        }
    </style>
</head>
<body>
    <img src="img/h.jpg" alt="Hospital Logo" class="logo">
    <img src="img/home.png" alt="Home" class="home-button" onclick="window.location.href='Home.jsp'">

    <div class="bill-details">
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <div class="success-message"><%= request.getAttribute("success") %></div>
        <% } %>

        <h1>BILL DETAILS</h1>

        <form id="billForm" method="post">
            <h2>Bill Information</h2>
            <label for="patientBillId">Patient Bill ID:</label>
            <input type="text" id="patientBillId" name="patientBillId" value="<%= patientBillId %>" readonly>

            <label for="patientId">Patient ID:</label>
            <select id="patientId" name="patientId" required>
                <option value="">-- Select Patient --</option>
                <% for (String id : patientIds) { %>
                    <option value="<%= id %>" <%= id.equals(patientId) ? "selected" : "" %>><%= id %></option>
                <% } %>
            </select>

            <label for="admissionId">Admission ID:</label>
            <input type="text" id="admissionId" name="admissionId" value="<%= admissionId %>">

            <label for="dischargeDate">Discharge Date:</label>
            <input type="date" id="dischargeDate" name="dischargeDate" value="<%= dischargeDate %>">

            <label for="doctorCharges">Doctor Charges:</label>
            <input type="number" id="doctorCharges" name="doctorCharges" value="<%= doctorCharges > 0 ? doctorCharges : "" %>" step="0.01" min="0">

            <label for="medicineCharges">Medicine Charges:</label>
            <input type="number" id="medicineCharges" name="medicineCharges" value="<%= medicineCharges > 0 ? medicineCharges : "" %>" step="0.01" min="0">

            <label for="serviceCharges">Service Charges:</label>
            <input type="number" id="serviceCharges" name="serviceCharges" value="<%= serviceCharges > 0 ? serviceCharges : "" %>" step="0.01" min="0">

            <label for="roomCharges">Room Charges:</label>
            <input type="number" id="roomCharges" name="roomCharges" value="<%= roomCharges > 0 ? roomCharges : "" %>" step="0.01" min="0">

            <label for="hospitalCharges">Hospital Charges:</label>
            <input type="number" id="hospitalCharges" name="hospitalCharges" value="<%= hospitalCharges > 0 ? hospitalCharges : "" %>" step="0.01" min="0">

            <label for="discount">Discount:</label>
            <input type="number" id="discount" name="discount" value="<%= discount > 0 ? discount : "" %>" step="0.01" min="0">

            <label for="netValue">Net Value:</label>
            <input type="number" id="netValue" name="netValue" value="<%= netValue > 0 ? netValue : "" %>" step="0.01" min="0" readonly>

            <label for="notes">Notes:</label>
            <textarea id="notes" name="notes" placeholder="Enter any notes"></textarea>

            <div class="action-buttons">
                <button type="submit" class="add-btn">Save Bill</button>
                <button type="button" class="refresh-btn" onclick="location.reload()">Refresh</button>
                <button type="button" class="close-btn" onclick="window.location.href='Home.jsp'">Close</button>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = ['doctorCharges', 'medicineCharges', 'serviceCharges', 'roomCharges', 'hospitalCharges', 'discount'];
            
            inputs.forEach(id => {
                document.getElementById(id).addEventListener('change', calculateNetValue);
            });
            
            function calculateNetValue() {
                let total = 0;
                inputs.slice(0, 5).forEach(id => {
                    total += parseFloat(document.getElementById(id).value) || 0;
                });
                const discount = parseFloat(document.getElementById('discount').value) || 0;
                const netValue = total - discount;
                document.getElementById('netValue').value = netValue.toFixed(2);
            }
        });
    </script>
</body>
</html>
