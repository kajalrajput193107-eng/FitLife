<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>VegivaFit - Register</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #111827;
            color: white;
        }

        .container {
            width: 450px;
            margin: 50px auto;
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
            margin-top: 15px;
            margin-bottom: 5px;
        }

        input, select {
            width: 100%;
            padding: 11px;
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

        .login {
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

    <h1>Create Account</h1>

    <form action="RegisterServlet" method="post">

        <label>Name</label>
        <input type="text" name="name" required>

        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <label>Age</label>
        <input type="number" name="age" min="1" max="100" required>

        <label>Gender</label>
        <select name="gender" required>
            <option value="">Select Gender</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>

        <label>Fitness Goal</label>
        <select name="goal" required>
            <option value="">Select Goal</option>
            <option value="Weight Loss">Weight Loss</option>
            <option value="Weight Gain">Weight Gain</option>
            <option value="Muscle Building">Muscle Building</option>
            <option value="Fitness">General Fitness</option>
        </select>

        <button type="submit">Register</button>

    </form>

    <div class="login">
        Already have an account?
        <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>