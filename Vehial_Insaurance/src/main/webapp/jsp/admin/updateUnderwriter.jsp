<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Underwriter Password - Vehial Insurance</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #a1c4fd, #c2e9fb); /* Softer gradient background */
            background-size: cover;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #333;
        }

        .main-content-wrapper {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .form-container {
            background-color: rgba(255, 255, 255, 0.98);
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px;
            text-align: center;
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
        }

        .form-container h2 {
            font-size: 2.2em;
            margin-bottom: 20px;
            color: #2c3e50;
            font-weight: 700;
        }

        .form-container p.description {
            font-size: 1em;
            color: #7f8c8d;
            margin-bottom: 30px;
        }

        .form-container form {
            display: flex;
            flex-direction: column;
            gap: 20px;
            align-items: flex-start;
        }

        .form-group {
            width: 100%;
            text-align: left;
        }

        .form-container label {
            font-size: 1.05em;
            color: #555;
            margin-bottom: 5px;
            display: block;
            font-weight: 500;
        }

        .form-container input[type="number"],
        .form-container input[type="password"] {
            width: calc(100% - 24px); /* Account for padding and border */
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.08);
        }

        .form-container input[type="number"]:focus,
        .form-container input[type="password"]:focus {
            border-color: #3498db;
            box-shadow: 0 0 8px rgba(52, 152, 219, 0.4);
            outline: none;
        }

        .form-container button[type="submit"] {
            background-color: #f39c12; /* Orange for update button */
            color: white;
            padding: 14px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1.15em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-top: 15px;
            font-weight: 600;
            width: 100%;
        }

        .form-container button[type="submit"]:hover {
            background-color: #e67e22; /* Darker orange on hover */
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }

        .back-button {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            background-color: #95a5a6; /* Grey for back button */
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
            background-color: #7f8c8d; /* Darker grey on hover */
            transform: translateY(-2px);
        }

        footer {
            margin-top: auto;
            text-align: center;
            padding: 20px;
            color: #7f8c8d;
            font-size: 0.9em;
            width: 100%;
        }

        /* --- Notification/Popup Styling --- */
        .notification-popup {
            position: fixed;
            top: 20px; /* Position from top */
            right: 20px; /* Position from right */
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
            opacity: 0; /* Start hidden */
            transform: translateY(-20px); /* Start slightly above */
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
    <div class="main-content-wrapper">
        <div class="form-container">
            <h2>Update Underwriter Password</h2>
            <p class="description">Enter the Underwriter ID and the new password to update their credentials.</p>

            <form id="updatePasswordForm" method="post" action="<%= request.getContextPath() %>/updateUnderwriter" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="id">Underwriter ID:</label>
                    <input type="number" id="id" name="id" required placeholder="e.g., 101">
                </div>

                <div class="form-group">
                    <label for="password">New Password:</label>
                    <input type="password" id="password" name="password" required placeholder="Enter new password">
                </div>

                <button type="submit">Update Password</button>
            </form>

            <a href="adminHome.jsp" class="back-button">Back to Dashboard</a>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Vehial Insurance. All rights reserved.</p>
    </footer>

    <%-- Notification/Popup Display Logic --%>
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

        // --- Client-side Validation Functions ---

        function validateUnderwriterID() {
            const idInput = document.getElementById('id');
            const idValue = idInput.value.trim();

            if (idValue === "" || isNaN(idValue) || parseInt(idValue) <= 0) {
                showNotification("Underwriter ID must be a positive number.", true);
                idInput.focus();
                return false;
            }
            return true;
        }

        function validatePassword() {
            const passwordInput = document.getElementById('password');
            const passwordValue = passwordInput.value;

            // Minimum length
            if (passwordValue.length < 8) {
                showNotification("Password must be at least 8 characters long.", true);
                passwordInput.focus();
                return false;
            }
            // Requires at least one uppercase letter, one lowercase letter, one number, and one special character
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+}{"':;?/>.<,])(?=.*[^\s]).{8,}$/;
            if (!passwordRegex.test(passwordValue)) {
                showNotification("Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.", true);
                passwordInput.focus();
                return false;
            }
            return true;
        }

        function validateForm() {
            // Validate each field. If any validation fails, stop and return false.
            if (!validateUnderwriterID()) {
                return false;
            }
            if (!validatePassword()) {
                return false;
            }

            // If all validations pass
            return true;
        }

        // Check for messages on page load (from server-side validation/submission)
        window.onload = function() {
            // Use the escaped messages
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
