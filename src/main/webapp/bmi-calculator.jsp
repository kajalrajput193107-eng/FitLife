
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VegivaFit - BMI Calculator</title>
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
            font-size: 25px;
            font-weight: bold;
            color: #22c55e;
        }

        a { text-decoration: none; }

        .back {
            color: white;
            background: #374151;
            padding: 10px 16px;
            border-radius: 6px;
        }

        .container {
            width: 90%;
            max-width: 600px;
            margin: 45px auto;
            padding: 30px;
            background: #1f2937;
            border-radius: 14px;
        }

        h1 { text-align: center; margin-top: 0; }
        .subtitle { text-align: center; color: #d1d5db; }

        label {
            display: block;
            margin: 20px 0 8px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 13px;
            border: 1px solid #4b5563;
            border-radius: 7px;
            background: #111827;
            color: white;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 13px;
            margin-top: 24px;
            background: #22c55e;
            color: #052e16;
            border: 0;
            border-radius: 7px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover { background: #16a34a; }

        .result {
            display: none;
            margin-top: 25px;
            padding: 20px;
            border-radius: 9px;
            background: #111827;
            text-align: center;
        }

        .result h2 { color: #22c55e; }
        .bmi-number { font-size: 36px; font-weight: bold; }
        .message { color: #d1d5db; line-height: 1.6; }

        footer {
            text-align: center;
            padding: 20px;
            color: #9ca3af;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo">VegivaFit</div>
        <a class="back" href="dashboard.jsp">← Dashboard</a>
    </nav>

    <main class="container">
        <h1>BMI Calculator ⚖️</h1>
        <p class="subtitle">Calculate your Body Mass Index</p>

        <form id="bmiForm">
            <label for="height">Height (cm)</label>
            <input id="height" type="number" min="50" max="250"
                   step="0.1" placeholder="e.g. 165" required>

            <label for="weight">Weight (kg)</label>
            <input id="weight" type="number" min="10" max="500"
                   step="0.1" placeholder="e.g. 60" required>

            <button type="submit">Calculate BMI</button>
        </form>

        <section class="result" id="result" aria-live="polite">
            <h2>Your BMI Result</h2>
            <div class="bmi-number" id="bmiNumber"></div>
            <h3 id="category"></h3>
            <p class="message" id="message"></p>
        </section>
    </main>

    <footer>© 2026 VegivaFit | Stay Healthy • Stay Strong</footer>

    <script>
        document.getElementById("bmiForm").addEventListener("submit", function(e) {
            e.preventDefault();

            const height = Number(document.getElementById("height").value);
            const weight = Number(document.getElementById("weight").value);

            if (!Number.isFinite(height) || !Number.isFinite(weight) ||
                height < 50 || height > 250 || weight < 10 || weight > 500) {
                alert("Please enter a valid height and weight.");
                return;
            }

            const heightM = height / 100;
            const bmi = weight / (heightM * heightM);

            let category;
            if (bmi < 18.5) {
                category = "Underweight";
            } else if (bmi < 25) {
                category = "Healthy weight range";
            } else if (bmi < 30) {
                category = "Overweight";
            } else {
                category = "Obesity range";
            }

            document.getElementById("bmiNumber").textContent = bmi.toFixed(1);
            document.getElementById("category").textContent = category;
            document.getElementById("message").textContent =
                "BMI is a screening measure, not a diagnosis. Interpretation can vary with age, pregnancy and other factors.";

            document.getElementById("result").style.display = "block";
        });
    </script>
</body>
</html>
