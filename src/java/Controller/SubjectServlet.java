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
import java.util.ArrayList;
import java.util.List;
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
        DAO dao = new DAO();
        String command = request.getParameter("Subject");
        String sID;
        switch (command) {
            case "Add-Subject":
                response.sendRedirect("AddSubject.jsp#add-subject");
                break;
            case "Remove-Subject":
                sID = request.getParameter("id");
                viewSubject(request, response, dao);
                if (sID != null && !sID.equals("")) {
                    getSubject(request, response, dao);
                    request.setAttribute("displaySubDetails", true);
                    request.getRequestDispatcher("/RemoveSubject.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/RemoveSubject.jsp").forward(request, response);
                }
                //response.sendRedirect("RemoveSubject.jsp#remove-subject");
                break;
            case "Update-Subject":
                sID = request.getParameter("id");
                viewSubject(request, response, dao);
                if (sID != null && !sID.equals("")) {
                    getSubject(request, response, dao);
                    request.setAttribute("displaySubDetails", true);
                    request.getRequestDispatcher("/UpdateSubject.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/UpdateSubject.jsp").forward(request, response);
                }

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
        boolean subStatus;
        switch (command) {
            case "add-subject":
                subStatus = addSubject(request, response, dao);
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
            case "remove-subject":
                subStatus = removeSubject(request, response, dao);
                if (subStatus) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Subject Removed Successfully!");
                    viewSubject(request, response, dao);
                    request.getRequestDispatcher("/RemoveSubject.jsp").forward(request, response);
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Subject removing un-successful!");
                    viewSubject(request, response, dao);
                    request.getRequestDispatcher("/RemoveSubject.jsp").forward(request, response);
                }
                break;
            case "update-subject":
                subStatus = updateSubject(request, response, dao);
                if (subStatus) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Subject Updated Successfully!");
                    viewSubject(request, response, dao);
                    request.getRequestDispatcher("/UpdateSubject.jsp").forward(request, response);
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Subject updating un-successful!");
                    viewSubject(request, response, dao);
                    request.getRequestDispatcher("/UpdateSubject.jsp").forward(request, response);
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
        Integer sID = new Integer(request.getParameter("subjectSID"));
        Subject subject = new Subject(sID);
        return dao.removeSubject(subject);
    }

    private boolean updateSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Integer sID = new Integer(request.getParameter("subjectSID"));
        String sTitle = request.getParameter("STitle");
        String sDes = request.getParameter("SDescription");
        Subject subject = new Subject(sID, sTitle, sDes);
        return dao.updateSubject(subject);
    }

    private void viewSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        List<Subject> subList = dao.getSubList();
        if (subList.size() != 0) {
            request.setAttribute("Subject_List", subList);
        } else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Subjects found!");
        }
    }

    private void getSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Integer sID = new Integer(request.getParameter("id"));
        Subject subject = new Subject(sID);
        subject = dao.getSubject(subject);
        request.setAttribute("displaySub", subject);
    }

}
