<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Home</title>
    <link rel="stylesheet" href="../../css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f8;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }

        .container h3 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
        }

        .card-button {
            display: block;
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            background-color: #3498db;
            color: white;
            text-align: center;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        .card-button:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<header><h2>Admin Dashboard</h2></header>
<div class="container">
    <h3>Welcome, Admin</h3>
    <a href="jsp/admin/addUnderwriter.jsp" class="card-button">Register Underwriter</a>
    <a href="jsp/admin/viewUnderwriters.jsp" class="card-button">View All Underwriters</a>
    <a href="jsp/admin/updateUnderwriter.jsp" class="card-button">Update Underwriter Password</a>
    <a href="jsp/admin/deleteUnderwriter.jsp" class="card-button">Delete Underwriter</a>
    <a href="/Vehial_Insaurance/jsp/index.jsp" class="card-button" style="background-color: #e74c3c;">Logout</a>
</div>
</body>
</html>
