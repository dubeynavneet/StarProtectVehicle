package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UpdatePolicyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement psSelect = null;
        PreparedStatement psUpdate = null;
        String forwardPath = "/jsp/underwriter/updatePolicy.jsp"; // Always forward back to the JSP

        try {
            // Get form input
            String policyIdParam = request.getParameter("policyId");

            // Server-side validation for Policy ID
            if (policyIdParam == null || policyIdParam.trim().isEmpty() || !policyIdParam.matches("\\d+") || Integer.parseInt(policyIdParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Policy ID must be a positive number.");
            } else {
                int policyId = Integer.parseInt(policyIdParam); // Parse only after validation

                // DB connection
                conn = DBConnection.getConnection();

                // 1. Fetch current policy type
                String selectSql = "SELECT type FROM Policy WHERE policyId = ?";
                psSelect = conn.prepareStatement(selectSql);
                psSelect.setInt(1, policyId);
                ResultSet rs = psSelect.executeQuery();

                if (rs.next()) {
                    String currentType = rs.getString("type");

                    if ("Third Party".equalsIgnoreCase(currentType)) {
                        // Business logic: Cannot update from Third Party to Full Insurance
                        request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Policy is already 'Third Party' and cannot be updated to 'Full Insurance'.");
                    } else if ("Full Insurance".equalsIgnoreCase(currentType)) {
                        // Update policy type to "Third Party"
                        String updateSql = "UPDATE Policy SET type='Third Party' WHERE policyId=?";
                        psUpdate = conn.prepareStatement(updateSql);
                        psUpdate.setInt(1, policyId);

                        int rowsUpdated = psUpdate.executeUpdate();
                        System.out.println("Policy type update - Policy ID: " + policyId + ", Rows updated: " + rowsUpdated); // For server logs

                        if (rowsUpdated > 0) {
                            request.setAttribute("successMessage", "Policy ID " + policyId + " Updated Successfully to 'Third Party'!");
                        } else {
                            request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Update query affected no rows for Policy ID " + policyId + ".");
                        }
                    } else {
                         // Handle unexpected current policy types
                        request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Unexpected current policy type: " + currentType + " for Policy ID " + policyId + ".");
                    }
                } else {
                    // Policy not found in the database
                    request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Policy with ID " + policyId + " not found.");
                }
                if (rs != null) rs.close(); // Close ResultSet
            }

        } catch (SQLException e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Database error - " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Invalid number format for Policy ID.");
        } catch (Exception e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: An unexpected error occurred - " + e.getMessage());
        } finally {
            // Clean up resources in finally block
            try {
                if (psSelect != null) psSelect.close();
                if (psUpdate != null) psUpdate.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace(); // Log resource closing errors
                String currentErrorMessage = (String) request.getAttribute("errorMessage");
                if (currentErrorMessage == null) {
                    request.setAttribute("errorMessage", "Failed to update policy type. Please try again. Details: Error closing database resources - " + ex.getMessage());
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
