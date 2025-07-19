<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Create Policy</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>Create New Vehicle Insurance Policy</h2>
    <form method="post" action="../../createPolicy">
        Vehicle No: <input type="text" name="vehicleNo" maxlength="10" required><br>
        Vehicle Type: 
        <select name="vehicleType" required>
            <option value="2-wheeler">2-wheeler</option>
            <option value="4-wheeler">4-wheeler</option>
        </select><br>
        Customer Name: <input type="text" name="customerName" maxlength="50" required><br>
        Engine No: <input type="number" name="engineNo" required><br>
        Chasis No: <input type="number" name="chasisNo" required><br>
        Phone No: <input type="text" name="phoneNo" maxlength="10" required><br>
        Type: 
        <select name="type" required>
            <option value="Full Insurance">Full Insurance</option>
            <option value="Third Party">Third Party</option>
        </select><br>
        From Date: <input type="date" name="fromDate" required><br>
        Vehicle Value: <input type="number" name="vehicleValue" required><br>
        Underwriter ID: <input type="number" name="underwriterId" required><br>
        <button type="submit">Submit</button>
    </form>
    <a href="underwriterHome.jsp"><button>Back</button></a>
</div>
</body>
</html>