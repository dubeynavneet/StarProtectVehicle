<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>All Underwriters</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>Underwriter List</h2>
    <table border="1">
        <tr>
            <th>ID</th><th>Name</th><th>DOB</th><th>Joining Date</th><th>Password</th>
        </tr>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        conn = DBConnection.getConnection();
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM Underwriter");

        while (rs.next()) {
%>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getDate("dob") %></td>
            <td><%= rs.getDate("joiningDate") %></td>
            <td><%= rs.getString("password") %></td>
        </tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='5'>Error loading data: " + e.getMessage() + "</td></tr>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            out.println("<tr><td colspan='5'>Error closing resources: " + ex.getMessage() + "</td></tr>");
        }
    }
%>
    </table>
    <br>
    <a href="adminHome.jsp"><button>Back</button></a>
</div>
</body>
</html>
