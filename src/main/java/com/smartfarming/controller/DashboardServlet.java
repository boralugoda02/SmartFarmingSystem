package com.smartfarming.controller;

import com.smartfarming.model.Alert;
import com.smartfarming.model.DashboardStats;
import com.smartfarming.model.User;
import com.smartfarming.service.DashboardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-dashboard")
public class DashboardServlet extends HttpServlet {
    private DashboardService dashboardService = new DashboardService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }


        User loggedUser = (User) session.getAttribute("loggedUser");
        if (!"Admin".equalsIgnoreCase(loggedUser.getRole())) {
            response.sendRedirect("error.jsp?error=Access Denied! Admins only.");
            return;
        }


        DashboardStats stats = dashboardService.getDashboardStatistics();
        List<Alert> recentAlerts = dashboardService.getRecentAlerts();


        request.setAttribute("stats", stats);
        request.setAttribute("recentAlerts", recentAlerts);


        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }
}