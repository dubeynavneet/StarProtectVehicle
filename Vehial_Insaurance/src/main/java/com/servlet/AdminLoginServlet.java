package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("userid");
        String pwd = request.getParameter("password");

        if ("admin".equals(id) && "admin123".equals(pwd)) {
            // Successful login: Forward to admin home
            RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/adminHome.jsp");
            rd.forward(request, response);
        } else {
            // Failed login: Set an error message in the request scope
            request.setAttribute("errorMessage", "Invalid User ID or Password. Please try again.");

            // Forward back to the login page, maintaining the 'role' parameter
            // This ensures the form action remains correct for admin login
            RequestDispatcher rd = request.getRequestDispatcher("jsp/login.jsp?role=admin");
            rd.forward(request, response);
        }
    }
}
