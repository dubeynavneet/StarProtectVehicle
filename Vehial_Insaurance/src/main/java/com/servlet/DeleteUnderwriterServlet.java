package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class DeleteUnderwriterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement deletePoliciesStmt = null;
        PreparedStatement deleteUnderwriterStmt = null;

        // Forward back to underwriter list page
        String forwardPath = "/viewUnderwriter.jsp";

        try {
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.trim().isEmpty() || !idParam.matches("\\d+") || Integer.parseInt(idParam) <= 0) {
                request.setAttribute("errorMessage", "Invalid Underwriter ID. Please try again.");
            } else {
                int id = Integer.parseInt(idParam);

                conn = DBConnection.getConnection();
                conn.setAutoCommit(false); // Transaction begins

                // Step 1: Delete associated policies (if such table exists)
                deletePoliciesStmt = conn.prepareStatement("DELETE FROM Policy WHERE underwriter_id = ?");
                deletePoliciesStmt.setInt(1, id);
                deletePoliciesStmt.executeUpdate();

                // Step 2: Delete the underwriter
                deleteUnderwriterStmt = conn.prepareStatement("DELETE FROM Underwriter WHERE id = ?");
                deleteUnderwriterStmt.setInt(1, id);
                int affectedRows = deleteUnderwriterStmt.executeUpdate();

                if (affectedRows > 0) {
                    conn.commit(); // Commit both deletions
                    request.setAttribute("successMessage", "Underwriter and related policies deleted successfully.");
                } else {
                    conn.rollback();
                    request.setAttribute("errorMessage", "Underwriter not found or could not be deleted.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // Rollback on error
            } catch (SQLException se) {
                se.printStackTrace();
            }
            request.setAttribute("errorMessage", "Database error. Please try again. Details: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unexpected error. Please try again. Details: " + e.getMessage());
        } finally {
            try {
                if (deletePoliciesStmt != null) deletePoliciesStmt.close();
                if (deleteUnderwriterStmt != null) deleteUnderwriterStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
                request.setAttribute("errorMessage", "Error closing database resources. Details: " + ex.getMessage());
            }

            // Forward back to viewUnderwriter.jsp with success or error messages
            RequestDispatcher rd = request.getRequestDispatcher(forwardPath);
            rd.forward(request, response);
        }
    }
}
