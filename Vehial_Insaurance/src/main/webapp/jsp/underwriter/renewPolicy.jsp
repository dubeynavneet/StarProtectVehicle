<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Renew Policy - Vehial Insurance</title>
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

        .main-content-wrapper {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .form-container {
            background-color: rgba(255, 255, 255, 0.98);
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px; /* Adjusted width for fewer fields */
            text-align: center;
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
        }

        .form-container h2 {
            font-size: 2.2em;
            margin-bottom: 20px;
            color: #1e3a8a;
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
        .form-container select {
            width: calc(100% - 24px); /* Account for padding and border */
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.08);
            -webkit-appearance: none; /* Remove default select styling */
            -moz-appearance: none;
            appearance: none;
            background-color: white;
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007BB5%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13.2-6.4H18.6a17.6%2017.6%200%200%200-13.2%206.4%2017.6%2017.6%200%200%200%200%2025.2l128%20128c6.8%206.8%2017.9%206.8%2024.7%200l128-128c6.8-6.8%206.8-17.9%200-24.7z%22%2F%3E%3C%2Fsvg%3E'); /* Custom arrow for select */
            background-repeat: no-repeat;
            background-position: right 10px top 50%;
            background-size: 12px auto;
        }

        .form-container input[type="number"]:focus,
        .form-container select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 8px rgba(37, 99, 235, 0.4);
            outline: none;
        }

        .form-container button[type="submit"] {
            background-color: #007bff; /* Blue for renew button */
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
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .form-container button[type="submit"]:hover {
            background-color: #0056b3; /* Darker blue on hover */
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
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
    <div class="main-content-wrapper">
        <div class="form-container">
            <h2>Renew Vehicle Insurance Policy</h2>
            <p class="description">Enter the Policy ID, updated Vehicle Value, and Vehicle Type to renew an existing policy.</p>

            <form id="renewPolicyForm" method="post" action="<%= request.getContextPath() %>/renewPolicy" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="policyId">Policy ID:</label>
                    <input type="number" id="policyId" name="policyId" required placeholder="e.g., 1001">
                </div>

                <div class="form-group">
                    <label for="vehicleValue">New Vehicle Value:</label>
                    <input type="number" id="vehicleValue" name="vehicleValue" required placeholder="e.g., 450000">
                </div>

                <div class="form-group">
                    <label for="vehicleType">Vehicle Type:</label>
                    <select id="vehicleType" name="vehicleType" required>
                        <option value="">-- Select Vehicle Type --</option>
                        <option value="2-wheeler">2-wheeler</option>
                        <option value="4-wheeler">4-wheeler</option>
                    </select>
                </div>

                <button type="submit">Renew Policy</button>
            </form>

            <a href="underwriterHome.jsp" class="back-button">Back to Dashboard</a>
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

        function validatePolicyID() {
            const input = document.getElementById('policyId');
            const value = input.value.trim();
            if (value === "" || isNaN(value) || parseInt(value) <= 0) {
                showNotification("Policy ID must be a positive number.", true);
                input.focus();
                return false;
            }
            return true;
        }

        function validateVehicleValue() {
            const input = document.getElementById('vehicleValue');
            const value = input.value.trim();
            if (value === "" || isNaN(value) || parseInt(value) <= 0) {
                showNotification("Vehicle Value must be a positive number.", true);
                input.focus();
                return false;
            }
            return true;
        }

        function validateVehicleType() {
            const input = document.getElementById('vehicleType');
            if (input.value === "") {
                showNotification("Please select a Vehicle Type.", true);
                input.focus();
                return false;
            }
            return true;
        }

        function validateForm() {
            // Validate all fields in order
            if (!validatePolicyID()) return false;
            if (!validateVehicleValue()) return false;
            if (!validateVehicleType()) return false;

            return true; // All validations passed
        }

        // Check for messages on page load (from server-side validation/submission)
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
