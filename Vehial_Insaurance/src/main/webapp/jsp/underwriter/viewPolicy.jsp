<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>View Policies</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>All Vehicle Insurance Policies</h2>
    <table border="1">
        <tr>
            <th>Policy No</th><th>Vehicle No</th><th>Customer</th><th>Phone</th><th>Premium</th><th>From</th><th>To</th><th>Type</th>
        </tr>
<%
    try {
        Connection conn = DBConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM Policy");

        while (rs.next()) {
%>
        <tr>
		    <td><%= rs.getInt("policyId") %></td> <!-- Fixed -->
		    <td><%= rs.getString("vehicleNo") %></td>
		    <td><%= rs.getString("customerName") %></td>
		    <td><%= rs.getString("phoneNo") %></td>
		    <td><%= rs.getDouble("premiumAmt") %></td>
		    <td><%= rs.getString("fromDate") %></td>
		    <td><%= rs.getString("toDate") %></td>
		    <td><%= rs.getString("type") %></td>
		</tr>

<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='8'>Error loading policies</td></tr>");
    }
%>
    </table>
    <a href="underwriterHome.jsp"><button>Back</button></a>
</div>
</body>
</html>