<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
String billId = request.getParameter("bill_id");
String DB_URL = "jdbc:mysql://localhost:3306/hospital";
String DB_USER = "root";
String DB_PASSWORD = "@Sashini123";

String patientName = "", admissionId = "", dischargeDate = "";
double doctorCharges = 0, medicineCharges = 0, serviceCharges = 0, roomCharges = 0, hospitalCharges = 0, discount = 0, netValue = 0;
String notes = "";

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    String sql = "SELECT b.*, p.first_name, p.last_name FROM InPatientBills b JOIN InPatients p ON b.patient_id = p.patient_id WHERE b.bill_id = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, billId);
    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        patientName = rs.getString("first_name") + " " + rs.getString("last_name");
        admissionId = rs.getString("admission_id");
        dischargeDate = rs.getString("discharge_date");
        doctorCharges = rs.getDouble("doctor_charges");
        medicineCharges = rs.getDouble("medicine_charges");
        serviceCharges = rs.getDouble("service_charges");
        roomCharges = rs.getDouble("room_charges");
        hospitalCharges = rs.getDouble("hospital_charges");
        discount = rs.getDouble("discount");
        netValue = rs.getDouble("net_value");
        notes = rs.getString("notes");
    }
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bill - <%= billId %></title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #fff;
    margin: 30px;
}
.container {
    width: 800px;
    margin: 0 auto;
}
.header {
    text-align: center;
    border-bottom: 2px solid #0066cc;
    padding-bottom: 10px;
}
h1 {
    color: #0066cc;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}
th, td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}
th {
    background-color: #0066cc;
    color: white;
}
@media print {
    .no-print { display: none; }
    body { background: white; margin: 0; }
}
</style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>City General Hospital</h1>
        <p>123 Hospital Road, Colombo 10, Sri Lanka<br>Tel: +94 11 2345678 | info@cityhospital.lk</p>
    </div>

    <h2 style="text-align:center;">In Patient Bill</h2>
    <p><b>Bill ID:</b> <%= billId %></p>
    <p><b>Patient Name:</b> <%= patientName %></p>
    <p><b>Admission ID:</b> <%= admissionId %></p>
    <p><b>Discharge Date:</b> <%= dischargeDate %></p>

    <table>
        <tr><th>Doctor Charges</th><td>Rs. <%= doctorCharges %></td></tr>
        <tr><th>Medicine Charges</th><td>Rs. <%= medicineCharges %></td></tr>
        <tr><th>Service Charges</th><td>Rs. <%= serviceCharges %></td></tr>
        <tr><th>Room Charges</th><td>Rs. <%= roomCharges %></td></tr>
        <tr><th>Hospital Charges</th><td>Rs. <%= hospitalCharges %></td></tr>
        <tr><th>Discount</th><td>Rs. <%= discount %></td></tr>
        <tr><th><b>Net Total</b></th><td><b>Rs. <%= netValue %></b></td></tr>
    </table>

    <p><b>Notes:</b> <%= notes %></p>
    <div class="no-print" style="text-align:center; margin-top:20px;">
        <button onclick="window.print()">🖨 Print</button>
    </div>
</div>

<script>
window.onload = function() {
    window.print();
}
</script>

</body>
</html>
