<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Invalid Underwriter ID - Star Protect</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f4f0fe, #ebe2ff);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 100px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            text-align: center;
            padding: 40px 30px;
        }

        h2 {
            color: #d8000c;
            margin-bottom: 20px;
        }

        .btn-group {
            margin-top: 30px;
        }

        .btn {
            display: inline-block;
            margin: 10px;
            padding: 12px 24px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            color: white;
            background-color: #007bff;
        }

        .btn.secondary {
            background-color: #6c757d;
        }

        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Invalid Underwriter ID</h2>
        <p>The ID you entered does not match any records.</p>

        <div class="btn-group">
            <a href="underwriterLogin.jsp" class="btn">Re-enter Underwriter ID</a>
            <a href="index.jsp" class="btn secondary">Go Back to Home</a>
        </div>
    </div>
</body>
</html>
