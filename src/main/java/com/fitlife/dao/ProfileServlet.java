
package com.fitlife.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String sql = "SELECT id, name, email, age, gender, goal, created_at "
                   + "FROM users WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    request.setAttribute("profileName", rs.getString("name"));
                    request.setAttribute("profileEmail", rs.getString("email"));
                    request.setAttribute("profileAge", rs.getInt("age"));
                    request.setAttribute("profileGender", rs.getString("gender"));
                    request.setAttribute("profileGoal", rs.getString("goal"));
                    request.setAttribute("profileCreated", rs.getTimestamp("created_at"));

                    request.getRequestDispatcher("/profile.jsp")
                           .forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND,
                                       "User profile not found.");
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Unable to load profile.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String name = request.getParameter("name");
        String ageText = request.getParameter("age");
        String gender = request.getParameter("gender");
        String goal = request.getParameter("goal");

        if (name == null || name.trim().isEmpty()
                || ageText == null || ageText.trim().isEmpty()
                || gender == null || goal == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                               "Please fill in all required fields.");
            return;
        }

        name = name.trim();

        if (name.length() > 100) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                               "Name must be at most 100 characters.");
            return;
        }

        int age;

        try {
            age = Integer.parseInt(ageText.trim());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                               "Please enter a valid age.");
            return;
        }

        if (age < 1 || age > 120) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                               "Age must be between 1 and 120.");
            return;
        }

        if (!gender.equals("Male")
                && !gender.equals("Female")
                && !gender.equals("Other")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                               "Invalid gender selection.");
            return;
        }

        if (!goal.equals("Weight Loss")
                && !goal.equals("Weight Gain")
                && !goal.equals("Muscle Building")
                && !goal.equals("General Fitness")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                               "Invalid fitness goal.");
            return;
        }

        String sql = "UPDATE users SET name = ?, age = ?, gender = ?, goal = ? "
                   + "WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setInt(2, age);
            ps.setString(3, gender);
            ps.setString(4, goal);
            ps.setInt(5, userId);

            int updated = ps.executeUpdate();

            if (updated == 1) {
                session.setAttribute("userName", name);
                session.setAttribute("userGoal", goal);

                response.sendRedirect(
                    request.getContextPath() + "/ProfileServlet?updated=1");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND,
                                   "User profile not found.");
            }

        } catch (SQLException e) {
            throw new ServletException("Unable to update profile.", e);
        }
    }
}
