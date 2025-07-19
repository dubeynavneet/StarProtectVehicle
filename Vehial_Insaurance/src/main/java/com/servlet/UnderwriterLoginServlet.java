package com.servlet;

import com.dao.UnderwriterDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UnderwriterLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("userid");
        String pwd = request.getParameter("password");

        UnderwriterDAO dao = new UnderwriterDAO();
        try {
            if (dao.validate(id, pwd)) {
//            	System.out.println(id+" "+pwd);
                request.setAttribute("uid", id);
                RequestDispatcher rd = request.getRequestDispatcher("jsp/underwriter/underwriterHome.jsp");
                rd.forward(request, response);
            } else {
//                response.getWriter().println("<h3 class='error'>Invalid Credential, please try again</h3>");
                response.sendRedirect("jsp/underwriter/invalidUnderwriter.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}