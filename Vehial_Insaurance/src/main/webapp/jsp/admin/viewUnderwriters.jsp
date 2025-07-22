<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Underwriters - Vehial Insurance</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 25px 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            font-size: 1.8em;
            font-weight: 600;
        }

        .main-content-wrapper {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 20px;
        }

        .container {
            background-color: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1000px;
            text-align: center;
        }

        .container h2 {
            font-size: 2.2em;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: 700;
        }

        .table-responsive {
            overflow-x: auto;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
        }

        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        table th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
        }

        table tr:nth-child(even) {
            background-color: #f8f8f8;
        }

        table tr:hover {
            background-color: #eef7ff;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .error-message {
            background-color: #ffdddd;
            color: #d8000c;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #d8000c;
            margin: 20px 0;
            font-size: 0.95em;
            font-weight: 500;
            text-align: center;
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background-color: #95a5a6;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-weight: 500;
        }

        .back-button:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
        }

        footer {
            margin-top: auto;
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
            font-size: 0.9em;
            background-color: #f9f9f9;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <header>
        <h2>Underwriter Management</h2>
    </header>

    <div class="main-content-wrapper">
        <div class="container">
            <h2>All Underwriters</h2>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>DOB</th>
                            <th>Joining Date</th>
                            <th>Password</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                conn = DBConnection.getConnection();
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery("SELECT * FROM Underwriter ORDER BY id ASC");

                                if (!rs.isBeforeFirst()) {
                        %>
                                    <tr><td colspan="6" style="text-align: center; padding: 20px;">No underwriters found.</td></tr>
                        <%
                                } else {
                                    while (rs.next()) {
                        %>
                                        <tr>
                                            <td><%= rs.getInt("id") %></td>
                                            <td><%= rs.getString("name") %></td>
                                            <td><%= rs.getDate("dob") %></td>
                                            <td><%= rs.getDate("joiningDate") %></td>
                                            <td><%= rs.getString("password") %></td>
                                            <td>
                                                <form method="post" action="DeleteUnderwriterServlet" onsubmit="return confirm('Are you sure you want to delete this underwriter?');">
                                                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                    <button type="submit" class="delete-btn">Delete</button>
                                                </form>
                                            </td>
                                        </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                        %>
                                <tr><td colspan="6" class="error-message">Error loading data: <%= e.getMessage() %></td></tr>
                        <%
                            } finally {
                                try {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                } catch (SQLException ex) {
                        %>
                                    <tr><td colspan="6" class="error-message">Error closing resources: <%= ex.getMessage() %></td></tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <a href="adminHome.jsp" class="back-button">Back to Dashboard</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Vehial Insurance. All rights reserved.</p>
    </footer>
</body>
</html>
