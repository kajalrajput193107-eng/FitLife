package com.fitlife.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null
                || email.trim().isEmpty() || password.isEmpty()) {

            response.getWriter().println(
                "Please enter email and password."
            );
            return;
        }

        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email.trim());

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String storedPassword = rs.getString("password");

                    boolean passwordCorrect =
                        PasswordUtil.verifyPassword(
                            password,
                            storedPassword
                        );

                    // Temporary debugging; never log passwords or hashes.
                    System.out.println(
                        "LOGIN DEBUG: emailFound=true, passwordCorrect="
                        + passwordCorrect
                    );

                    if (passwordCorrect) {

                        HttpSession session = request.getSession(true);

                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute("userName", rs.getString("name"));
                        session.setAttribute("userGoal", rs.getString("goal"));

                        response.sendRedirect("dashboard.jsp");

                    } else {

                        response.getWriter().println(
                            "Invalid Email or Password!"
                        );
                    }

                } else {

                    System.out.println("LOGIN DEBUG: emailFound=false");

                    response.getWriter().println(
                        "Invalid Email or Password!"
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println(
                "Login Failed: " + e.getMessage()
            );
        }
    }
}