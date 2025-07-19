<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Underwriter</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>Register New Underwriter</h2>
    <form method="post" action="../../addUnderwriter">
        Name: <input type="text" name="name" maxlength="50" required><br>
        DOB: <input type="date" name="dob" required><br>
        Password: <input type="password" name="password" maxlength="30" required><br>
        <button type="submit">Register</button>
    </form>
    <a href="adminHome.jsp"><button>Back</button></a>
</div>
</body>
</html>