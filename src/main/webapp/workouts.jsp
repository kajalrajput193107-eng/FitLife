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
    <title>FitLife - Workouts</title>

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

        h1 {
            text-align: center;
            color: #22c55e;
            font-size: 36px;
        }

        .subtitle {
            text-align: center;
            color: #d1d5db;
            margin-bottom: 30px;
        }

        /* Search and Filter */

        .filters {
            background: #1f2937;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
        }

        .filters input,
        .filters select {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 7px;
            font-size: 15px;
        }

        /* Workout Cards */

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

        .category {
            display: inline-block;
            background: #374151;
            color: #22c55e;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-bottom: 15px;
        }

        .details {
            display: flex;
            gap: 10px;
            margin: 15px 0;
        }

        .detail-box {
            background: #111827;
            padding: 10px 15px;
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

        .no-result {
            text-align: center;
            color: #f87171;
            font-size: 18px;
            display: none;
            margin-top: 30px;
        }

        .back {
            display: block;
            width: 180px;
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

            .filters {
                flex-direction: column;
            }

            .navbar {
                padding: 15px;
            }

        }

    </style>

</head>

<body>

<!-- Navbar -->

<div class="navbar">

    <div class="logo">FitLife</div>

    <div>
        <a href="index.jsp">Home</a>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="LogoutServlet">Logout</a>
    </div>

</div>


<div class="container">

    <h1>🏋️ Workout Plans</h1>

    <p class="subtitle">
        Explore workouts and build your perfect fitness routine.
    </p>


    <!-- Search and Category Filter -->

    <div class="filters">

        <input
            type="text"
            id="searchInput"
            placeholder="🔍 Search exercise..."
            onkeyup="filterWorkouts()"
        >

        <select id="categoryFilter" onchange="filterWorkouts()">

            <option value="all">All Categories</option>
            <option value="Strength">Strength</option>
            <option value="Chest">Chest</option>
            <option value="Legs">Legs</option>
            <option value="Core">Core</option>
            <option value="Cardio">Cardio</option>
            <option value="Glutes">Glutes</option>
            <option value="Back">Back</option>
            <option value="Shoulders">Shoulders</option>
            <option value="Arms">Arms</option>

        </select>

    </div>


    <!-- Workout Cards -->

    <div class="workout-grid" id="workoutGrid">

        <%
            List<Workout> workouts =
                (List<Workout>) request.getAttribute("workouts");

            if (workouts != null && !workouts.isEmpty()) {

                for (Workout workout : workouts) {
        %>


        <div class="workout-card"
             data-name="<%= workout.getExerciseName().toLowerCase() %>"
             data-category="<%= workout.getCategory() %>">

            <h2>
                <%= workout.getExerciseName() %>
            </h2>

            <span class="category">
                <%= workout.getCategory() %>
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

        <p>No workouts available.</p>

        <%
            }
        %>

    </div>


    <div class="no-result" id="noResult">

        No workout found. Try another search or category.

    </div>


    <a class="back" href="dashboard.jsp">
        ← Back to Dashboard
    </a>

</div>


<script>

function filterWorkouts() {

    let search =
        document.getElementById("searchInput").value.toLowerCase();

    let category =
        document.getElementById("categoryFilter").value;

    let cards =
        document.getElementsByClassName("workout-card");

    let found = 0;

    for (let i = 0; i < cards.length; i++) {

        let name =
            cards[i].getAttribute("data-name");

        let cardCategory =
            cards[i].getAttribute("data-category");

        let searchMatch =
            name.includes(search);

        let categoryMatch =
            category === "all" ||
            cardCategory === category;

        if (searchMatch && categoryMatch) {

            cards[i].style.display = "block";
            found++;

        } else {

            cards[i].style.display = "none";

        }

    }

    let noResult =
        document.getElementById("noResult");

    if (found === 0) {
        noResult.style.display = "block";
    } else {
        noResult.style.display = "none";
    }

}

</script>

</body>
</html>