
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fitlife.model.DietPlan" %>
<%@ page import="java.net.URLEncoder" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String selectedGoal = request.getParameter("goal");
    String selectedDietType = request.getParameter("dietType");

    if (selectedGoal == null) selectedGoal = "";
    if (selectedDietType == null) selectedDietType = "";

    List<DietPlan> dietPlans =
        (List<DietPlan>) request.getAttribute("dietPlans");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>VegivaFit | Diet Plans</title>

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
    padding: 18px 5%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
}

.logo {
    font-size: 26px;
    font-weight: bold;
    color: #22c55e;
}

.navbar a {
    color: white;
    text-decoration: none;
    margin-left: 18px;
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
    margin-bottom: 30px;
}

.heading h1 {
    color: #22c55e;
    font-size: 36px;
    margin-bottom: 10px;
}

.heading p {
    color: #d1d5db;
    line-height: 1.6;
}

.filter-box {
    background: #1f2937;
    padding: 22px;
    border-radius: 12px;
    margin-bottom: 30px;
    display: flex;
    align-items: end;
    justify-content: center;
    gap: 15px;
    flex-wrap: wrap;
}

.filter-group {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.filter-group label {
    color: #d1d5db;
    font-size: 14px;
}

select {
    min-width: 190px;
    padding: 12px;
    border-radius: 7px;
    border: 1px solid #374151;
    background: #111827;
    color: white;
    font-size: 15px;
}

.btn {
    display: inline-block;
    padding: 12px 20px;
    border: none;
    border-radius: 7px;
    text-decoration: none;
    font-size: 15px;
    cursor: pointer;
    text-align: center;
}

.apply-btn {
    background: #22c55e;
    color: #111827;
    font-weight: bold;
}

.apply-btn:hover {
    background: #16a34a;
}

.reset-btn {
    background: #374151;
    color: white;
}

.reset-btn:hover {
    background: #4b5563;
}

.result-info {
    color: #d1d5db;
    margin-bottom: 20px;
    text-align: center;
}

.diet-grid {
    display: grid;
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 25px;
}

.diet-card {
    background: #1f2937;
    padding: 25px;
    border-radius: 12px;
    border: 1px solid #374151;
    transition: transform 0.2s;
    overflow-wrap: anywhere;
}

.diet-card:hover {
    transform: translateY(-4px);
}

.diet-card h2 {
    color: #22c55e;
    font-size: 22px;
    margin-bottom: 14px;
}

.badge {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    background: #374151;
    color: #22c55e;
    font-size: 13px;
    margin: 0 5px 12px 0;
}

.vegan {
    color: #a3e635;
}

.vegetarian {
    color: #facc15;
}

.meal {
    color: #d1d5db;
    margin: 10px 0;
    line-height: 1.6;
}

.food {
    color: #e5e7eb;
    line-height: 1.7;
    margin-top: 10px;
}

.calories {
    margin-top: 18px;
    font-weight: bold;
    color: #22c55e;
}

.no-diet {
    grid-column: 1 / -1;
    text-align: center;
    background: #1f2937;
    padding: 35px 20px;
    border-radius: 12px;
}

.no-diet h2 {
    color: #22c55e;
    margin-bottom: 12px;
}

.no-diet p {
    color: #d1d5db;
    line-height: 1.6;
}

.back {
    display: block;
    width: 220px;
    max-width: 100%;
    margin: 40px auto 0;
    background: #22c55e;
    color: #111827;
    padding: 12px;
    border-radius: 7px;
    text-align: center;
    text-decoration: none;
    font-weight: bold;
}

.back:hover {
    background: #16a34a;
}

@media (max-width: 900px) {
    .diet-grid {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

@media (max-width: 600px) {
    .diet-grid {
        grid-template-columns: 1fr;
    }

    .navbar {
        padding: 16px 5%;
    }

    .navbar a {
        margin-left: 0;
        margin-right: 14px;
    }

    .heading h1 {
        font-size: 29px;
    }

    .filter-box {
        align-items: stretch;
    }

    .filter-group,
    select,
    .filter-box .btn {
        width: 100%;
    }
}
</style>
</head>

<body>

<div class="navbar">
    <div class="logo">VegivaFit</div>

    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="DietPlanServlet">All Plans</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<div class="container">

    <div class="heading">
        <h1>🥗 VegivaFit Diet Plans</h1>
        <p>Choose a diet according to your fitness goal and food preference.</p>
    </div>

    <form class="filter-box" action="DietPlanServlet" method="get">

        <div class="filter-group">
            <label for="goal">Fitness Goal</label>
            <select id="goal" name="goal">
                <option value="" <%= selectedGoal.isEmpty() ? "selected" : "" %>>
                    All Goals
                </option>

                <option value="Weight Loss"
                    <%= "Weight Loss".equals(selectedGoal) ? "selected" : "" %>>
                    Weight Loss
                </option>

                <option value="Muscle Gain"
                    <%= "Muscle Gain".equals(selectedGoal) ? "selected" : "" %>>
                    Muscle Gain
                </option>

                <option value="Maintenance"
                    <%= "Maintenance".equals(selectedGoal) ? "selected" : "" %>>
                    Maintenance
                </option>

                <option value="General Fitness"
                    <%= "General Fitness".equals(selectedGoal) ? "selected" : "" %>>
                    General Fitness
                </option>
            </select>
        </div>

        <div class="filter-group">
            <label for="dietType">Diet Preference</label>
            <select id="dietType" name="dietType">
                <option value=""
                    <%= selectedDietType.isEmpty() ? "selected" : "" %>>
                    All Diet Types
                </option>

                <option value="Vegetarian"
                    <%= "Vegetarian".equals(selectedDietType) ? "selected" : "" %>>
                    Vegetarian
                </option>

                <option value="Vegan"
                    <%= "Vegan".equals(selectedDietType) ? "selected" : "" %>>
                    Vegan
                </option>
            </select>
        </div>

        <button type="submit" class="btn apply-btn">
            Apply Filter
        </button>

        <a href="DietPlanServlet" class="btn reset-btn">
            Reset
        </a>

    </form>

    <%
        if (dietPlans != null && !dietPlans.isEmpty()) {
    %>

    <p class="result-info">
        Showing <%= dietPlans.size() %> diet plan(s)
    </p>

    <div class="diet-grid">

        <%
            for (DietPlan diet : dietPlans) {
                String dietType = diet.getDietType() == null
                    ? "" : diet.getDietType();

                String badgeClass = "Vegan".equalsIgnoreCase(dietType)
                    ? "vegan" : "vegetarian";
        %>

        <div class="diet-card">

            <h2><%= diet.getPlanName() %></h2>

            <span class="badge">
                <%= diet.getGoal() %>
            </span>

            <span class="badge <%= badgeClass %>">
                <%= dietType %>
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
        %>

    </div>

    <%
        } else {
    %>

    <div class="no-diet">
        <h2>No Diet Plans Found</h2>
        <p>
            Is selection ke liye abhi koi plan available nahi hai.
            Dusra goal ya diet preference select karke dekho.
        </p>
    </div>

    <%
        }
    %>

    <a href="dashboard.jsp" class="back">
        ← Back to Dashboard
    </a>

</div>

<script>
window.addEventListener("pageshow", function(event) {
    if (event.persisted) {
        window.location.reload();
    }
});
</script>

</body>
</html>
