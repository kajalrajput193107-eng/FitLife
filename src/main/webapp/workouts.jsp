<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fitlife.model.Workout" %>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (session.getAttribute("userId") == null) { response.sendRedirect("login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>VegivaFit - Workouts</title>
<style>
*{box-sizing:border-box}
:root{--bg:#090d12;--surface:#121922;--green:#39f59a;--muted:#9aa8b7;--border:rgba(255,255,255,.08)}
body{margin:0;min-height:100vh;font-family:"Segoe UI",Arial,sans-serif;background:radial-gradient(ellipse at 50% 0%,rgba(28,83,57,.28),transparent 42%),var(--bg);color:#f4f7fb}
.navbar{position:sticky;top:0;z-index:10;background:rgba(10,15,21,.94);border-bottom:1px solid var(--border);backdrop-filter:blur(14px);padding:18px 5%;display:flex;justify-content:space-between;align-items:center;gap:20px;flex-wrap:wrap}
.logo{font-size:27px;font-weight:800;letter-spacing:-1px;color:var(--green)}
.nav-links{display:flex;align-items:center;gap:24px;flex-wrap:wrap}
.navbar a{color:var(--muted);text-decoration:none;font-size:14px;font-weight:650}.navbar a:hover{color:var(--green)}
.container{width:90%;max-width:1250px;margin:48px auto}.page-heading{text-align:center;margin-bottom:34px}
.eyebrow{display:inline-block;color:var(--green);background:rgba(57,245,154,.08);border:1px solid rgba(57,245,154,.18);border-radius:999px;padding:7px 13px;font-size:11px;font-weight:800;letter-spacing:1.8px;text-transform:uppercase;margin-bottom:12px}
h1{margin:0 0 12px;font-size:clamp(30px,4vw,46px);letter-spacing:-1.5px}.title-accent{color:var(--green)}
.subtitle{max-width:620px;margin:0 auto;color:var(--muted);font-size:15px;line-height:1.8}
.filters{background:linear-gradient(145deg,rgba(22,31,42,.96),rgba(16,22,30,.96));border:1px solid var(--border);padding:18px;border-radius:17px;margin-bottom:28px;display:flex;align-items:stretch;gap:14px;box-shadow:0 15px 40px rgba(0,0,0,.16)}
.search-wrap{flex:1 1 0;position:relative;min-width:0}.search-icon{position:absolute;left:15px;top:50%;transform:translateY(-50%);pointer-events:none;color:var(--muted);font-size:19px}
.filters input,.filters select{display:block;width:100%;min-width:0;height:50px;padding:14px 15px;background:#0b1118;color:#f4f7fb;border:1px solid #293440;border-radius:10px;font:inherit;font-size:14px;outline:none}
.filters input{padding-left:43px}.filters select{flex:1 1 0;cursor:pointer}
.filters input:focus,.filters select:focus{border-color:var(--green);box-shadow:0 0 0 3px rgba(57,245,154,.09)}.filters input::placeholder{color:#8492a1}.filters select option{background:#101820;color:#f4f7fb}
.results-line{color:var(--muted);font-size:13px;margin:0 0 16px 3px}.results-line strong{color:var(--green)}
.workout-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:22px}
.workout-card{position:relative;min-width:0;overflow:hidden;background:linear-gradient(145deg,#151e28,#10161e);border:1px solid var(--border);padding:25px;border-radius:18px;transition:transform .25s,border-color .25s,box-shadow .25s}
.workout-card:before{content:"";position:absolute;top:0;left:24px;right:24px;height:2px;background:linear-gradient(90deg,transparent,var(--green),transparent);opacity:0;transition:opacity .25s}
.workout-card:hover{transform:translateY(-5px);border-color:rgba(57,245,154,.38);box-shadow:0 18px 38px rgba(0,0,0,.26)}.workout-card:hover:before{opacity:1}
.card-topline{display:flex;justify-content:space-between;align-items:flex-start;gap:10px;margin-bottom:15px}
.workout-card h2{color:#f4f7fb;font-size:21px;line-height:1.35;margin:0;overflow-wrap:anywhere}
.exercise-toggle{flex:0 0 38px;width:38px;height:38px;display:grid;place-items:center;border-radius:12px;background:rgba(57,245,154,.09);border:1px solid rgba(57,245,154,.2);color:var(--green);font-size:19px;cursor:pointer}
.exercise-toggle:hover{background:rgba(57,245,154,.2)}.exercise-toggle:focus-visible{outline:2px solid var(--green);outline-offset:3px}
.badges{display:flex;flex-wrap:wrap;gap:7px;margin-bottom:16px}
.category{display:inline-flex;align-items:center;background:rgba(57,245,154,.08);border:1px solid rgba(57,245,154,.15);color:var(--green);padding:7px 10px;border-radius:8px;font-size:11px;font-weight:750;line-height:1.3;overflow-wrap:anywhere}
.category.neutral{background:rgba(154,168,183,.08);border-color:rgba(154,168,183,.13);color:#bac5d0}
.details{display:flex;gap:12px;margin:19px 0}.detail-box{background:#0b1118;border:1px solid var(--border);padding:14px 10px;border-radius:12px;flex:1;text-align:center;line-height:1.7;min-width:0}
.detail-box strong{display:block;color:var(--muted);font-size:11px;text-transform:uppercase;letter-spacing:1px;margin-bottom:4px}.detail-value{color:var(--green);font-size:20px;font-weight:800;overflow-wrap:anywhere}
.instructions-panel{border-top:1px solid var(--border);margin-top:20px;padding-top:17px}.instructions-panel[hidden]{display:none}
.workout-card h3{display:flex;align-items:center;gap:9px;font-size:14px;margin:0 0 8px;color:#f4f7fb}.workout-card h3:before{content:"";width:4px;height:16px;border-radius:4px;background:var(--green)}
.instructions{color:#aeb9c6;line-height:1.8;font-size:14px;margin:0;overflow-wrap:anywhere}
.no-result{text-align:center;color:#ffaaaa;font-size:15px;display:none;margin-top:24px;padding:28px 20px;background:var(--surface);border:1px solid var(--border);border-radius:14px}
.empty-state{grid-column:1/-1;text-align:center;color:var(--muted);background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:32px 20px}
.back{display:block;width:fit-content;margin:42px auto;text-align:center;background:var(--green);color:#07140d;padding:13px 23px;border-radius:10px;text-decoration:none;font-weight:800;font-size:14px}.back:hover{background:#16c878}
.footer-note{text-align:center;color:#718091;font-size:12px;padding:0 0 28px}
@media(max-width:950px){.workout-grid{grid-template-columns:repeat(2,minmax(0,1fr))}.navbar{padding:17px 4%}}
@media(max-width:620px){.workout-grid{grid-template-columns:1fr}.filters{flex-direction:column;padding:14px}.search-wrap,.filters select{flex:1 1 auto;width:100%}.navbar{justify-content:center;flex-direction:column;gap:14px}.nav-links{justify-content:center;gap:18px}.container{width:92%;margin:32px auto}.workout-card{padding:21px}.page-heading{margin-bottom:26px}}
</style>
</head>
<body>
<nav class="navbar"><div class="logo">VegivaFit</div><div class="nav-links"><a href="index.jsp">Home</a><a href="dashboard.jsp">Dashboard</a><a href="LogoutServlet">Logout</a></div></nav>
<main class="container">
<header class="page-heading"><span class="eyebrow">Train smarter · Get stronger</span><h1>Workout <span class="title-accent">Plans</span></h1><p class="subtitle">Explore exercises, find the right routine for your goals, and build consistency one workout at a time.</p></header>
<section class="filters" aria-label="Search and filter workouts">
<div class="search-wrap"><span class="search-icon" aria-hidden="true">⌕</span><input type="search" id="searchInput" placeholder="Search an exercise..." aria-label="Search exercise" oninput="filterWorkouts()"></div>
<select id="categoryFilter" aria-label="Filter by category" onchange="filterWorkouts()">
<option value="all">All Categories</option><option value="Strength">Strength</option><option value="Chest">Chest</option><option value="Legs">Legs</option><option value="Core">Core</option><option value="Cardio">Cardio</option><option value="Glutes">Glutes</option><option value="Back">Back</option><option value="Shoulders">Shoulders</option><option value="Arms">Arms</option>
</select></section>
<p class="results-line" id="resultsLine" aria-live="polite">Showing <strong id="visibleCount">0</strong> workouts</p>
<section class="workout-grid" id="workoutGrid">
<%
List<Workout> workouts = (List<Workout>) request.getAttribute("workouts");
if (workouts != null && !workouts.isEmpty()) {
    for (Workout workout : workouts) {
%>
<article class="workout-card" data-name="<%= workout.getExerciseName() == null ? "" : workout.getExerciseName().toLowerCase().replace("\"", "&quot;") %>" data-category="<%= workout.getCategory() == null ? "" : workout.getCategory().replace("\"", "&quot;") %>">
<div class="card-topline"><h2><%= workout.getExerciseName() %></h2><button type="button" class="exercise-toggle" aria-expanded="false" aria-label="Show exercise instructions" title="Show exercise instructions" onclick="toggleInstructions(this)">↗</button></div>
<div class="badges"><span class="category"><%= workout.getCategory() %></span><span class="category neutral">Difficulty: <%= workout.getDifficulty() %></span><span class="category neutral">Goal: <%= workout.getGoal() %></span></div>
<div class="details"><div class="detail-box"><strong>Sets</strong><span class="detail-value"><%= workout.getSets() %></span></div><div class="detail-box"><strong>Reps / Time</strong><span class="detail-value"><% if (workout.getRepetitions() == 0) { %>30–60 sec<% } else { %><%= workout.getRepetitions() %><% } %></span></div></div>
<div class="instructions-panel" hidden><h3>How to Perform</h3><p class="instructions"><%= workout.getInstructions() %></p></div>
</article>
<%
    }
} else {
%>
<p class="empty-state">No workouts available right now. Please check again later.</p>
<%
}
%>
</section>
<div class="no-result" id="noResult" role="status">No workouts found. Try another exercise name or category.</div>
<a class="back" href="dashboard.jsp">← Back to Dashboard</a><p class="footer-note">Stay consistent. Progress takes time.</p>
</main>
<script>
function filterWorkouts() {
    const search = document.getElementById("searchInput").value.trim().toLowerCase();
    const category = document.getElementById("categoryFilter").value;
    const cards = document.querySelectorAll(".workout-card");
    let found = 0;
    cards.forEach(function(card) {
        const name = (card.getAttribute("data-name") || "").toLowerCase();
        const cardCategory = card.getAttribute("data-category") || "";
        const visible = name.includes(search) && (category === "all" || cardCategory === category);
        card.style.display = visible ? "" : "none";
        if (visible) found++;
    });
    document.getElementById("visibleCount").textContent = found;
    document.getElementById("noResult").style.display = cards.length > 0 && found === 0 ? "block" : "none";
    document.getElementById("resultsLine").style.display = cards.length > 0 ? "block" : "none";
}
function toggleInstructions(button) {
    const panel = button.closest(".workout-card").querySelector(".instructions-panel");
    const expanded = button.getAttribute("aria-expanded") === "true";
    panel.hidden = expanded;
    button.setAttribute("aria-expanded", String(!expanded));
    button.textContent = expanded ? "↗" : "↙";
    button.setAttribute("aria-label", expanded ? "Show exercise instructions" : "Hide exercise instructions");
    button.setAttribute("title", expanded ? "Show exercise instructions" : "Hide exercise instructions");
}
document.addEventListener("DOMContentLoaded", filterWorkouts);
filterWorkouts();
</script>
</body>
</html>
