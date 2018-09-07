/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Category;
import Model.DAO;
import Model.Subject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Imesh Ranawaka
 */
public class SubjectServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SubjectServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SubjectServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String command = request.getParameter("Subject");
        switch (command) {
            case "Add-Subject":
                response.sendRedirect("AddSubject.jsp#add-subject");
                break;
            case "Remove-Subject":
                break;
            case "Update-Subject":
                break;
            case "View-Subject":
                break;
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String command = request.getParameter("command");
        DAO dao = new DAO();
        switch (command) {
            case "add-subject":
                boolean subStatus = addSubject(request, response, dao);
                if (subStatus) {
                    String title = request.getParameter("STitle");
                    Subject subject = new Subject(title);
                    int sID = dao.getSID(subject);
                    String cTitle = request.getParameter("CTitle");
                    String cDesc = request.getParameter("CDescription");
                    Category category = new Category(sID, cTitle, cDesc);

                    HttpSession session = request.getSession();
                    session.setAttribute("category", category);
                    session.setAttribute("category-command", "Add-Subject-Category");
                    response.sendRedirect("CategoryServlet");
                    //request.getRequestDispatcher("CategoryServlet").include(request, response);

                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Subject already added!");
                    request.getRequestDispatcher("/AddSubject.jsp").include(request, response);
                }
                break;

        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private boolean addSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        String title = request.getParameter("STitle");
        Subject subject = new Subject(title);
        boolean subStatus = dao.checkSubject(subject);
        if (!subStatus) {
            String desc = request.getParameter("SDescription");
            subject.setsDes(desc);
            return dao.addSubject(subject);
        }
        return false;
    }

    private boolean removeSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        return false;

    }

    private boolean updateSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        return false;

    }

    private void viewSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {

    }
}
