
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fitlife.model.Workout"%>
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
            margin-bottom: 30px;
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

        /* Search and filters */
        .filters {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr auto;
            gap: 12px;
            margin-bottom: 25px;
        }

        .filters input,
        .filters select {
            width: 100%;
            min-width: 0;
            padding: 13px;
            border: 1px solid #374151;
            border-radius: 8px;
            background: #1f2937;
            color: white;
            font-size: 15px;
            outline: none;
        }

        .filters input:focus,
        .filters select:focus {
            border-color: #22c55e;
        }

        .filters select option {
            background: #1f2937;
            color: white;
        }

        .clear-filters {
            padding: 12px 18px;
            border: none;
            border-radius: 8px;
            background: #22c55e;
            color: white;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .clear-filters:hover {
            background: #16a34a;
        }

        .result-count {
            color: #d1d5db;
            margin: 0 0 20px;
            font-size: 14px;
        }

        .workout-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 25px;
        }

        .workout-card {
            background: #1f2937;
            padding: 25px;
            border-radius: 12px;
            transition: transform 0.3s;
            min-width: 0;
        }

        .workout-card:hover {
            transform: translateY(-5px);
        }

        .workout-card h2 {
            color: #22c55e;
            margin-top: 0;
            overflow-wrap: anywhere;
        }

        .category,
        .difficulty {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-right: 5px;
            margin-bottom: 5px;
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
            overflow-wrap: anywhere;
        }

        .no-workout {
            text-align: center;
            background: #1f2937;
            padding: 30px;
            border-radius: 12px;
            grid-column: 1 / -1;
        }

        .no-workout h2 {
            color: #22c55e;
        }

        .back {
            display: block;
            width: 200px;
            max-width: 100%;
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
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .filters {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 600px) {
            .workout-grid {
                grid-template-columns: 1fr;
            }

            .navbar {
                padding: 15px;
                gap: 12px;
                flex-wrap: wrap;
            }

            .navbar a {
                margin-left: 10px;
            }

            .heading h1 {
                font-size: 28px;
            }

            .container {
                width: 92%;
                margin: 25px auto;
            }

            .filters {
                grid-template-columns: 1fr;
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
        <h1>&#127919; Recommended Workouts</h1>

        <p>
            Workouts selected according to your fitness goal:
            <span class="goal"><%= session.getAttribute("userGoal") %></span>
        </p>
    </div>

    <%
        List<Workout> workouts =
            (List<Workout>) request.getAttribute("recommendedWorkouts");
    %>

    <% if (workouts != null && !workouts.isEmpty()) { %>

        <div class="filters">
            <input
                type="search"
                id="workoutSearch"
                placeholder="Search exercises..."
                aria-label="Search exercises">

            <select id="categoryFilter" aria-label="Filter by category">
                <option value="">All Categories</option>
            </select>

            <select id="difficultyFilter" aria-label="Filter by difficulty">
                <option value="">All Difficulties</option>
            </select>

            <button type="button" class="clear-filters" id="clearFilters">
                Clear Filters
            </button>
        </div>

        <p class="result-count" id="resultCount" aria-live="polite"></p>

        <div class="workout-grid" id="workoutGrid">

            <% for (Workout workout : workouts) { %>

                <div class="workout-card"
                     data-name="<%= workout.getExerciseName() == null ? "" : workout.getExerciseName().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                     data-category="<%= workout.getCategory() == null ? "" : workout.getCategory().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                     data-difficulty="<%= workout.getDifficulty() == null ? "" : workout.getDifficulty().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>">

                    <h2><%= workout.getExerciseName() %></h2>

                    <span class="category"><%= workout.getCategory() %></span>
                    <span class="difficulty"><%= workout.getDifficulty() %></span>

                    <div class="details">
                        <div class="detail-box">
                            <strong>Sets</strong>
                            <br>
                            <%= workout.getSets() %>
                        </div>

                        <div class="detail-box">
                            <strong>Reps / Time</strong>
                            <br>
                            <% if (workout.getRepetitions() == 0) { %>
                                30-60 sec
                            <% } else { %>
                                <%= workout.getRepetitions() %>
                            <% } %>
                        </div>
                    </div>

                    <h3>How to Perform</h3>

                    <p class="instructions"><%= workout.getInstructions() %></p>

                </div>

            <% } %>

            <div class="no-workout" id="noResults" style="display:none;">
                <h2>No Matching Workouts Found</h2>
                <p>Try a different search term or clear your filters.</p>
            </div>

        </div>

    <% } else { %>

        <div class="no-workout">
            <h2>No Recommended Workouts Found</h2>
            <p>We couldn't find workouts for your current fitness goal.</p>
        </div>

    <% } %>

    <a href="dashboard.jsp" class="back">&larr; Back to Dashboard</a>

</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const search = document.getElementById("workoutSearch");
    const category = document.getElementById("categoryFilter");
    const difficulty = document.getElementById("difficultyFilter");
    const clear = document.getElementById("clearFilters");
    const grid = document.getElementById("workoutGrid");
    const count = document.getElementById("resultCount");
    const noResults = document.getElementById("noResults");

    if (!search || !category || !difficulty || !clear || !grid) {
        return;
    }

    const cards = Array.from(grid.querySelectorAll(".workout-card"));

    function populateFilter(select, attribute) {
        const values = [...new Set(
            cards.map(card => (card.dataset[attribute] || "").trim())
                .filter(Boolean)
        )].sort((a, b) => a.localeCompare(b));

        values.forEach(function (value) {
            const option = document.createElement("option");
            option.value = value.toLowerCase();
            option.textContent = value;
            select.appendChild(option);
        });
    }

    populateFilter(category, "category");
    populateFilter(difficulty, "difficulty");

    function filterWorkouts() {
        const query = search.value.trim().toLowerCase();
        let visible = 0;

        cards.forEach(function (card) {
            const name = (card.dataset.name || "").toLowerCase();
            const cat = (card.dataset.category || "").trim().toLowerCase();
            const level = (card.dataset.difficulty || "").trim().toLowerCase();

            const matches =
                name.includes(query) &&
                (!category.value || cat === category.value) &&
                (!difficulty.value || level === difficulty.value);

            card.style.display = matches ? "" : "none";

            if (matches) {
                visible++;
            }
        });

        count.textContent = "Showing " + visible + " of " + cards.length + " workouts";
        noResults.style.display = visible === 0 ? "block" : "none";
    }

    search.addEventListener("input", filterWorkouts);
    category.addEventListener("change", filterWorkouts);
    difficulty.addEventListener("change", filterWorkouts);

    clear.addEventListener("click", function () {
        search.value = "";
        category.value = "";
        difficulty.value = "";
        filterWorkouts();
        search.focus();
    });

    filterWorkouts();
});
</script>

</body>
</html>
