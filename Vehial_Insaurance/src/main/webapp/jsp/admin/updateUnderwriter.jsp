<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update Underwriter Password</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>Update Underwriter Password</h2>
    <form method="post" action="../../updateUnderwriter">
        Underwriter ID: <input type="number" name="id" required><br>
        New Password: <input type="password" name="password" required><br>
        <button type="submit">Update</button>
    </form>
    <a href="adminHome.jsp"><button>Back</button></a>
</div>
</body>
</html>