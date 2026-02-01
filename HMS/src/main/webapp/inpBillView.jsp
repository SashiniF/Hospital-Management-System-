<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
final String DB_URL = "jdbc:mysql://localhost:3306/hospital";
final String DB_USER = "root";
final String DB_PASSWORD = "@Sashini123";

List<Map<String, String>> bills = new ArrayList<>();
String searchQuery = request.getParameter("search");
String error = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    
    String query = "SELECT b.bill_id, b.patient_id, p.first_name, p.last_name, b.admission_id, " +
                   "b.discharge_date, b.net_value " +
                   "FROM InPatientBills b " +
                   "JOIN InPatients p ON b.patient_id = p.patient_id ";
    
    if (searchQuery != null && !searchQuery.isEmpty()) {
        query += "WHERE b.bill_id LIKE ? OR b.patient_id LIKE ? OR p.first_name LIKE ? OR p.last_name LIKE ? ";
    }
    query += "ORDER BY b.created_at DESC";
    
    PreparedStatement stmt = conn.prepareStatement(query);
    if (searchQuery != null && !searchQuery.isEmpty()) {
        String likeParam = "%" + searchQuery + "%";
        stmt.setString(1, likeParam);
        stmt.setString(2, likeParam);
        stmt.setString(3, likeParam);
        stmt.setString(4, likeParam);
    }
    
    ResultSet rs = stmt.executeQuery();
    while (rs.next()) {
        Map<String, String> bill = new HashMap<>();
        bill.put("bill_id", rs.getString("bill_id"));
        bill.put("patient_id", rs.getString("patient_id"));
        bill.put("patient_name", rs.getString("first_name") + " " + rs.getString("last_name"));
        bill.put("admission_id", rs.getString("admission_id"));
        bill.put("discharge_date", rs.getString("discharge_date"));
        bill.put("net_value", rs.getString("net_value"));
        bills.add(bill);
    }
    conn.close();
} catch (Exception e) {
    error = "Error loading bills: " + e.getMessage();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title> Bill View</title>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #f5f5f5;
        padding: 20px;
    }
    .container {
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    h1 {
        text-align: center;
        color: #2c3e50;
    }
    .search-box {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }
    input, button {
        padding: 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }
    button {
        background: #3498db;
        color: white;
        border: none;
        cursor: pointer;
    }
    button:hover { background: #2980b9; }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        text-align: left;
    }
    th {
        background-color: #3498db;
        color: white;
    }
    .print-btn {
        background-color: #9b59b6;
        color: white;
        border: none;
        padding: 6px 10px;
        border-radius: 4px;
        cursor: pointer;
    }
    .print-btn:hover { opacity: 0.8; }
</style>
</head>
<body>
<div class="container">
    <h1>PATIENT BILLS</h1>

    <% if (error != null) { %>
        <div style="color:red; margin-bottom:10px;"><%= error %></div>
    <% } %>

    <form method="get" action="InPatientBillView.jsp">
        <div class="search-box">
            <input type="text" name="search" placeholder="Search Bill ID, Patient Name..." 
                   value="<%= searchQuery != null ? searchQuery : "" %>">
            <button type="submit">Search</button>
            <% if (searchQuery != null && !searchQuery.isEmpty()) { %>
                <button type="button" onclick="window.location.href='InPatientBillView.jsp'">Clear</button>
            <% } %>
        </div>
    </form>

    <table>
        <thead>
            <tr>
                <th>Bill ID</th>
                <th>Patient</th>
                <th>Admission ID</th>
                <th>Discharge Date</th>
                <th>Net Value</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% if (bills.isEmpty()) { %>
                <tr><td colspan="6" style="text-align:center;">No bills found</td></tr>
            <% } else { 
                for (Map<String, String> bill : bills) { %>
                <tr>
                    <td><%= bill.get("bill_id") %></td>
                    <td><%= bill.get("patient_name") %> (<%= bill.get("patient_id") %>)</td>
                    <td><%= bill.get("admission_id") %></td>
                    <td><%= bill.get("discharge_date") %></td>
                    <td><%= bill.get("net_value") %></td>
                    <td><button class="print-btn" onclick="printBill('<%= bill.get("bill_id") %>')">Print</button></td>
                </tr>
            <% } } %>
        </tbody>
    </table>
</div>

<script>
function printBill(billId) {
    window.open('PrintBill.jsp?bill_id=' + billId, '_blank');
}
</script>
</body>
</html>
