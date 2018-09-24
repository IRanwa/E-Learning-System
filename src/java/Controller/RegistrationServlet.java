/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.DAO;
import Model.Login;
import Model.Student;
import Model.Teacher;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Imesh Ranawaka
 */
public class RegistrationServlet extends HttpServlet {

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
//            out.println("<title>Servlet RegistrationServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet RegistrationServlet at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
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
        //processRequest(request, response);
        regUser(request, response);

    }

    private void regUser(HttpServletRequest request, HttpServletResponse response) {
        try (PrintWriter out = response.getWriter();) {
            response.setContentType("text/html");
            ArrayList<String> msgs = new ArrayList<>();

            DAO dao = new DAO();

            boolean uNameRegistered = checkUName(request, response, dao);
            boolean emailRegistered = checkEmail(request, response, dao);
            boolean passMatch = checkPassMatch(request, response);

            if (uNameRegistered || emailRegistered || !passMatch) {
                if (uNameRegistered) {
                    msgs.add("Username already registered!");
                }
                if (emailRegistered) {
                    msgs.add("Email already used!");
                }
                if (!passMatch) {
                    msgs.add("Password not matched!");
                }

                request.setAttribute("display_error", true);
                request.setAttribute("msgs", msgs);
                request.getRequestDispatcher("/Registration.jsp").include(request, response);
            } else {
                boolean loginStatus = addUserToLogin(request, response, dao);
                boolean userRegStatus = addUserDetails(request, response, dao);

                if (loginStatus && userRegStatus) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Registered Successfully!");
                    request.getRequestDispatcher("/Registration.jsp").include(request, response);
                } else {
                    msgs.add("User Registration Un-Successful!");
                    request.setAttribute("display_error", true);
                    request.setAttribute("msgs", msgs);
                    request.getRequestDispatcher("/Registration.jsp").include(request, response);
                }

            }
        } catch (IOException ex) {
            Logger.getLogger(RegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ServletException ex) {
            Logger.getLogger(RegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private boolean checkUName(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        String uName = request.getParameter("UName");
        return dao.checkUName(uName); //Check User already registered
    }

    private boolean checkEmail(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        String email = request.getParameter("Email");
        return dao.checkEmail(email); //Check User already registered
    }

    private boolean checkPassMatch(HttpServletRequest request, HttpServletResponse response) {
        String pass = request.getParameter("Pass");
        String cpass = request.getParameter("CPass");

        if (pass.equals(cpass)) {
            return true;
        }
        return false;
    }

    private boolean addUserToLogin(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        String uName = request.getParameter("UName");
        String email = request.getParameter("Email");
        String pass = request.getParameter("Pass");
        String regType = request.getParameter("RegType");

        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        java.sql.Date sqlDate = new java.sql.Date(date.getTime());

        Login login = new Login(uName, pass, email, regType, sqlDate);

        return dao.addLogin(login);
    }

    private boolean addUserDetails(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        String uName = request.getParameter("UName");
        String regType = request.getParameter("RegType");
        String fName = request.getParameter("FName");
        String lName = request.getParameter("LName");
        String dob = request.getParameter("DOB");
        String contactNo = request.getParameter("ContactNo");
        String gender = request.getParameter("Gender");

        if (regType.equals("T")) {
            Teacher teacher = new Teacher(uName, fName, lName, dob, gender);
            return dao.registerTeacher(teacher);
        } else {
            Student student = new Student(uName, fName, lName, dob, gender);
            return dao.registerStudent(student);
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

}
