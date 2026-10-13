<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fitlife.model.Workout" %>
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
    <title>FitLife - Recommended Workouts</title>

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
            color: #22c55e;
            font-size: 26px;
            font-weight: bold;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .navbar a:hover {
            color: #22c55e;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 40px auto;
        }

        .heading {
            text-align: center;
            margin-bottom: 35px;
        }

        .heading h1 {
            color: #22c55e;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .heading p {
            color: #d1d5db;
            font-size: 17px;
        }

        .goal {
            color: #22c55e;
            font-weight: bold;
        }

        .workout-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .workout-card {
            background: #1f2937;
            padding: 25px;
            border-radius: 12px;
            transition: 0.3s;
        }

        .workout-card:hover {
            transform: translateY(-5px);
        }

        .workout-card h2 {
            color: #22c55e;
            margin-top: 0;
        }

        .category,
        .difficulty {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-right: 5px;
        }

        .category {
            background: #374151;
            color: #22c55e;
        }

        .difficulty {
            background: #111827;
            color: #facc15;
        }

        .details {
            display: flex;
            gap: 10px;
            margin: 18px 0;
        }

        .detail-box {
            background: #111827;
            padding: 10px;
            border-radius: 7px;
            flex: 1;
            text-align: center;
        }

        .detail-box strong {
            color: #22c55e;
        }

        .instructions {
            color: #d1d5db;
            line-height: 1.6;
        }

        .no-workout {
            text-align: center;
            background: #1f2937;
            padding: 30px;
            border-radius: 12px;
        }

        .back {
            display: block;
            width: 200px;
            margin: 40px auto;
            text-align: center;
            background: #22c55e;
            color: white;
            padding: 12px;
            border-radius: 7px;
            text-decoration: none;
        }

        .back:hover {
            background: #16a34a;
        }

        @media (max-width: 900px) {

            .workout-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 600px) {

            .workout-grid {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 15px;
            }

        }

    </style>

</head>

<body>

<div class="navbar">

    <div class="logo">FitLife</div>

    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="WorkoutServlet">All Workouts</a>
        <a href="LogoutServlet">Logout</a>
    </div>

</div>


<div class="container">

    <div class="heading">

        <h1>🎯 Recommended Workouts</h1>

        <p>
            Workouts selected according to your fitness goal:
            <span class="goal">
                <%= session.getAttribute("userGoal") %>
            </span>
        </p>

    </div>


    <div class="workout-grid">

        <%
            List<Workout> workouts =
                (List<Workout>) request.getAttribute("recommendedWorkouts");

            if (workouts != null && !workouts.isEmpty()) {

                for (Workout workout : workouts) {
        %>

        <div class="workout-card">

            <h2>
                <%= workout.getExerciseName() %>
            </h2>

            <span class="category">
                <%= workout.getCategory() %>
            </span>

            <span class="difficulty">
                <%= workout.getDifficulty() %>
            </span>


            <div class="details">

                <div class="detail-box">

                    <strong>Sets</strong>

                    <br>

                    <%= workout.getSets() %>

                </div>


                <div class="detail-box">

                    <strong>Reps</strong>

                    <br>

                    <%
                        if (workout.getRepetitions() == 0) {
                    %>

                        30-60 sec

                    <%
                        } else {
                    %>

                        <%= workout.getRepetitions() %>

                    <%
                        }
                    %>

                </div>

            </div>


            <h3>How to Perform</h3>

            <p class="instructions">
                <%= workout.getInstructions() %>
            </p>

        </div>

        <%
                }

            } else {
        %>

        <div class="no-workout">

            <h2>No Recommended Workouts Found</h2>

            <p>
                We couldn't find workouts for your current fitness goal.
            </p>

        </div>

        <%
            }
        %>

    </div>


    <a href="dashboard.jsp" class="back">
        ← Back to Dashboard
    </a>

</div>

</body>
</html>