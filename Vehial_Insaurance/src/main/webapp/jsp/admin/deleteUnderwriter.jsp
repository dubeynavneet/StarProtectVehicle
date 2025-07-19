<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Delete Underwriter</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>Delete Underwriter</h2>
    <form method="post" action="../../deleteUnderwriter">
        Underwriter ID: <input type="number" name="id" required><br>
        <button type="submit">Delete</button>
    </form>
    <a href="adminHome.jsp"><button>Back</button></a>
</div>
</body>
</html>