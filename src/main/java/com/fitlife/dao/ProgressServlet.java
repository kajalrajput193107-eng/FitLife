
package com.fitlife.dao;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProgressServlet")
public class ProgressServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        List<Map<String, Object>> records = new ArrayList<>();

        String sql = "SELECT id, weight, height, recorded_date, notes " +
                     "FROM progress WHERE user_id = ? " +
                     "ORDER BY recorded_date DESC, id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("id", rs.getInt("id"));
                    row.put("weight", rs.getBigDecimal("weight"));
                    row.put("height", rs.getBigDecimal("height"));
                    row.put("date", rs.getDate("recorded_date"));
                    row.put("notes", rs.getString("notes"));
                    records.add(row);
                }
            }

            request.setAttribute("progressRecords", records);
            request.getRequestDispatcher("progress.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Unable to load progress records.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try {
            BigDecimal weight =
                new BigDecimal(request.getParameter("weight"));

            String heightInput = request.getParameter("height");
            BigDecimal height = (heightInput == null ||
                heightInput.trim().isEmpty())
                ? null : new BigDecimal(heightInput);

            String dateInput = request.getParameter("recorded_date");
            LocalDate date = (dateInput == null ||
                dateInput.trim().isEmpty())
                ? LocalDate.now() : LocalDate.parse(dateInput);

            String notes = request.getParameter("notes");

            if (weight.compareTo(BigDecimal.ZERO) <= 0 ||
                weight.compareTo(new BigDecimal("500")) > 0) {
                response.sendError(400, "Please enter a valid weight.");
                return;
            }

            if (height != null &&
                (height.compareTo(BigDecimal.ZERO) <= 0 ||
                 height.compareTo(new BigDecimal("300")) > 0)) {
                response.sendError(400, "Please enter a valid height.");
                return;
            }

            String sql = "INSERT INTO progress " +
                "(user_id, weight, height, recorded_date, notes) " +
                "VALUES (?, ?, ?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, userId);
                ps.setBigDecimal(2, weight);

                if (height == null) {
                    ps.setNull(3, java.sql.Types.DECIMAL);
                } else {
                    ps.setBigDecimal(3, height);
                }

                ps.setDate(4, Date.valueOf(date));
                ps.setString(5, notes);
                ps.executeUpdate();
            }

            response.sendRedirect(
                request.getContextPath() + "/ProgressServlet");

        } catch (NumberFormatException |
                 java.time.format.DateTimeParseException e) {
            response.sendError(400,
                "Please enter valid weight, height, and date.");
        } catch (Exception e) {
            throw new ServletException("Unable to save progress.", e);
        }
    }
}
