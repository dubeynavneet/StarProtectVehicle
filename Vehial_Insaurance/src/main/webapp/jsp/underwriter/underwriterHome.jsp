<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Underwriter Home</title>
    <link rel="stylesheet" href="../../css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f2f6fc;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #1e3a8a;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 24px;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 50px;
        }

        .card {
            background: white;
            padding: 30px 50px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            border-radius: 16px;
            display: flex;
            flex-direction: column;
            gap: 20px;
            width: 350px;
        }

        .card a button {
            background-color: #2563eb;
            color: white;
            border: none;
            padding: 12px 18px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .card a button:hover {
            background-color: #1d4ed8;
        }

        .card a {
            text-decoration: none;
        }
    </style>
</head>
<body>
    <header><h2>Underwriter Dashboard</h2></header>
    <div class="container">
        <div class="card">
            <a href="jsp/underwriter/createPolicy.jsp"><button>Create Policy</button></a>
            <a href="jsp/underwriter/renewPolicy.jsp"><button>Renew Policy</button></a>
            <a href="jsp/underwriter/updatePolicy.jsp"><button>Update Policy Type</button></a>
            <a href="jsp/underwriter/viewPolicy.jsp"><button>View Policies</button></a>
            <a href="Vehial_Insaurance/jsp/index.jsp"><button>Logout</button></a>
        </div>
    </div>
</body>
</html>
