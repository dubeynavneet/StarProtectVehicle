<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Star Protect Vehicle Insurance</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to bottom, #1f0c4f, #3a1772);
            color: white;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            background-color: #180b42;
        }

        .header h1 {
            font-size: 26px;
        }

        .header .btn-group a button {
            background: #00c853;
            border: none;
            color: white;
            padding: 12px 24px;
            margin-left: 15px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }

        .header .btn-group a:first-child button {
            background: #2c3e50;
        }

        .hero {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 50px;
        }

        .hero-text {
            max-width: 600px;
        }

        .hero-text h2 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .hero-text p {
            font-size: 18px;
            margin: 10px 0;
        }

        .badges span {
            display: inline-block;
            background-color: #2ecc71;
            color: white;
            padding: 5px 10px;
            margin: 5px;
            border-radius: 20px;
            font-size: 14px;
        }

        .form-section {
            margin-top: 30px;
        }

        .form-section input {
            padding: 12px;
            width: 300px;
            border-radius: 8px;
            border: none;
            font-size: 16px;
        }

        .form-section button {
            padding: 12px 24px;
            margin-left: 10px;
            background-color: #00e676;
            border: none;
            font-size: 16px;
            color: white;
            border-radius: 8px;
            cursor: pointer;
        }

        .vehicle-toggle {
            margin: 30px 0;
        }

        .vehicle-toggle button {
            background-color: transparent;
            color: white;
            font-size: 18px;
            padding: 10px 20px;
            border: 2px solid white;
            margin-right: 10px;
            border-radius: 20px;
            cursor: pointer;
        }

        .vehicle-toggle button.active {
            background-color: #00c853;
        }

        .right-image img {
            width: 400px;
            border-radius: 20px;
        }

        footer {
            background-color: #0e0635;
            padding: 15px;
            text-align: center;
            font-size: 14px;
            color: #b2bec3;
        }

        /* Popup Modal */
        #popupModal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: 999;
            justify-content: center;
            align-items: center;
        }

        #popupModal .modal-content {
            background: white;
            padding: 30px 40px;
            border-radius: 10px;
            color: black;
            text-align: center;
        }

        #popupModal .modal-content button {
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #00c853;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>

    <script>
        function toggleVehicle(type) {
            document.getElementById('vehicleType').value = type;

            document.getElementById('carBtn').classList.remove('active');
            document.getElementById('bikeBtn').classList.remove('active');

            if (type === 'car') {
                document.getElementById('carBtn').classList.add('active');
            } else {
                document.getElementById('bikeBtn').classList.add('active');
            }
        }

        function handleCheckPrices(event) {
            event.preventDefault(); // Stop form submission
            const vehicleNumber = document.getElementById('vehicleNumber').value.trim();

            if (vehicleNumber === "") {
                alert("Please enter your vehicle number.");
                return false;
            }

            // Show modal popup
            document.getElementById('popupModal').style.display = 'flex';
            return false;
        }

        function closeModal() {
            document.getElementById('popupModal').style.display = 'none';
        }
    </script>
</head>
<body>

<div class="header">
    <h1>Star Protect Insurance</h1>
    <div class="btn-group">
        <a href="login.jsp?role=admin"><button>Login as Admin</button></a>
        <a href="login.jsp?role=underwriter"><button>Login as Underwriter</button></a>
    </div>
</div>

<div class="hero">
    <div class="hero-text">
        <h2>Buy or Renew Vehicle Insurance in 2 Minutes ⚡</h2>
        <div class="badges">
            <span>✔ Affordable Premiums</span>
            <span>✔ Hassle-Free Claims</span>
            <span>✔ No Paperwork</span>
        </div>

        <div class="vehicle-toggle">
            <button id="carBtn" class="active" onclick="toggleVehicle('car')">Car</button>
            <button id="bikeBtn" onclick="toggleVehicle('bike')">Bike</button>
        </div>

        <div class="form-section">
            <form onsubmit="return handleCheckPrices(event);">
                <input type="text" name="vehicleNumber" id="vehicleNumber" placeholder="Enter your vehicle number" required />
                <input type="hidden" name="vehicleType" id="vehicleType" value="car" />
                <button type="submit">Check Prices</button>
            </form>
        </div>
    </div>

    <div class="right-image">
        <img src="images/vehicle-hero.png" alt="Vehicle Insurance" />
    </div>
</div>

<!-- Popup Modal -->
<div id="popupModal">
    <div class="modal-content">
        <p style="font-size: 18px;">Please login to know better!</p>
        <button onclick="closeModal()">Close</button>
    </div>
</div>

<footer>
    <p>&copy; 2025 Star Protect Vehicle Insurance | All Rights Reserved.</p>
</footer>

</body>
</html>
