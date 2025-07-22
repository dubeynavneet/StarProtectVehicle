<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Vehial Insurance</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #6a11cb 0%, #2575fc 100%) no-repeat center center fixed; /* Vibrant gradient background */
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.95); /* Slightly transparent white background */
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2); /* Deeper shadow for depth */
            width: 100%;
            max-width: 420px;
            text-align: center;
            backdrop-filter: blur(5px); /* Subtle blur effect for background */
            -webkit-backdrop-filter: blur(5px); /* Safari support */
            position: relative; /* For positioning the error message */
        }

        .login-container h2 {
            font-size: 2.2em;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: 700;
        }

        .login-container form {
            display: flex;
            flex-direction: column;
            gap: 20px; /* Spacing between form elements */
        }

        .login-container label {
            text-align: left;
            font-size: 1.1em;
            color: #555;
            margin-bottom: -5px; /* Adjust label spacing */
            font-weight: 500;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: calc(100% - 20px); /* Account for padding */
            padding: 12px 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.08); /* Inner shadow for input fields */
        }

        .login-container input[type="text"]:focus,
        .login-container input[type="password"]:focus {
            border-color: #3498db;
            box-shadow: 0 0 8px rgba(52, 152, 219, 0.4); /* Glow effect on focus */
            outline: none;
        }

        .login-container button[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 14px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1.15em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-top: 15px;
            font-weight: 600;
        }

        .login-container button[type="submit"]:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2); /* Lift and shadow on hover */
        }

        .footer-text {
            margin-top: 30px;
            font-size: 0.9em;
            color: #7f8c8d;
        }

        /* Error Message Styling */
        .error-message {
            background-color: #ffdddd;
            color: #d8000c;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #d8000c;
            margin-bottom: 25px; /* Space between error and form */
            font-size: 0.95em;
            font-weight: 500;
            text-align: left;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .error-message .retry-button {
            background-color: #e74c3c;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background-color 0.3s ease;
            text-decoration: none; /* For anchor tag */
            display: inline-block;
        }

        .error-message .retry-button:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Welcome Back!</h2>

        <%-- Check if an error message exists in the request scope --%>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            <div class="error-message">
                <p><%= errorMessage %></p>
                <a href="jsp/login.jsp?role=<%= request.getParameter("role") %>" class="retry-button">Try Again</a>
            </div>
        <% } %>

        <form method="post" action="<%=request.getParameter("role") != null && request.getParameter("role").equals("admin") ? "../adminLogin" : "../underwriterLogin"%>">
            <label for="userid">User ID</label>
            <input type="text" id="userid" name="userid" required autofocus>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Login</button>
        </form>
        <p class="footer-text">© 2025 Vehial Insurance. All rights reserved.</p>
    </div>
</body>
</html>
