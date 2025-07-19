package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UpdateUnderwriterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
        	System.out.println("id= "+id+" password= "+password);
            String sql = "UPDATE Underwriter SET password=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, password);
            ps.setInt(2, id);

            int rows = ps.executeUpdate();
            response.getWriter().println(rows > 0 ? "<h3>Password Updated Successfully</h3>" : "<h3>Underwriter Not Found</h3>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error updating password</h3>");
        }
    }
}