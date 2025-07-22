<%@ page import="java.sql.*" %>
<%@ page import="com.db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Policies - Vehial Insurance</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #e0f2f7, #c2e9fb); /* Light blue gradient background */
            background-size: cover;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
        }

        header {
            background-color: #1e3a8a; /* Dark blue header */
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
            align-items: flex-start; /* Align to top for longer content */
            padding: 40px 20px; /* Increased padding for overall spacing */
        }

        .container {
            background-color: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1200px; /* Wider container for the table */
            text-align: center;
        }

        .container h2 {
            font-size: 2.2em;
            margin-bottom: 30px;
            color: #1e3a8a;
            font-weight: 700;
        }

        .table-responsive {
            overflow-x: auto; /* Enables horizontal scrolling on small screens */
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 0 auto; /* Center the table if it's narrower than its container */
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden; /* Ensures rounded corners apply to table content */
        }

        table thead {
            background-color: #2563eb; /* Primary blue for table header */
            color: white;
        }

        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0; /* Light border for rows */
        }

        table th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
        }

        table tbody tr:nth-child(even) {
            background-color: #f8f8f8; /* Zebra striping for readability */
        }

        table tbody tr:hover {
            background-color: #eef7ff; /* Light blue on hover */
        }

        .error-message, .no-data-message {
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

        .no-data-message {
            background-color: #fff3cd; /* Light yellow for no data */
            color: #856404;
            border-color: #ffeeba;
        }

        .back-button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background-color: #95a5a6; /* Grey for back button */
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-weight: 500;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .back-button:hover {
            background-color: #7f8c8d; /* Darker grey on hover */
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
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

        /* --- Notification/Popup Styling --- */
        .notification-popup {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4CAF50; /* Green for success */
            color: white;
            padding: 15px 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            font-size: 1em;
            font-weight: 500;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 10px;
            opacity: 0;
            transform: translateY(-20px);
            transition: opacity 0.4s ease-out, transform 0.4s ease-out;
        }

        .notification-popup.show {
            opacity: 1;
            transform: translateY(0);
        }

        .notification-popup.error {
            background-color: #f44336; /* Red for error */
        }

        .notification-popup .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.2em;
            cursor: pointer;
            margin-left: 10px;
            transition: transform 0.2s ease;
        }

        .notification-popup .close-btn:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>
    <header>
        <h2>Policy Management</h2>
    </header>

    <div class="main-content-wrapper">
        <div class="container">
            <h2>All Vehicle Insurance Policies</h2>

            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Policy No</th>
                            <th>Vehicle No</th>
                            <th>Customer Name</th>
                            <th>Phone No</th>
                            <th>Premium Amt</th>
                            <th>From Date</th>
                            <th>To Date</th>
                            <th>Policy Type</th>
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
                                rs = stmt.executeQuery("SELECT * FROM Policy ORDER BY policyId ASC");

                                if (!rs.isBeforeFirst()) { // Check if ResultSet is empty
                        %>
                                    <tr><td colspan="8" class="no-data-message">No policies found in the system.</td></tr>
                        <%
                                } else {
                                    while (rs.next()) {
                        %>
                                        <tr>
                                            <td><%= rs.getInt("policyId") %></td>
                                            <td><%= rs.getString("vehicleNo") %></td>
                                            <td><%= rs.getString("customerName") %></td>
                                            <td><%= rs.getString("phoneNo") %></td>
                                            <td><%= String.format("%.2f", rs.getDouble("premiumAmt")) %></td>
                                            <td><%= rs.getDate("fromDate") %></td>
                                            <td><%= rs.getDate("toDate") %></td>
                                            <td><%= rs.getString("type") %></td>
                                        </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace(); // Log the error on the server
                        %>
                                <tr><td colspan="8" class="error-message">Error loading policies: <%= e.getMessage() %></td></tr>
                        <%
                            } finally {
                                try {
                                    if (rs != null) rs.close();
                                    if (stmt != null) stmt.close();
                                    if (conn != null) conn.close();
                                } catch (SQLException ex) {
                                    ex.printStackTrace(); // Log resource closing errors
                        %>
                                    <tr><td colspan="8" class="error-message">Error closing resources: <%= ex.getMessage() %></td></tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <a href="underwriterHome.jsp" class="back-button">Back to Dashboard</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Vehial Insurance. All rights reserved.</p>
    </footer>

    <%-- Notification/Popup Display Logic (for messages set by other servlets/JSPs) --%>
    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");

        // Helper function to escape JavaScript string literals
        String escapedSuccessMessage = (successMessage != null) ?
            successMessage.replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r") : "";
        String escapedErrorMessage = (errorMessage != null) ?
            errorMessage.replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r") : "";
    %>

    <div id="notificationPopup" class="notification-popup">
        <span id="notificationText"></span>
        <button class="close-btn" onclick="hideNotification()">&times;</button>
    </div>

    <script>
        const notificationPopup = document.getElementById('notificationPopup');
        const notificationText = document.getElementById('notificationText');

        function showNotification(message, isError = false) {
            notificationText.textContent = message;
            if (isError) {
                notificationPopup.classList.add('error');
            } else {
                notificationPopup.classList.remove('error');
            }
            notificationPopup.classList.add('show');

            // Auto-hide after 5 seconds if it's a success message
            if (!isError) {
                setTimeout(() => {
                    hideNotification();
                }, 5000);
            }
        }

        function hideNotification() {
            notificationPopup.classList.remove('show');
            // Optional: Clear text after animation to prevent flickering if shown again quickly
            setTimeout(() => {
                notificationText.textContent = '';
            }, 500);
        }

        // Check for messages on page load
        window.onload = function() {
            const successMsg = "<%= escapedSuccessMessage %>";
            const errorMsg = "<%= escapedErrorMessage %>";

            if (successMsg) {
                showNotification(successMsg, false);
            } else if (errorMsg) {
                showNotification(errorMsg, true);
            }
        };
    </script>
</body>
</html>
