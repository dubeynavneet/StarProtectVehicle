package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class CreatePolicyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (Connection conn = DBConnection.getConnection()) {
            String vehicleNo = request.getParameter("vehicleNo");
            String vehicleType = request.getParameter("vehicleType");
            String customerName = request.getParameter("customerName");
            int engineNo = Integer.parseInt(request.getParameter("engineNo"));
            int chasisNo = Integer.parseInt(request.getParameter("chasisNo"));
            String phoneNo = request.getParameter("phoneNo");
            String type = request.getParameter("type");
            double vehicleValue = Double.parseDouble(request.getParameter("vehicleValue"));
            LocalDate fromDate = LocalDate.parse(request.getParameter("fromDate"));
            LocalDate toDate = fromDate.plusDays(365);
            int underwriterId = Integer.parseInt(request.getParameter("underwriterId"));

            double premium = 0;
            if ("2-wheeler".equals(vehicleType)) {
                premium = vehicleValue * 0.035;
            } else if ("4-wheeler".equals(vehicleType)) {
                premium = vehicleValue * 0.035;
            }

            String sql = "INSERT INTO Policy (vehicleNo, vehicleType, customerName, engineNo, chasisNo, phoneNo, type, premiumAmt, fromDate, toDate, underwriterId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
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
            response.getWriter().println(rows > 0 ? "<h3>Policy Created Successfully</h3>" : "<h3>Failed to create policy</h3>");
        } catch (Exception e) {
        	response.getWriter().println("Error");
            e.printStackTrace();
        }
    }
}