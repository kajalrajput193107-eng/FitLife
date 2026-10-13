
package com.fitlife.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fitlife.model.DietPlan;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DietPlanServlet")
public class DietPlanServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get selected filters
        String goal = request.getParameter("goal");
        String dietType = request.getParameter("dietType");

        List<DietPlan> dietPlans = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT * FROM diet_plans WHERE 1=1"
        );

        List<String> params = new ArrayList<>();

        // Filter by fitness goal
        if (goal != null && !goal.trim().isEmpty()) {
            sql.append(" AND goal = ?");
            params.add(goal.trim());
        }

        // Filter by diet type
        if (dietType != null && !dietType.trim().isEmpty()) {
            sql.append(" AND diet_type = ?");
            params.add(dietType.trim());
        }

        sql.append(" ORDER BY id");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps =
                 con.prepareStatement(sql.toString())) {

            // Set query parameters safely
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    DietPlan dietPlan = new DietPlan(
                        rs.getInt("id"),
                        rs.getString("plan_name"),
                        rs.getString("goal"),
                        rs.getString("meal_type"),
                        rs.getString("food_items"),
                        rs.getInt("calories"),
                        rs.getString("diet_type")
                    );

                    dietPlans.add(dietPlan);
                }
            }

            request.setAttribute("dietPlans", dietPlans);
            request.setAttribute("selectedGoal", goal);
            request.setAttribute("selectedDietType", dietType);

            request.getRequestDispatcher("diet-plans.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to load diet plans. Please try again."
            );
        }
    }
}
