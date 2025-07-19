<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Renew Policy</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>Renew Vehicle Insurance Policy</h2>
    <form method="post" action="../../renewPolicy">
        Policy ID: <input type="number" name="policyId" required><br>
        Vehicle Value: <input type="number" name="vehicleValue" required><br>
        Vehicle Type:
        <select name="vehicleType" required>
            <option value="2-wheeler">2-wheeler</option>
            <option value="4-wheeler">4-wheeler</option>
        </select><br>
        <button type="submit">Renew</button>
    </form>
    <a href="underwriterHome.jsp"><button>Back</button></a>
</div>
</body>
</html>