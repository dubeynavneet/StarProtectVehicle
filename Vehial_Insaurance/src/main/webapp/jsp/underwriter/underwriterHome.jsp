<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Underwriter Dashboard - Vehial Insurance</title>
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
            align-items: center;
            padding: 40px 20px; /* Added padding for overall spacing */
        }

        .card {
            background: white;
            padding: 40px 50px; /* Increased padding */
            box-shadow: 0 10px 30px rgba(0,0,0,0.15); /* Deeper shadow */
            border-radius: 20px; /* More rounded corners */
            display: flex;
            flex-direction: column;
            gap: 20px; /* Spacing between buttons */
            width: 100%;
            max-width: 400px; /* Max width for the card */
            text-align: center;
        }

        .card h3 {
            font-size: 1.8em;
            margin-bottom: 20px;
            color: #1e3a8a;
            font-weight: 700;
        }

        .card a {
            text-decoration: none;
            width: 100%; /* Ensure link takes full width for button */
        }

        .card button {
            background-color: #2563eb; /* Primary blue button */
            color: white;
            border: none;
            padding: 15px 25px; /* Larger padding for buttons */
            border-radius: 10px; /* More rounded buttons */
            font-size: 1.1em; /* Larger font size */
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            width: 100%; /* Full width button */
            font-weight: 500;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Subtle button shadow */
        }

        .card button:hover {
            background-color: #1d4ed8; /* Darker blue on hover */
            transform: translateY(-2px); /* Lift effect on hover */
            box-shadow: 0 6px 12px rgba(0,0,0,0.15); /* Enhanced shadow on hover */
        }

        .card button.logout-button {
            background-color: #e74c3c; /* Red for logout button */
            margin-top: 10px; /* Space above logout button */
        }

        .card button.logout-button:hover {
            background-color: #c0392b; /* Darker red on hover */
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
        <h2>Underwriter Dashboard</h2>
    </header>

    <div class="main-content-wrapper">
        <div class="card">
            <h3>Welcome, Underwriter!</h3>
            <a href="jsp/underwriter/createPolicy.jsp"><button>Create Policy</button></a>
            <a href="jsp/underwriter/renewPolicy.jsp"><button>Renew Policy</button></a>
            <a href="jsp/underwriter/updatePolicy.jsp"><button>Update Policy Type</button></a>
            <a href="jsp/underwriter/viewPolicy.jsp"><button>View Policies</button></a>
            <a href="/Vehial_Insaurance/jsp/index.jsp"><button class="logout-button">Logout</button></a>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Vehial Insurance. All rights reserved.</p>
    </footer>
</body>
</html>
