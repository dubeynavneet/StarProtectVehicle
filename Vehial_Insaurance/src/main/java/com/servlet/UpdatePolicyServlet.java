package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UpdatePolicyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int policyId = Integer.parseInt(request.getParameter("policyId"));

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT type FROM Policy WHERE policyid=?");
            ps.setInt(1, policyId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String currentType = rs.getString("type");
                if ("Third Party".equalsIgnoreCase(currentType)) {
                    response.getWriter().println("<h3>Cannot update from Third Party to Full Insurance</h3>");
                } else {
                    PreparedStatement upd = conn.prepareStatement("UPDATE Policy SET type='Third Party' WHERE policyid=?");
                    upd.setInt(1, policyId);
                    int updated = upd.executeUpdate();
                    response.getWriter().println(updated > 0 ? "<h3>Policy Updated Successfully</h3>" : "<h3>Update Failed</h3>");
                }
            } else {
                response.getWriter().println("<h3>No such policy found</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error updating policy type</h3>");
        }
    }
}