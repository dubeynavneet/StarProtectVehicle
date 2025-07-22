package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.time.LocalDate;

public class AddUnderwriterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            // Get form inputs
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String password = request.getParameter("password");

            // Basic validation (though client-side validation helps here too)
            if (name == null || name.trim().isEmpty() || dob == null || dob.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Failed to register underwriter. Please try again. Details: All fields are required.");
            } else {
                // DB connection
                conn = DBConnection.getConnection();

                // Insert query
                String sql = "INSERT INTO Underwriter (name, dob, joiningDate, password) VALUES (?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setDate(2, Date.valueOf(dob));
                ps.setDate(3, Date.valueOf(LocalDate.now()));
                ps.setString(4, password);

                int rows = ps.executeUpdate();
                System.out.println("Under add Writer"); // For server logs

                if (rows > 0) {
                    // Set success message in request scope
                    request.setAttribute("successMessage", "Underwriter Registered Successfully!");
                } else {
                    // This case is less common for inserts but handles 0 rows affected
                    request.setAttribute("errorMessage", "Failed to register underwriter. Please try again. Details: No rows were affected in the database.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // For server logs
            // Set SQL-specific error message with "Please try again"
            request.setAttribute("errorMessage", "Failed to register underwriter. Please try again. Details: Database error - " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace(); // For server logs
            // Set general exception error message with "Please try again"
            request.setAttribute("errorMessage", "Failed to register underwriter. Please try again. Details: An unexpected error occurred - " + e.getMessage());
        } finally {
            // Clean up resources in finally block
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace(); // Log resource closing errors
                // Append resource cleanup error to existing message, or set new one
                String currentErrorMessage = (String) request.getAttribute("errorMessage");
                if (currentErrorMessage == null) {
                    request.setAttribute("errorMessage", "Failed to register underwriter. Please try again. Details: Error closing database resources - " + ex.getMessage());
                } else {
                    request.setAttribute("errorMessage", currentErrorMessage + " (Resource cleanup error: " + ex.getMessage() + ")");
                }
            }
            // Always forward back to the JSP
            RequestDispatcher rd = request.getRequestDispatcher("jsp/admin/addUnderwriter.jsp");
            rd.forward(request, response);
        }
    }
}
