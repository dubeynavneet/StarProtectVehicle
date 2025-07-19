package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.time.LocalDate;

public class AddUnderwriterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Get form inputs
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String password = request.getParameter("password");

            // Debug output (optional)
            out.println("<p>Received Name: " + name + "</p>");
            out.println("<p>Received DOB: " + dob + "</p>");
            out.println("<p>Received Password: " + password + "</p>");

            // Establish DB connection
            Connection conn = DBConnection.getConnection();

            // Insert statement
            String sql = "INSERT INTO Underwriter (name, dob, joiningDate, password) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setDate(2, Date.valueOf(dob)); // Ensure dob is in YYYY-MM-DD format
            ps.setDate(3, Date.valueOf(LocalDate.now()));
            ps.setString(4, password);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                out.println("<h3 style='color:green;'>Underwriter Registered Successfully</h3>");
            } else {
                out.println("<h3 style='color:red;'>Error in registration</h3>");
            }

            // Clean up
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace(); // Will appear in server console/log
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter o = response.getWriter();
            o.println("<h3 style='color:red;'>Server Error: " + e.getClass().getSimpleName() + " - " + e.getMessage() + "</h3>");
        }
    }
}


//package com.servlet;
//
//import com.db.DBConnection;
//import java.sql.*;
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.io.*;
//import java.time.LocalDate;
//
//public class AddUnderwriterServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//        String name = request.getParameter("name");
//        String dob = request.getParameter("dob");
//        String password = request.getParameter("password");
//        
//        try (Connection conn = DBConnection.getConnection()) {
//            String sql = "INSERT INTO Underwriter (name, dob, joiningDate, password) VALUES (?, ?, ?, ?)";
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, name);
//            ps.setDate(2, Date.valueOf(dob));
//            ps.setDate(3, Date.valueOf(LocalDate.now()));
//            ps.setString(4, password);
//
//            int rows = ps.executeUpdate();
//            if (rows > 0) {
//                response.getWriter().println("<h3>Underwriter Registered Successfully</h3>");
//            } else {
//                response.getWriter().println("<h3>Error in registration</h3>");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().println("<h3>Server Error</h3>");
//        }
//    }
//}