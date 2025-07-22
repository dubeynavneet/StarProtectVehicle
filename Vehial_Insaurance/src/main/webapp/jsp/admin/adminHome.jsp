<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5; /* Light grey background */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background-color: #2c3e50; /* Dark blue header */
            color: white;
            padding: 25px 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            font-size: 1.8em;
            font-weight: 600;
        }

        .container {
            flex-grow: 1;
            max-width: 900px; /* Wider container for cards */
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); /* Deeper shadow */
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .welcome-message {
            text-align: center;
            margin-bottom: 40px;
            color: #2c3e50;
            font-size: 1.8em;
            font-weight: 500;
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); /* Responsive grid for cards */
            gap: 25px; /* Space between cards */
            width: 100%;
            padding: 0 20px; /* Padding for grid on smaller screens */
        }

        .card {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08); /* Soft shadow for cards */
            padding: 25px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth hover effects */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Pushes button to bottom */
        }

        .card:hover {
            transform: translateY(-8px); /* Lift effect on hover */
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15); /* Enhanced shadow on hover */
        }

        .card h4 {
            color: #34495e; /* Darker text for headings */
            font-size: 1.3em;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .card p {
            color: #7f8c8d; /* Muted text for descriptions */
            font-size: 0.95em;
            line-height: 1.5;
            margin-bottom: 20px;
            flex-grow: 1; /* Allows paragraph to take available space */
        }

        .card-button {
            display: inline-block;
            width: 100%;
            padding: 12px 0;
            background-color: #3498db; /* Primary blue button */
            color: white;
            text-align: center;
            border: none;
            border-radius: 10px;
            font-size: 1em;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        .card-button:hover {
            background-color: #2980b9; /* Darker blue on hover */
            transform: translateY(-2px);
        }

        .card-button.logout {
            background-color: #e74c3c; /* Red for logout button */
            margin-top: 30px; /* Space above logout button */
        }

        .card-button.logout:hover {
            background-color: #c0392b; /* Darker red on hover */
        }

        footer {
            margin-top: 50px;
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
            font-size: 0.9em;
            background-color: #f9f9f9; /* Light footer background */
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <header>
        <h2>Admin Dashboard</h2>
    </header>

    <div class="container">
        <h3 class="welcome-message">Welcome, Admin! 👋</h3>
        <div class="card-grid">
            <div class="card">
                <h4>Register Underwriter</h4>
                <p>Add new underwriters to the system with their details and credentials.</p>
                <a href="jsp/admin/addUnderwriter.jsp" class="card-button">Register Now</a>
            </div>

            <div class="card">
                <h4>View All Underwriters</h4>
                <p>Browse a comprehensive list of all registered underwriters and their profiles.</p>
                <a href="jsp/admin/viewUnderwriters.jsp" class="card-button">View Underwriters</a>
            </div>

            <div class="card">
                <h4>Update Underwriter Password</h4>
                <p>Modify the password for an existing underwriter account for security purposes.</p>
                <a href="jsp/admin/updateUnderwriter.jsp" class="card-button">Update Password</a>
            </div>

            <div class="card">
                <h4>Delete Underwriter</h4>
                <p>Remove an underwriter's account from the system permanently.</p>
                <a href="jsp/admin/deleteUnderwriter.jsp" class="card-button">Delete Underwriter</a>
            </div>

            <%-- You can add more cards here for other admin functionalities --%>
            <%--
            <div class="card">
                <h4>Manage Policies</h4>
                <p>View, edit, or create new insurance policies.</p>
                <a href="jsp/admin/managePolicies.jsp" class="card-button">Manage Policies</a>
            </div>

            <div class="card">
                <h4>Generate Reports</h4>
                <p>Access various reports related to sales, claims, and user activity.</p>
                <a href="jsp/admin/generateReports.jsp" class="card-button">Generate Reports</a>
            </div>
            --%>
        </div>
        <a href="/Vehial_Insaurance/jsp/index.jsp" class="card-button logout">Logout</a>
    </div>

    <footer>
        <p>&copy; 2025 Vehial Insurance. All rights reserved.</p>
    </footer>
</body>
</html>
