package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UpdateUnderwriterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement ps = null;
        String forwardPath = "/jsp/admin/updateUnderwriter.jsp"; // Always forward back to the JSP

        try {
            // Get form inputs
            String idParam = request.getParameter("id");
            String password = request.getParameter("password");

            // Server-side validation for ID and Password
            if (idParam == null || idParam.trim().isEmpty() || !idParam.matches("\\d+") || Integer.parseInt(idParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to update password. Please try again. Details: Underwriter ID must be a positive number.");
                // No need to parse if validation fails
            } else if (password == null || password.length() < 8 || !password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+}{\"':;?/>.<,])(?=.*[^\\s]).{8,}$")) {
                request.setAttribute("errorMessage", "Failed to update password. Please try again. Details: Password must be at least 8 characters long and include uppercase, lowercase, number, and special character.");
            } else {
                int id = Integer.parseInt(idParam); // Parse only after validation

                // DB connection
                conn = DBConnection.getConnection();

                // Update query
                String sql = "UPDATE Underwriter SET password=? WHERE id=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, password);
                ps.setInt(2, id);

                int rows = ps.executeUpdate();
                System.out.println("id= " + id + " password= " + password + " rows updated=" + rows); // For server logs

                if (rows > 0) {
                    // Set success message in request scope
                    request.setAttribute("successMessage", "Underwriter Password Updated Successfully!");
                } else {
                    // Underwriter not found
                    request.setAttribute("errorMessage", "Failed to update password. Please try again. Details: Underwriter with ID " + id + " not found.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // For server logs
            // Set SQL-specific error message with "Please try again"
            request.setAttribute("errorMessage", "Failed to update password. Please try again. Details: Database error - " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to update password. Please try again. Details: Invalid Underwriter ID format.");
        } catch (Exception e) {
            e.printStackTrace(); // For server logs
            // Set general exception error message with "Please try again"
            request.setAttribute("errorMessage", "Failed to update password. Please try again. Details: An unexpected error occurred - " + e.getMessage());
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
                    request.setAttribute("errorMessage", "Failed to update password. Please try again. Details: Error closing database resources - " + ex.getMessage());
                } else {
                    request.setAttribute("errorMessage", currentErrorMessage + " (Resource cleanup error: " + ex.getMessage() + ")");
                }
            }
            // Always forward back to the JSP
            RequestDispatcher rd = request.getRequestDispatcher(forwardPath);
            rd.forward(request, response);
        }
    }
}
