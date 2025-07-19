package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("userid");
        String pwd = request.getParameter("password");

        if ("admin".equals(id) && "admin123".equals(pwd)) {
            RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/adminHome.jsp");
            rd.forward(request, response);
        } else {
            response.getWriter().println("<h3 class='error'>Invalid Admin Credentials</h3>");
        }
    }
}