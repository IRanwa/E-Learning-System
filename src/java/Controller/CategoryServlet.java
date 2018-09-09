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
public class CategoryServlet extends HttpServlet {

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
//            out.println("<title>Servlet CategoryServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet CategoryServlet at " + request.getContextPath() + "</h1>");
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
        String command = request.getParameter("Category");
        DAO dao = new DAO();
        switch (command) {
            case "Add-Category":
                viewSubject(request, response, dao);
                request.getRequestDispatcher("/AddCategory.jsp").include(request, response);

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
        boolean status;
        viewSubject(request, response, dao);
        switch (command) {
            case "add-category":
                status = addCategory(request, response, dao);
                if (status) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Category Added Successfully!");
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Category adding Un-Successful!");
                }
                request.getRequestDispatcher("/AddCategory.jsp").include(request, response);
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

    private void viewSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        List<Subject> subList = dao.getSubList();
        if (subList.size() != 0) {
            request.setAttribute("Subject_List", subList);
        } else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Subjects found!");
        }
    }

    private boolean addCategory(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Integer sID = new Integer(request.getParameter("SID"));
        String cTitle = request.getParameter("CTitle");
        String cDes = request.getParameter("CDescription");
        Category category = new Category(cTitle, cDes, sID);
        return dao.addCategory(category);
    }

}
