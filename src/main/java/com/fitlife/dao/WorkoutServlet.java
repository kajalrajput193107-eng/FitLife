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

@WebServlet("/WorkoutServlet")
public class WorkoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check whether user is logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Workout> workouts = new ArrayList<>();

        String sql = "SELECT * FROM workouts";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

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

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("workouts", workouts);

            request.getRequestDispatcher("workouts.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Error loading workouts: " + e.getMessage()
            );
        }
    }
}