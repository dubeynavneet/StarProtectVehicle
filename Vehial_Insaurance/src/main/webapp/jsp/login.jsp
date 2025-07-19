<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form method="post" action="<%=request.getParameter("role").equals("admin") ? "../adminLogin" : "../underwriterLogin"%>">
        <label for="userid">User ID</label>
        <input type="text" name="userid" required>
        <label for="password">Password</label>
        <input type="password" name="password" required>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>