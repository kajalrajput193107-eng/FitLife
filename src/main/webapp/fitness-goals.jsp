
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.math.BigDecimal,java.time.LocalDate,java.sql.Date" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    BigDecimal currentWeight = (BigDecimal) request.getAttribute("currentWeight");
    BigDecimal targetWeight = (BigDecimal) request.getAttribute("targetWeight");
    Date savedDeadline = (Date) request.getAttribute("deadline");

    String currentValue = currentWeight == null ? "" : currentWeight.toPlainString();
    String targetValue = targetWeight == null ? "" : targetWeight.toPlainString();
    String deadlineValue = savedDeadline == null ? "" : savedDeadline.toString();

    boolean saved = "1".equals(request.getParameter("saved"));
    boolean hasGoal = currentWeight != null && targetWeight != null;
    int progress = 0;

    if (hasGoal) {
        double start = currentWeight.doubleValue();
        double target = targetWeight.doubleValue();

        if (start == target) {
            progress = 100;
        } else if (start > target) {
            progress = (int) Math.round(
                Math.max(0, Math.min(100, (start - target) / start * 100)));
        } else {
            progress = (int) Math.round(
                Math.max(0, Math.min(100, (target - start) / start * 100)));
        }
    }

    boolean completed = hasGoal && currentWeight.compareTo(targetWeight) == 0;
    String today = LocalDate.now().toString();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fitness Goals | VegivaFit</title>
<style>
*{box-sizing:border-box}
body{margin:0;font-family:Arial,sans-serif;background:#101410;color:#f4f7f4}
nav{background:#171d18;padding:18px 7%;display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #303a30}
.logo{font-size:25px;font-weight:bold;color:#6ee787}
nav a{color:#eee;text-decoration:none}
.container{max-width:850px;margin:35px auto;padding:0 18px}
.card{background:#1a211b;border:1px solid #303b31;border-radius:16px;padding:28px;margin-bottom:22px}
h1{margin-top:0;font-size:29px}
h2{font-size:20px}
p{color:#b7c3b8;line-height:1.6}
label{display:block;margin:16px 0 7px;color:#e6eee7;font-weight:bold}
input{width:100%;padding:12px;border:1px solid #465448;border-radius:8px;background:#101610;color:white;font-size:16px}
button,.btn{display:inline-block;margin-top:22px;background:#6ee787;color:#102014;padding:12px 20px;border:0;border-radius:8px;font-weight:bold;text-decoration:none;cursor:pointer}
.secondary{background:#303b31;color:white;margin-left:8px}
.progress-track{height:14px;background:#303b31;border-radius:10px;overflow:hidden;margin:18px 0}
.progress-fill{height:100%;background:#6ee787;border-radius:10px}
.stats{display:flex;justify-content:space-between;gap:14px;flex-wrap:wrap}
.stat{flex:1;min-width:130px;background:#111711;padding:16px;border-radius:10px}
.stat strong{display:block;font-size:22px;color:#6ee787;margin-top:8px;overflow-wrap:anywhere}
.notice{padding:12px;border-radius:8px;background:#183c24;color:#a9f5b8;margin-bottom:18px}
@media(max-width:500px){.card{padding:20px}.stats{flex-direction:column}nav{padding:16px 5%}}
</style>
</head>
<body>
<nav>
    <div class="logo">VegivaFit</div>
    <a href="<%= request.getContextPath() %>/dashboard.jsp">← Dashboard</a>
</nav>

<div class="container">
    <div class="card">
        <h1>🎯 My Fitness Goals</h1>
        <p>Set your weight target and deadline. Track your journey one step at a time.</p>

        <% if (saved) { %>
            <div class="notice">Your fitness goal has been saved successfully!</div>
        <% } %>

        <form action="<%= request.getContextPath() %>/FitnessGoalServlet" method="post">
            <label for="currentWeight">Current Weight (kg)</label>
            <input type="number" id="currentWeight" name="currentWeight"
                   min="0.1" max="500" step="0.1" required
                   value="<%= currentValue %>" placeholder="e.g. 65.5">

            <label for="targetWeight">Target Weight (kg)</label>
            <input type="number" id="targetWeight" name="targetWeight"
                   min="0.1" max="500" step="0.1" required
                   value="<%= targetValue %>" placeholder="e.g. 60">

            <label for="deadline">Goal Deadline</label>
            <input type="date" id="deadline" name="deadline"
                   min="<%= today %>" required value="<%= deadlineValue %>">

            <button type="submit">Save Fitness Goal</button>
            <a class="btn secondary" href="<%= request.getContextPath() %>/dashboard.jsp">Cancel</a>
        </form>
    </div>

    <% if (hasGoal) { %>
    <div class="card">
        <h2>Your Progress</h2>

        <% if (completed) { %>
            <div class="notice">🏆 Congratulations! Your current weight matches your target weight.</div>
        <% } else { %>
            <p>Keep going! Consistency is the key to progress.</p>
        <% } %>

        <div class="stats">
            <div class="stat">Current Weight<strong><%= currentValue %> kg</strong></div>
            <div class="stat">Target Weight<strong><%= targetValue %> kg</strong></div>
            <div class="stat">Deadline<strong><%= deadlineValue %></strong></div>
        </div>

        <p>Goal progress estimate: <strong><%= progress %>%</strong></p>
        <div class="progress-track">
            <div class="progress-fill" style="width:<%= progress %>%"></div>
        </div>
        <p>Progress is an estimate based on the difference between your current and target weights, not a measurement of actual health improvement.</p>
    </div>
    <% } %>
</div>
</body>
</html>
