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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<DietPlan> dietPlans = new ArrayList<>();

        String sql = "SELECT * FROM diet_plans";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

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

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("dietPlans", dietPlans);

            request.getRequestDispatcher("diet-plans.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Error loading diet plans: " + e.getMessage()
            );
        }
    }
}