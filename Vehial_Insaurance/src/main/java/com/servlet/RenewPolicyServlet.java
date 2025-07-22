package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class RenewPolicyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement psSelect = null;
        PreparedStatement psInsert = null;
        // Use an absolute path for forwarding to ensure consistency
        String forwardPath = "/jsp/underwriter/renewPolicy.jsp";

        try {
            // Get form inputs
            String policyIdParam = request.getParameter("policyId");
            String vehicleValueParam = request.getParameter("vehicleValue");
            String vehicleType = request.getParameter("vehicleType");

            // Server-side validation for input parameters
            if (policyIdParam == null || policyIdParam.trim().isEmpty() || !policyIdParam.matches("\\d+") || Integer.parseInt(policyIdParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: Policy ID must be a positive number.");
            } else if (vehicleValueParam == null || vehicleValueParam.trim().isEmpty() || !vehicleValueParam.matches("\\d+(\\.\\d+)?") || Double.parseDouble(vehicleValueParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: New Vehicle Value must be a positive number.");
            } else if (vehicleType == null || (!"2-wheeler".equals(vehicleType) && !"4-wheeler".equals(vehicleType))) {
                request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: Invalid Vehicle Type selected.");
            } else {
                int policyId = Integer.parseInt(policyIdParam);
                double newVehicleValue = Double.parseDouble(vehicleValueParam);

                // DB connection
                conn = DBConnection.getConnection();

                // 1. Fetch existing policy details
                String selectSql = "SELECT * FROM Policy WHERE policyId = ?";
                psSelect = conn.prepareStatement(selectSql);
                psSelect.setInt(1, policyId);
                ResultSet rs = psSelect.executeQuery();

                if (rs.next()) {
                    // Policy found, proceed with renewal (creating a new policy record)
                    LocalDate current = LocalDate.now();
                    LocalDate oldToDate = rs.getDate("toDate").toLocalDate();
                    
                    // Determine new fromDate: either today, or the day after the old policy's end date
                    LocalDate newFromDate = current.isAfter(oldToDate) ? current : oldToDate.plusDays(1);
                    LocalDate newToDate = newFromDate.plusDays(365); // Renew for 1 year

                    // Calculate new premium based on new vehicle value and type
                    double newPremium = newVehicleValue * 0.05; // Base premium 5%
                    newPremium -= newPremium * 0.05; // 5% discount on renewal

                    // 2. Insert a new policy record with updated details
                    String insertSql = "INSERT INTO Policy (vehicleNo, vehicleType, customerName, engineNo, chasisNo, phoneNo, type, premiumAmt, fromDate, toDate, underwriterId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    psInsert = conn.prepareStatement(insertSql);

                    // Copy existing data and set new/updated values
                    psInsert.setString(1, rs.getString("vehicleNo"));
                    psInsert.setString(2, vehicleType); // Use new vehicleType from form
                    psInsert.setString(3, rs.getString("customerName"));
                    psInsert.setInt(4, rs.getInt("engineNo"));
                    psInsert.setInt(5, rs.getInt("chasisNo"));
                    psInsert.setString(6, rs.getString("phoneNo"));
                    psInsert.setString(7, rs.getString("type")); // Keep old policy type (Full/Third Party)
                    psInsert.setDouble(8, newPremium); // Use new calculated premium
                    psInsert.setDate(9, Date.valueOf(newFromDate)); // Use new fromDate
                    psInsert.setDate(10, Date.valueOf(newToDate)); // Use new toDate
                    psInsert.setInt(11, rs.getInt("underwriterId")); // Keep old underwriter ID

                    int rowsInserted = psInsert.executeUpdate();
                    System.out.println("Policy renewal - Policy ID: " + policyId + ", Rows inserted: " + rowsInserted); // For server logs

                    if (rowsInserted > 0) {
                        request.setAttribute("successMessage", "Policy ID " + policyId + " Renewed Successfully (New Policy Created)! From: " + newFromDate + " To: " + newToDate);
                    } else {
                        request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: Could not create new policy record for ID " + policyId + ".");
                    }
                } else {
                    // Policy not found in the database
                    request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: Policy with ID " + policyId + " not found.");
                }
                rs.close(); // Close ResultSet
            }

        } catch (SQLException e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: Database error - " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: Invalid number format for Policy ID or Vehicle Value.");
        } catch (Exception e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: An unexpected error occurred - " + e.getMessage());
        } finally {
            // Clean up resources in finally block
            try {
                if (psSelect != null) psSelect.close();
                if (psInsert != null) psInsert.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace(); // Log resource closing errors
                String currentErrorMessage = (String) request.getAttribute("errorMessage");
                if (currentErrorMessage == null) {
                    request.setAttribute("errorMessage", "Failed to renew policy. Please try again. Details: Error closing database resources - " + ex.getMessage());
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
