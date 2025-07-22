package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class CreatePolicyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Connection conn = null;
        PreparedStatement ps = null;
        // Use an absolute path for forwarding to ensure consistency
        String forwardPath = "/jsp/underwriter/createPolicy.jsp"; 

        try {
            // Get form inputs
            String vehicleNo = request.getParameter("vehicleNo");
            String vehicleType = request.getParameter("vehicleType");
            String customerName = request.getParameter("customerName");
            String engineNoParam = request.getParameter("engineNo");
            String chasisNoParam = request.getParameter("chasisNo");
            String phoneNo = request.getParameter("phoneNo");
            String type = request.getParameter("type");
            String vehicleValueParam = request.getParameter("vehicleValue");
            String fromDateParam = request.getParameter("fromDate");
            String underwriterIdParam = request.getParameter("underwriterId");

            // Server-side validation for all parameters
            if (vehicleNo == null || vehicleNo.trim().isEmpty() || vehicleNo.length() > 10 || !vehicleNo.matches("^[a-zA-Z0-9]{1,10}$")) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Vehicle Number.");
            } else if (vehicleType == null || (!"2-wheeler".equals(vehicleType) && !"4-wheeler".equals(vehicleType))) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Vehicle Type selected.");
            } else if (customerName == null || customerName.trim().isEmpty() || customerName.length() < 3 || !customerName.matches("^[a-zA-Z\\s]+$")) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Customer Name.");
            } else if (engineNoParam == null || engineNoParam.trim().isEmpty() || !engineNoParam.matches("\\d+") || Integer.parseInt(engineNoParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Engine Number.");
            } else if (chasisNoParam == null || chasisNoParam.trim().isEmpty() || !chasisNoParam.matches("\\d+") || Integer.parseInt(chasisNoParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Chassis Number.");
            } else if (phoneNo == null || !phoneNo.matches("^\\d{10}$")) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Phone Number (must be 10 digits).");
            } else if (type == null || (!"Full Insurance".equals(type) && !"Third Party".equals(type))) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Policy Type selected.");
            } else if (fromDateParam == null || fromDateParam.trim().isEmpty()) {
                 request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: From Date is required.");
            } else if (vehicleValueParam == null || vehicleValueParam.trim().isEmpty() || !vehicleValueParam.matches("\\d+(\\.\\d+)?") || Double.parseDouble(vehicleValueParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Vehicle Value.");
            } else if (underwriterIdParam == null || underwriterIdParam.trim().isEmpty() || !underwriterIdParam.matches("\\d+") || Integer.parseInt(underwriterIdParam) <= 0) {
                request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid Underwriter ID.");
            } else {
                // Parse values after all initial validations pass
                int engineNo = Integer.parseInt(engineNoParam);
                int chasisNo = Integer.parseInt(chasisNoParam);
                double vehicleValue = Double.parseDouble(vehicleValueParam);
                LocalDate fromDate = LocalDate.parse(fromDateParam);
                int underwriterId = Integer.parseInt(underwriterIdParam);
                LocalDate toDate = fromDate.plusDays(365); // Policy duration is 1 year

                // Validate FromDate not in the past (server-side check)
                if (fromDate.isBefore(LocalDate.now())) {
                    request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: From Date cannot be in the past.");
                } else {
                    double premium = 0;
                    if ("2-wheeler".equals(vehicleType)) {
                        premium = vehicleValue * 0.035;
                    } else if ("4-wheeler".equals(vehicleType)) {
                        premium = vehicleValue * 0.035;
                    }

                    // DB connection
                    conn = DBConnection.getConnection();

                    // Insert query
                    String sql = "INSERT INTO Policy (vehicleNo, vehicleType, customerName, engineNo, chasisNo, phoneNo, type, premiumAmt, fromDate, toDate, underwriterId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, vehicleNo);
                    ps.setString(2, vehicleType);
                    ps.setString(3, customerName);
                    ps.setInt(4, engineNo);
                    ps.setInt(5, chasisNo);
                    ps.setString(6, phoneNo);
                    ps.setString(7, type);
                    ps.setDouble(8, premium);
                    ps.setDate(9, Date.valueOf(fromDate));
                    ps.setDate(10, Date.valueOf(toDate));
                    ps.setInt(11, underwriterId);

                    int rows = ps.executeUpdate();
                    System.out.println("Policy creation - Vehicle No: " + vehicleNo + ", Rows affected: " + rows); // For server logs

                    if (rows > 0) {
                        request.setAttribute("successMessage", "Policy Created Successfully!");
                    } else {
                        request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: No rows were affected in the database.");
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Database error - " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Invalid number format for Engine No, Chassis No, Vehicle Value, or Underwriter ID.");
        } catch (Exception e) {
            e.printStackTrace(); // For server logs
            request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: An unexpected error occurred - " + e.getMessage());
        } finally {
            // Clean up resources in finally block
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace(); // Log resource closing errors
                String currentErrorMessage = (String) request.getAttribute("errorMessage");
                if (currentErrorMessage == null) {
                    request.setAttribute("errorMessage", "Failed to create policy. Please try again. Details: Error closing database resources - " + ex.getMessage());
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
