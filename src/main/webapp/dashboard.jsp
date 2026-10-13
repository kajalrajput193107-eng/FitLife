
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FitLife - Dashboard</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #111827;
            color: white;
        }

        .navbar {
            background: #1f2937;
            padding: 18px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 26px;
            font-weight: bold;
            color: #22c55e;
        }

        .logout {
            color: white;
            text-decoration: none;
            background: #ef4444;
            padding: 9px 18px;
            border-radius: 6px;
        }

        .welcome {
            text-align: center;
            padding: 45px 20px 25px;
        }

        .welcome h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .welcome p {
            color: #d1d5db;
            font-size: 17px;
        }

        .dashboard {
            width: 90%;
            max-width: 1100px;
            margin: 30px auto 60px;

            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .card {
            background: #1f2937;
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .icon {
            font-size: 45px;
            margin-bottom: 15px;
        }

        .card h2 {
            color: #22c55e;
        }

        .card p {
            color: #d1d5db;
            line-height: 1.5;
        }

        .btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background: #22c55e;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }

        .btn:hover {
            background: #16a34a;
        }

        footer {
            text-align: center;
            background: #1f2937;
            padding: 20px;
            color: #9ca3af;
        }

        @media (max-width: 800px) {
            .dashboard {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

    <div class="navbar">
        <div class="logo">FitLife</div>

        <a href="LogoutServlet" class="logout">Logout</a>
    </div>


    <div class="welcome">
        <h1>
    Welcome, <%= session.getAttribute("userName") %>! ðŸ’ª
</h1>

<p>
    Your fitness goal:
    <strong>
        <%= session.getAttribute("userGoal") %>
    </strong>
</p>
    </div>


    <div class="dashboard">

        <div class="card">
            <div class="icon">&#127947;</div>
            <h2>Workouts</h2>
            <p>Explore exercises and create your workout routine.</p>
            <a href="WorkoutServlet" class="btn">View Workouts</a>
        </div>
        <div class="card">

    <div class="icon">&#127919;</div>

    <h2>Recommended Workouts</h2>

    <p>
        Get workout recommendations based on your fitness goal.
    </p>

    <a href="RecommendedWorkoutServlet" class="btn">
        View Recommendations
    </a>

</div>


        <div class="card">
            <div class="icon">&#129367;</div>
            <h2>Diet Plans</h2>
            <p>Find healthy diet plans according to your fitness goal.</p>
            <a href="DietPlanServlet" class="btn">View Diet</a>
        </div>


        <div class="card">
            <div class="icon">&#9878;&#65039;</div>
            <h2>BMI Calculator</h2>
            <p>Calculate your BMI and understand your fitness level.</p>
            <a href="${pageContext.request.contextPath}/bmi-calculator.jsp"
   class="btn">Calculate BMI</a>
        </div>


        <div class="card">
            <div class="icon">&#128202;</div>
            <h2>Track Progress</h2>
            <p>Track your weight, height and fitness progress.</p>
            <a href="${pageContext.request.contextPath}/ProgressServlet" class="btn">View Progress</a>
        </div>


        <div class="card">
            <div class="icon">&#128100;</div>
            <h2>My Profile</h2>
            <p>View and manage your personal fitness profile.</p>
            <a href="#" class="btn">My Profile</a>
        </div>


        <div class="card">
            <div class="icon">&#128293;</div>
            <h2>Fitness Goals</h2>
            <p>Stay motivated and work towards your fitness goals.</p>
            <a href="#" class="btn">My Goals</a>
        </div>

    </div>


    <footer>
        Â© 2026 FitLife | Stay Healthy â€¢ Stay Strong
    </footer>
<script>
window.addEventListener("pageshow", function(event) {
    if (event.persisted) {
        window.location.reload();
    }
});
</script>
</body>
</html>
