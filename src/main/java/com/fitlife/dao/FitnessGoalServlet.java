
package com.fitlife.dao;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FitnessGoalServlet")
public class FitnessGoalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String sql = "SELECT current_weight, target_weight, deadline " +
                     "FROM fitness_goals WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    request.setAttribute("currentWeight",
                        rs.getBigDecimal("current_weight"));
                    request.setAttribute("targetWeight",
                        rs.getBigDecimal("target_weight"));
                    request.setAttribute("deadline",
                        rs.getDate("deadline"));
                }
            }

            request.getRequestDispatcher("/fitness-goals.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load fitness goals.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try {
            BigDecimal currentWeight =
                new BigDecimal(request.getParameter("currentWeight"));
            BigDecimal targetWeight =
                new BigDecimal(request.getParameter("targetWeight"));
            Date deadline =
                Date.valueOf(request.getParameter("deadline"));

            if (currentWeight.compareTo(BigDecimal.ZERO) <= 0
                    || targetWeight.compareTo(BigDecimal.ZERO) <= 0
                    || currentWeight.compareTo(new BigDecimal("500")) > 0
                    || targetWeight.compareTo(new BigDecimal("500")) > 0) {
                response.sendError(400,
                    "Weight must be between 0 and 500 kg.");
                return;
            }

            if (deadline.before(new Date(System.currentTimeMillis()))) {
                response.sendError(400,
                    "Deadline cannot be in the past.");
                return;
            }

            String sql =
                "INSERT INTO fitness_goals " +
                "(user_id, current_weight, target_weight, deadline) " +
                "VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE " +
                "current_weight = VALUES(current_weight), " +
                "target_weight = VALUES(target_weight), " +
                "deadline = VALUES(deadline)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, userId);
                ps.setBigDecimal(2, currentWeight);
                ps.setBigDecimal(3, targetWeight);
                ps.setDate(4, deadline);

                ps.executeUpdate();
            }

            response.sendRedirect(
                request.getContextPath()
                + "/FitnessGoalServlet?saved=1");

        } catch (IllegalArgumentException e) {
            response.sendError(400,
                "Please enter valid weights and deadline.");
        } catch (SQLException e) {
            throw new ServletException(
                "Unable to save fitness goal.", e);
        }
    }
}
