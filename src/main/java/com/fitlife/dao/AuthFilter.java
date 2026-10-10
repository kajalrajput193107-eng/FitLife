package com.fitlife.dao;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
    "/dashboard.jsp",
    "/WorkoutServlet",
    "/RecommendedWorkoutServlet",
    "/DietPlanServlet",
    "/workouts.jsp",
    "/recommended-workouts.jsp",
    "/diet-plans.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        // Prevent browser caching of protected pages
        httpResponse.setHeader(
                "Cache-Control",
                "no-cache, no-store, must-revalidate"
        );
        httpResponse.setHeader("Pragma", "no-cache");
        httpResponse.setDateHeader("Expires", 0);

        // Get existing session
        HttpSession session =
                httpRequest.getSession(false);

        // Check login
        if (session == null ||
            session.getAttribute("userId") == null) {

            httpResponse.sendRedirect("login.jsp");
            return;
        }

        // User is logged in
        chain.doFilter(request, response);
    }
}