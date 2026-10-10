<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fitlife.model.DietPlan" %>
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

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FitLife - Diet Plans</title>


    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
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
            margin: 40px auto 60px;
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

        .filter-box {
            background: #1f2937;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        select {
            padding: 12px 18px;
            border-radius: 7px;
            border: 1px solid #374151;
            background: #111827;
            color: white;
            font-size: 15px;
        }

        .diet-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .diet-card {
            background: #1f2937;
            padding: 25px;
            border-radius: 12px;
            transition: 0.3s;
        }

        .diet-card:hover {
            transform: translateY(-5px);
        }

        .diet-card h2 {
            color: #22c55e;
            margin-bottom: 12px;
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: #374151;
            color: #22c55e;
            font-size: 13px;
            margin-right: 5px;
            margin-bottom: 12px;
        }

        .vegan {
            color: #84cc16;
        }

        .vegetarian {
            color: #facc15;
        }

        .meal {
            color: #d1d5db;
            margin: 10px 0;
        }

        .food {
            color: #e5e7eb;
            line-height: 1.6;
            margin-top: 10px;
        }

        .calories {
            margin-top: 18px;
            font-weight: bold;
            color: #22c55e;
        }

        .back {
            display: block;
            width: 200px;
            margin: 40px auto 0;
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

        .no-diet {
            text-align: center;
            background: #1f2937;
            padding: 30px;
            border-radius: 12px;
        }

        @media (max-width: 900px) {

            .diet-grid {
                grid-template-columns: repeat(2, 1fr);
            }

        }

        @media (max-width: 600px) {

            .diet-grid {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 15px;
            }

        }

    </style>

</head>

<body>

    <!-- Navigation -->

    <div class="navbar">

        <div class="logo">
            FitLife
        </div>

        <div>

            <a href="dashboard.jsp">Dashboard</a>

            <a href="DietPlanServlet">Refresh</a>

            <a href="LogoutServlet">Logout</a>

        </div>

    </div>


    <!-- Main Container -->

    <div class="container">

        <div class="heading">

            <h1>🥗 FitLife Diet Plans</h1>

            <p>
                Choose a diet according to your fitness goal and food preference.
            </p>

        </div>


        <!-- Filters -->

        <div class="filter-box">

            <select id="goalFilter" onchange="filterDiet()">

                <option value="all">All Goals</option>

                <option value="Weight Loss">Weight Loss</option>

                <option value="Muscle Building">Muscle Building</option>

                <option value="Weight Gain">Weight Gain</option>

                <option value="Fitness">Fitness</option>

            </select>


            <select id="dietFilter" onchange="filterDiet()">

                <option value="all">All Diet Types</option>

                <option value="Vegetarian">Vegetarian</option>

                <option value="Vegan">Vegan</option>

            </select>

        </div>


        <!-- Diet Plans -->

        <div class="diet-grid">

            <%

                List<DietPlan> dietPlans =
                    (List<DietPlan>) request.getAttribute("dietPlans");

                if (dietPlans != null && !dietPlans.isEmpty()) {

                    for (DietPlan diet : dietPlans) {

            %>

            <div class="diet-card"
                 data-goal="<%= diet.getGoal() %>"
                 data-diet="<%= diet.getDietType() %>">

                <h2>
                    <%= diet.getPlanName() %>
                </h2>

                <span class="badge">
                    <%= diet.getGoal() %>
                </span>

                <span class="badge
                    <%= diet.getDietType().equals("Vegan")
                        ? "vegan"
                        : "vegetarian" %>">

                    <%= diet.getDietType() %>

                </span>

                <p class="meal">
                    🍽️ Meal: <strong><%= diet.getMealType() %></strong>
                </p>

                <p class="food">
                    <strong>Food:</strong>
                    <%= diet.getFoodItems() %>
                </p>

                <p class="calories">
                    🔥 <%= diet.getCalories() %> Calories
                </p>

            </div>

            <%

                    }

                } else {

            %>

            <div class="no-diet">

                <h2>No Diet Plans Found</h2>

                <p>
                    No diet plans are currently available.
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


    <script>

        function filterDiet() {

            let goal =
                document.getElementById("goalFilter").value;

            let dietType =
                document.getElementById("dietFilter").value;

            let cards =
                document.querySelectorAll(".diet-card");

            cards.forEach(function(card) {

                let cardGoal =
                    card.getAttribute("data-goal");

                let cardDiet =
                    card.getAttribute("data-diet");

                let goalMatch =
                    goal === "all" || cardGoal === goal;

                let dietMatch =
                    dietType === "all" || cardDiet === dietType;

                if (goalMatch && dietMatch) {

                    card.style.display = "block";

                } else {

                    card.style.display = "none";

                }

            });

        }

    </script>
<script>
window.addEventListener("pageshow", function(event) {
    if (event.persisted) {
        window.location.reload();
    }
});
</script>
</body>

</html>