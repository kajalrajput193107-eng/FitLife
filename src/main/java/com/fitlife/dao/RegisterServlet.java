package com.fitlife.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String goal = request.getParameter("goal");

        // Basic validation
        if (name == null || email == null || password == null ||
            age == null || gender == null || goal == null ||
            name.trim().isEmpty() || email.trim().isEmpty() ||
            password.isEmpty() || age.trim().isEmpty()) {

            response.getWriter().println("Please fill all required fields.");
            return;
        }

        String passwordPattern =
                "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%!])[A-Za-z\\d@#$%!]{8,}$";

        if (!password.matches(passwordPattern)) {

            response.getWriter().println(
                "Password must be at least 8 characters and contain "
                + "1 uppercase, 1 lowercase, 1 number and 1 special character."
            );

            return;
        }

        int userAge;

        try {
            userAge = Integer.parseInt(age);

            if (userAge < 13 || userAge > 100) {
                response.getWriter().println("Please enter a valid age.");
                return;
            }

        } catch (NumberFormatException e) {
            response.getWriter().println("Age must be a number.");
            return;
        }

        // Hash password before storing it
        String hashedPassword = PasswordUtil.hashPassword(password);

        String sql = "INSERT INTO users "
                   + "(name, email, password, age, gender, goal) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name.trim());
            ps.setString(2, email.trim());
            ps.setString(3, hashedPassword);
            ps.setInt(4, userAge);
            ps.setString(5, gender);
            ps.setString(6, goal);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.getWriter().println(
                    "Registration failed. Please try again."
                );
            }

            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Registration Failed: " + e.getMessage()
            );
        }
    }
}