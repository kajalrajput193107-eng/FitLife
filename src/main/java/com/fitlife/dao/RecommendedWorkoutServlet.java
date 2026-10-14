
package com.fitlife.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.fitlife.model.Workout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RecommendedWorkoutServlet")
public class RecommendedWorkoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userGoal") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String userGoal = String.valueOf(
                session.getAttribute("userGoal")).trim();

        // Map profile goals to workout database goals
        String workoutGoal;

        switch (userGoal) {
            case "Weight Loss":
                workoutGoal = "Weight Loss";
                break;

            case "Weight Gain":
                workoutGoal = "Muscle Gain";
                break;

            case "Muscle Building":
                workoutGoal = "Muscle Gain";
                break;

            case "Fitness":
            case "General Fitness":
                workoutGoal = "General Fitness";
                break;

            default:
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid fitness goal.");
                return;
        }

        List<Workout> workouts = new ArrayList<>();

        String sql = "SELECT * FROM workouts WHERE goal = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, workoutGoal);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Workout workout = new Workout(
                        rs.getInt("id"),
                        rs.getString("exercise_name"),
                        rs.getString("category"),
                        rs.getInt("sets"),
                        rs.getInt("repetitions"),
                        rs.getString("instructions"),
                        rs.getString("difficulty"),
                        rs.getString("goal")
                    );

                    workouts.add(workout);
                }
            }

            request.setAttribute("recommendedWorkouts", workouts);

            request.getRequestDispatcher(
                    "/recommended-workouts.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException(
                    "Unable to load recommended workouts.", e);
        }
    }
}
