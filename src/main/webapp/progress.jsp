
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,java.util.Map" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, Object>> records =
        (List<Map<String, Object>>) request.getAttribute("progressRecords");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>VegivaFit - Progress Tracker</title>
<style>
*{box-sizing:border-box}
body{margin:0;font-family:Arial,sans-serif;background:#111827;color:#fff}
nav{background:#1f2937;padding:18px 5%;display:flex;justify-content:space-between;align-items:center}
.logo{color:#22c55e;font-size:25px;font-weight:bold}
nav a{color:white;text-decoration:none;margin-left:16px}
.container{width:92%;max-width:1000px;margin:35px auto}
h1{text-align:center;color:#22c55e}
.subtitle{text-align:center;color:#d1d5db;margin-bottom:30px}
.card{background:#1f2937;padding:24px;border-radius:12px;margin-bottom:25px}
label{display:block;margin:14px 0 7px}
input,textarea{width:100%;padding:12px;border:0;border-radius:6px;font-size:15px}
button{margin-top:18px;background:#22c55e;color:#07120a;border:0;padding:12px 20px;border-radius:7px;font-weight:bold;cursor:pointer}
table{width:100%;border-collapse:collapse;margin-top:15px}
th,td{padding:12px;text-align:left;border-bottom:1px solid #374151}
th{color:#22c55e}
.empty{color:#d1d5db;text-align:center;padding:20px}
.table-wrap{overflow-x:auto}
@media(max-width:600px){nav{padding:15px;flex-wrap:wrap;gap:12px}nav a{margin-left:8px}.card{padding:16px}th,td{padding:8px;font-size:13px}}
</style>
</head>
<body>
<nav>
    <div class="logo">VegivaFit</div>
    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</nav>

<div class="container">
    <h1>My Progress Tracker</h1>
    <p class="subtitle">Record your measurements and follow your fitness journey.</p>

    <div class="card">
        <h2>Add Progress</h2>
        <form action="ProgressServlet" method="post">
            <label for="weight">Weight (kg) *</label>
            <input id="weight" type="number" name="weight"
                   min="0.1" max="500" step="0.01" required>

            <label for="height">Height (cm, optional)</label>
            <input id="height" type="number" name="height"
                   min="0.1" max="300" step="0.1">

            <label for="recorded_date">Date *</label>
            <input id="recorded_date" type="date" name="recorded_date"
                   value="<%= java.time.LocalDate.now() %>" required>

            <label for="notes">Notes (optional)</label>
            <textarea id="notes" name="notes" maxlength="500"
                      rows="3" placeholder="How are you feeling today?"></textarea>

            <button type="submit">Save Progress</button>
        </form>
    </div>

    <div class="card">
        <h2>Progress History</h2>
        <% if (records != null && !records.isEmpty()) { %>
        <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Weight (kg)</th>
                    <th>Height (cm)</th>
                    <th>Notes</th>
                </tr>
            </thead>
            <tbody>
            <% for (Map<String, Object> record : records) { %>
                <tr>
                    <td><%= record.get("date") %></td>
                    <td><%= record.get("weight") %></td>
                    <td><%= record.get("height") == null ? "-" : record.get("height") %></td>
                    <td><%= record.get("notes") == null ? "-" : record.get("notes") %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
        </div>
        <% } else { %>
            <p class="empty">No progress records yet. Add your first entry above!</p>
        <% } %>
    </div>
</div>
</body>
</html>
