
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String name = (String) request.getAttribute("profileName");
    String email = (String) request.getAttribute("profileEmail");
    Object age = request.getAttribute("profileAge");
    String gender = (String) request.getAttribute("profileGender");
    String goal = (String) request.getAttribute("profileGoal");
    Timestamp created = (Timestamp) request.getAttribute("profileCreated");

    if (name == null || email == null || age == null) {
        response.sendRedirect(request.getContextPath() + "/ProfileServlet");
        return;
    }

    String safeName = name.replace("&", "&amp;")
                          .replace("<", "&lt;")
                          .replace(">", "&gt;")
                          .replace("\"", "&quot;")
                          .replace("'", "&#39;");

    String safeEmail = email.replace("&", "&amp;")
                            .replace("<", "&lt;")
                            .replace(">", "&gt;")
                            .replace("\"", "&quot;")
                            .replace("'", "&#39;");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VegivaFit - My Profile</title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
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
        }

        .logo {
            color: #22c55e;
            font-size: 26px;
            font-weight: bold;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 18px;
        }

        .navbar a:hover { color: #22c55e; }

        .container {
            width: 92%;
            max-width: 650px;
            margin: 40px auto;
        }

        .profile-card {
            background: #1f2937;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        h1 {
            text-align: center;
            color: #22c55e;
            margin-top: 0;
        }

        .subtitle {
            text-align: center;
            color: #d1d5db;
            margin-bottom: 28px;
        }

        label {
            display: block;
            margin: 17px 0 8px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border-radius: 7px;
            border: 1px solid #374151;
            background: #111827;
            color: white;
            font-size: 15px;
        }

        input:focus, select:focus {
            outline: 2px solid #22c55e;
            border-color: #22c55e;
        }

        input[readonly] {
            color: #9ca3af;
            cursor: not-allowed;
        }

        .account-date {
            color: #9ca3af;
            font-size: 13px;
            margin-top: 20px;
        }

        .success {
            background: #064e3b;
            color: #a7f3d0;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 18px;
            text-align: center;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 25px;
        }

        .btn {
            flex: 1;
            text-align: center;
            padding: 12px;
            border: none;
            border-radius: 7px;
            text-decoration: none;
            cursor: pointer;
            font-size: 15px;
        }

        .save {
            background: #22c55e;
            color: white;
            font-weight: bold;
        }

        .save:hover { background: #16a34a; }

        .back {
            background: #374151;
            color: white;
        }

        .back:hover { background: #4b5563; }

        @media (max-width: 500px) {
            .profile-card { padding: 20px; }
            .navbar { padding: 15px; }
            .navbar a { margin-left: 8px; font-size: 14px; }
            .buttons { flex-direction: column; }
        }
    </style>
</head>

<body>
    <div class="navbar">
        <div class="logo">VegivaFit</div>
        <div>
            <a href="<%= request.getContextPath() %>/dashboard.jsp">Dashboard</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="profile-card">
            <h1>My Profile</h1>
            <p class="subtitle">View and update your personal details.</p>

            <% if ("1".equals(request.getParameter("updated"))) { %>
                <div class="success">Profile updated successfully!</div>
            <% } %>

            <form action="<%= request.getContextPath() %>/ProfileServlet"
                  method="post">

                <label for="name">Full Name</label>
                <input type="text" id="name" name="name"
                       value="<%= safeName %>" maxlength="100" required>

                <label for="email">Email Address</label>
                <input type="email" id="email" value="<%= safeEmail %>"
                       readonly aria-describedby="emailHelp">
                <small id="emailHelp" style="color:#9ca3af;">
                    Email cannot be changed here.
                </small>

                <label for="age">Age</label>
                <input type="number" id="age" name="age"
                       value="<%= age %>" min="1" max="120" required>

                <label for="gender">Gender</label>
                <select id="gender" name="gender" required>
                    <option value="Male" <%= "Male".equals(gender) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(gender) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(gender) ? "selected" : "" %>>Other</option>
                </select>

                <label for="goal">Fitness Goal</label>
                <select id="goal" name="goal" required>
                    
     <option value="Weight Loss" <%= "Weight Loss".equals(goal) ? "selected" : "" %>>Weight Loss</option>
     <option value="Weight Gain" <%= "Weight Gain".equals(goal) ? "selected" : "" %>>Weight Gain</option>
     <option value="General Fitness" <%= "General Fitness".equals(goal) ? "selected" : "" %>>General Fitness</option>
                    
                    <% if (goal != null &&
                           !goal.equals("Weight Loss") &&
                           !goal.equals("Weight Gain") &&
                           !goal.equals("Muscle Building") &&
                           !goal.equals("General Fitness")) { %>
                        <option value="<%= goal.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>" selected>
                            Existing goal: <%= goal.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;") %>
                        </option>
                    <% } %>
                </select>

                <% if (created != null) { %>
                    <p class="account-date">
                        Account created: <%= created %>
                    </p>
                <% } %>

                <div class="buttons">
                    <button type="submit" class="btn save">Save Changes</button>
                    <a class="btn back"
                       href="<%= request.getContextPath() %>/dashboard.jsp">
                       Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
