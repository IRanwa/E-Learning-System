/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Category;
import Model.DAO;
import Model.Login;
import Model.Subject;
import java.io.IOException;
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
                sID = request.getParameter("subjectID");
                viewSubject(request, response, dao);
                if (sID != null && !sID.equals("")) {
                    getSubject(request, response, dao);
                    request.setAttribute("displaySubDetails", true);
                }
                request.getRequestDispatcher("/RemoveSubject.jsp").forward(request, response);

                //response.sendRedirect("RemoveSubject.jsp#remove-subject");
                break;
            case "Update-Subject":
                sID = request.getParameter("subjectID");
                viewSubject(request, response, dao);
                if (sID != null && !sID.equals("")) {
                    getSubject(request, response, dao);
                    request.setAttribute("displaySubDetails", true);
                }
                request.getRequestDispatcher("/UpdateSubject.jsp").forward(request, response);
                break;
            case "View-Subject":
                viewSubject(request, response, dao);
                request.getRequestDispatcher("/ViewSubject.jsp").forward(request, response);
                break;
            case "Enroll":
                sID = request.getParameter("subjectID");
                getSubjectsNotEnroll(request, response, dao);
                if (sID != null && !sID.equals("")) {
                    getSubject(request, response, dao);
                    getCategory(request, response, dao);
                    request.setAttribute("displaySubDetails", true);
                }
                request.getRequestDispatcher("/Enroll.jsp").forward(request, response);
                break;
            case "Un-Enroll":
                sID = request.getParameter("subjectID");
                getSubjectsEnroll(request, response, dao);
                if (sID != null && !sID.equals("")) {
                    getSubject(request, response, dao);
                    getCategory(request, response, dao);
                    request.setAttribute("displaySubDetails", true);
                }
                request.getRequestDispatcher("/Un-Enroll.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        session.setAttribute("user", login);
        String command = request.getParameter("command");
        DAO dao = new DAO();
        boolean subStatus;
        switch (command) {
            case "add-subject":
                subStatus = addSubject(request, response, dao);
                if (subStatus) {
                    boolean catStatus = addSubCategory(request, response, dao);
                    if (catStatus) {
                        request.setAttribute("display_msg", true);
                        request.setAttribute("msg", "Subject Added Successfully!");
                    } else {
                        request.setAttribute("display_error", true);
                        request.setAttribute("error_msg", "Subject adding Un-Successful!");
                    }
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Subject already added!");
                }
                request.getRequestDispatcher("/AddSubject.jsp").include(request, response);
                break;
            case "remove-subject":
                subStatus = removeSubject(request, response, dao);
                if (subStatus) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Subject Removed Successfully!");
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Subject removing un-successful!");
                }
                viewSubject(request, response, dao);
                request.getRequestDispatcher("/RemoveSubject.jsp").include(request, response);
                break;
            case "update-subject":
                subStatus = updateSubject(request, response, dao);
                if (subStatus) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Subject Updated Successfully!");
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Subject updating un-successful!");
                }
                viewSubject(request, response, dao);
                request.getRequestDispatcher("/UpdateSubject.jsp").include(request, response);
                break;
            case "view-subject":
                viewSubject(request, response, dao);
                String sID = request.getParameter("subjectID");
                request.setAttribute("displaySubDetails", true);
                if (sID.equals("All")) {
                    request.setAttribute("All_Subjects", true);
                } else {
                    getSubject(request, response, dao);
                    getCategory(request, response, dao);
                }
                request.getRequestDispatcher("/ViewSubject.jsp").include(request, response);
                break;
            case "enroll-subject":
                subStatus = enrollUser(request, response, dao);
                if (subStatus) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Enrolled Successfully!");
                    getSubjectsNotEnroll(request, response, dao);
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Enrolled un-successful!");
                }
                request.getRequestDispatcher("/Enroll.jsp").forward(request, response);
                break;
            case "un-enroll-subject":
                subStatus = unenrollUser(request, response, dao);
                if (subStatus) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Un-Enrolled Successfully!");
                    getSubjectsEnroll(request, response, dao);
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Un-Enroll un-successful!");
                }
                request.getRequestDispatcher("/Un-Enroll.jsp").forward(request, response);
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
        if (subList.size() > 0) {
            request.setAttribute("Subject_List", subList);
        } else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Subjects found!");
        }
    }

    private void getSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Integer sID = new Integer(request.getParameter("subjectID"));
        Subject subject = new Subject(sID);
        subject = dao.getSubject(subject);
        request.setAttribute("displaySub", subject);
    }

    private boolean addSubCategory(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        String title = request.getParameter("STitle");
        Subject subject = new Subject(title);
        int sID = dao.getSID(subject);

        if (sID > 0) {
            String cTitle = request.getParameter("CTitle");
            String cDesc = request.getParameter("CDescription");
            Category category = new Category(cTitle, cDesc, sID);
            return dao.addCategory(category);
        }
        return false;
    }

    private void getCategory(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Subject subject = (Subject) request.getAttribute("displaySub");
        List<Category> category = dao.getSubCatList(subject);
        request.setAttribute("displayCatDetails", true);
        request.setAttribute("Category_List", category);
    }

    private void getSubjectsNotEnroll(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        List<Subject> subList = null;
        if (login.getRegType().equals("Student")) {
            subList = dao.getSubNotEnrollStudent(login);
        } else {
            subList = dao.getSubNotEnrollTeacher(login);
        }
        if (subList.size() > 0) {
            request.setAttribute("Subject_List", subList);
        }
        else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Subjects found to Enroll!");
        }
    }

    private boolean enrollUser(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        Integer sID = new Integer(request.getParameter("subjectID"));
        Subject subject = new Subject(sID);
        if (login.getRegType().equals("Teacher")) {
            return dao.enrollTeacher(subject, login);
        } else {
            return dao.enrollStudent(subject, login);
        }
    }

    private void getSubjectsEnroll(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        List<Subject> subList = null;
        if (login.getRegType().equals("Student")) {
            subList = dao.getSubEnrollStudent(login);
        } else {
            subList = dao.getSubEnrollTeacher(login);
        }
        if (subList.size() > 0) {
            request.setAttribute("Subject_List", subList);
        }
        else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Enrolled Subjects found!");
        }
    }

    private boolean unenrollUser(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        Integer sID = new Integer(request.getParameter("subjectSID"));
        Subject subject = new Subject(sID);
        if (login.getRegType().equals("Teacher")) {
            return dao.unenrollTeacher(subject, login);
        } else {
            return dao.unenrollStudent(subject, login);
        }
    }
}
