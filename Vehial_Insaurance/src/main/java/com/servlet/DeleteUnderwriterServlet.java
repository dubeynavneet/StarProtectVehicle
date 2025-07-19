package com.servlet;

import com.db.DBConnection;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class DeleteUnderwriterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM Underwriter WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            response.getWriter().println(rows > 0 ? "<h3>Underwriter Deleted Successfully</h3>" : "<h3>Underwriter Not Found</h3>");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error deleting underwriter</h3>");
        }
    }
}