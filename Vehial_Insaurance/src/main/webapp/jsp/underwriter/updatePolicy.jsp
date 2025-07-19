<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Update Policy</title>
    <link rel="stylesheet" href="../../css/style.css">
</head>
<body>
<div class="container">
    <h2>Update Policy Type</h2>
    <form method="post" action="../../updatePolicyType">
        Policy ID: <input type="number" name="policyId" required><br>
        <button type="submit">Update</button>
    </form>
    <a href="underwriterHome.jsp"><button>Back</button></a>
</div>
</body>
</html>