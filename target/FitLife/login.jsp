<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FitLife - Login</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #111827;
            color: white;
        }

        .container {
            width: 400px;
            margin: 80px auto;
            background: #1f2937;
            padding: 30px;
            border-radius: 12px;
        }

        h1 {
            text-align: center;
            color: #22c55e;
        }

        label {
            display: block;
            margin-top: 18px;
            margin-bottom: 6px;
        }

        input {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: none;
            border-radius: 6px;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 12px;
            background: #22c55e;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #16a34a;
        }

        .register {
            text-align: center;
            margin-top: 20px;
        }

        a {
            color: #22c55e;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>FitLife Login</h1>

    <form action="LoginServlet" method="post">

        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>

    </form>

    <div class="register">
        Don't have an account?
        <a href="register.jsp">Register</a>
    </div>

</div>

</body>
</html>