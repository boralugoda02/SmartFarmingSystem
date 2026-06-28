package com.smartfarming.controller;

import com.smartfarming.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin-dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("loggedUser");


        if (loggedUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }


        if (!"Admin".equalsIgnoreCase(loggedUser.getRole())) {
            response.setContentType("text/html");
            response.getWriter().println("<h3>Access Denied: Only Admins can access this panel.</h3>");
            return;
        }


        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}