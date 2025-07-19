package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import java.time.LocalDate;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class RenewPolicyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int policyId = Integer.parseInt(request.getParameter("policyId"));
        double vehicleValue = Double.parseDouble(request.getParameter("vehicleValue"));
        String vehicleType = request.getParameter("vehicleType");

        try (Connection conn = DBConnection.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Policy WHERE policyid=" + policyId);

            if (rs.next()) {
                LocalDate current = LocalDate.now();
                LocalDate fromDate = current.isAfter(rs.getDate("toDate").toLocalDate()) ? current : rs.getDate("toDate").toLocalDate().plusDays(1);
                LocalDate toDate = fromDate.plusDays(365);

                double premium = "2-wheeler".equals(vehicleType) ? vehicleValue * 0.05 : vehicleValue * 0.05;
                premium -= premium * 0.05; // 5% discount

                PreparedStatement ps = conn.prepareStatement("INSERT INTO Policy (vehicleNo, vehicleType, customerName, engineNo, chasisNo, phoneNo, type, premiumAmt, fromDate, toDate, underwriterId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                for (int i = 1; i <= 11; i++) ps.setObject(i, rs.getObject(i));
                ps.setDouble(8, premium); // override premium
                ps.setDate(9, Date.valueOf(fromDate));
                ps.setDate(10, Date.valueOf(toDate));

                int inserted = ps.executeUpdate();
                response.getWriter().println(inserted > 0 ? "<h3>Policy Renewal is successful</h3>" : "<h3>Policy Renewal Failed</h3>");
            } else {
                response.getWriter().println("<h3>No such policy found</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error during renewal</h3>");
        }
    }
}