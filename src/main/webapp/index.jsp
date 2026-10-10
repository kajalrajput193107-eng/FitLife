<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FitLife - Fitness Management</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f5f7fa;
            color: #222;
        }

        /* Navigation Bar */

        nav {
            height: 70px;
            background: #111827;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 8%;
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: white;
        }

        .logo span {
            color: #22c55e;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 30px;
        }

        nav ul li a {
            text-decoration: none;
            color: white;
            font-size: 16px;
        }

        nav ul li a:hover {
            color: #22c55e;
        }

        .login-btn {
            background: #22c55e;
            padding: 10px 20px;
            border-radius: 6px;
        }

        .login-btn:hover {
            color: white;
        }

        /* Hero Section */

        .hero {
            min-height: 520px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 60px 8%;
            background: linear-gradient(135deg, #111827, #1f2937);
            color: white;
        }

        .hero-text {
            width: 50%;
        }

        .hero-text h1 {
            font-size: 55px;
            margin-bottom: 20px;
        }

        .hero-text h1 span {
            color: #22c55e;
        }

        .hero-text p {
            font-size: 19px;
            line-height: 1.7;
            color: #d1d5db;
            margin-bottom: 30px;
        }

        .start-btn {
            display: inline-block;
            background: #22c55e;
            color: white;
            text-decoration: none;
            padding: 14px 28px;
            border-radius: 7px;
            font-size: 17px;
            font-weight: bold;
        }

        .start-btn:hover {
            background: #16a34a;
        }

        .hero-image {
            width: 40%;
            text-align: center;
            font-size: 150px;
        }

        /* Features */

        .features {
            padding: 60px 8%;
            text-align: center;
        }

        .features h2 {
            font-size: 35px;
            margin-bottom: 40px;
        }

        .feature-container {
            display: flex;
            justify-content: center;
            gap: 25px;
            flex-wrap: wrap;
        }

        .card {
            width: 250px;
            background: white;
            padding: 30px 20px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .card .icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .card h3 {
            margin-bottom: 10px;
            font-size: 21px;
        }

        .card p {
            color: #666;
            line-height: 1.5;
        }

        /* Footer */

        footer {
            background: #111827;
            color: white;
            text-align: center;
            padding: 25px;
            margin-top: 20px;
        }

        footer span {
            color: #22c55e;
        }

        /* Responsive Design */

        @media (max-width: 800px) {

            nav {
                padding: 0 5%;
            }

            nav ul {
                gap: 15px;
            }

            nav ul li a {
                font-size: 14px;
            }

            .hero {
                flex-direction: column;
                text-align: center;
                padding: 50px 5%;
            }

            .hero-text {
                width: 100%;
            }

            .hero-text h1 {
                font-size: 40px;
            }

            .hero-text p {
                font-size: 16px;
            }

            .hero-image {
                width: 100%;
                font-size: 100px;
                margin-top: 30px;
            }
        }

    </style>

</head>

<body>

    <!-- Navigation -->

    <nav>

        <div class="logo">
            Fit<span>Life</span>
        </div>

        <ul>

            <li>
                <a href="index.jsp">Home</a>
            </li>

            <li>
                <a href="WorkoutServlet">Workouts</a>
            </li>

            <li>
                <a href="#">Diet</a>
            </li>

            <li>
                <a href="#">BMI Calculator</a>
            </li>

            <li>
                <a href="login.jsp" class="login-btn">Login</a>
            </li>

        </ul>

    </nav>


    <!-- Hero Section -->

    <section class="hero">

        <div class="hero-text">

            <h1>
                Build Your <span>Best</span> Self
            </h1>

            <p>
                Welcome to FitLife, your personal fitness management
                platform. Track your workouts, calculate your BMI,
                follow healthy diet plans and monitor your progress.
            </p>

            <a href="login.jsp" class="start-btn">
                Start Your Journey
            </a>

        </div>

        <div class="hero-image">
            🏋️‍♀️
        </div>

    </section>


    <!-- Features -->

    <section class="features">

        <h2>Everything You Need</h2>

        <div class="feature-container">


            <!-- Workout Card -->

            <div class="card">

                <div class="icon">🏋️</div>

                <h3>Workouts</h3>

                <p>
                    Explore different exercises and create
                    your workout routine.
                </p>

            </div>


            <!-- Diet Card -->

            <div class="card">

                <div class="icon">🥗</div>

                <h3>Diet Plans</h3>

                <p>
                    Find healthy meal plans according to
                    your fitness goal.
                </p>

            </div>


            <!-- BMI Card -->

            <div class="card">

                <div class="icon">⚖️</div>

                <h3>BMI Calculator</h3>

                <p>
                    Calculate your BMI and understand your
                    fitness level.
                </p>

            </div>


            <!-- Progress Card -->

            <div class="card">

                <div class="icon">📊</div>

                <h3>Track Progress</h3>

                <p>
                    Record your weight and monitor your
                    fitness progress.
                </p>

            </div>


        </div>

    </section>


    <!-- Footer -->

    <footer>

        <p>
            © 2026 <span>FitLife</span> | Fitness Management System
        </p>

    </footer>

</body>

</html>