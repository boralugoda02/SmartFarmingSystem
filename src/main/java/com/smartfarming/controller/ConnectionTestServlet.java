package com.smartfarming.controller;

import com.smartfarming.util.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ConnectionTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


        Connection con = DBConnection.getConnection();

        if (con != null) {
            out.println("<h1 style='color:green; text-align:center;'>Database Connected Successfully! 🎉</h1>");
            try { con.close(); } catch (Exception e) { /* ignore */ }
        } else {
            out.println("<h1 style='color:red; text-align:center;'>Database Connection Failed! ❌</h1>");
        }
    }
}