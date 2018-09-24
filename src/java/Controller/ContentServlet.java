/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Category;
import Model.Content;
import Model.DAO;
import Model.Login;
import Model.Subject;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Imesh Ranawaka
 */
@MultipartConfig(maxFileSize = 16177215)
public class ContentServlet extends HttpServlet {

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
//            out.println("<title>Servlet ContentServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ContentServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");

        response.setContentType("text/html");
        String command = request.getParameter("Content");
        DAO dao = new DAO();
        String sID;
        String cID;
        String conID;
        switch (command) {
            case "Add-Content":
                sID = request.getParameter("subjectID");
                getSubjectsEnroll(request, response, dao);
                if (sID != null && !sID.equals("")) {
                    getSubject(request, response, dao);
                    getCategoryList(request, response, dao);
                }
                request.getRequestDispatcher("/AddContent.jsp").forward(request, response);
                break;
            case "Remove-Content":
                conID = request.getParameter("contentID");
                if (conID != null) {
                    getConDetails(request, response, dao);
                    request.getRequestDispatcher("/DisplayContent.jsp").forward(request, response);
                } else {
                    sID = request.getParameter("subjectID");
                    if (login.getRegType().equals("Teacher")) {
                        getSubjectsEnroll(request, response, dao);
                    } else {
                        getSubjectList(request, response, dao);
                    }

                    if (sID != null) {
                        getSubject(request, response, dao);
                        getCategoryList(request, response, dao);
                        cID = request.getParameter("categoryID");
                        if (cID != null) {
                            getCategory(request, response, dao);
                            if (login.getRegType().equals("Teacher")) {
                                getContentList(request, response, dao);
                            } else {
                                getAllContentList(request, response, dao);
                            }
                        }
                    }
                    request.getRequestDispatcher("/RemoveContent.jsp").include(request, response);
                }
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

        String command = request.getParameter("command");
        DAO dao = new DAO();
        String sID;
        boolean status;
        switch (command) {
            case "add-content":
                status = addContent(request, response, dao);
                if (status) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Content Added Successfully!");
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("msg", "Content Adding Un-Successfully!");
                }
                getSubjectsEnroll(request, response, dao);
                request.getRequestDispatcher("/AddContent.jsp").include(request, response);
                break;
            case "remove-content":
                status = removeContent(request, response, dao);
                if (status) {
                    request.setAttribute("display_msg", true);
                    request.setAttribute("msg", "Content Removed Successfully!");
                } else {
                    request.setAttribute("display_error", true);
                    request.setAttribute("error_msg", "Content Removing Un-Successfully!");
                }
                if (login.getRegType().equals("Teacher")) {
                    getSubjectsEnroll(request, response, dao);
                } else {
                    getSubjectList(request, response, dao);
                }
                request.getRequestDispatcher("/RemoveContent.jsp").forward(request, response);
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

    private void getSubjectsEnroll(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        List<Subject> subList = new ArrayList<>();
        if (login.getRegType().equals("Student")) {
            subList = dao.getSubEnrollStudent(login);
        } else {
            subList = dao.getSubEnrollTeacher(login);
        }
        if (subList.size() > 0) {
            request.setAttribute("Subject_List", subList);
        } else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Enrolled Subjects found!");
        }
    }

    private void getSubject(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Integer sID = new Integer(request.getParameter("subjectID"));
        Subject subject = new Subject(sID);
        request.setAttribute("displaySub", subject);
    }

    private void getCategoryList(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Subject subject = (Subject) request.getAttribute("displaySub");
        List<Category> category = dao.getSubCatList(subject);
        if (category.size() > 0) {
            request.setAttribute("displayCatDetails", true);
            request.setAttribute("Category_List", category);
        } else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Categories found!");
        }

    }

    private boolean addContent(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        try {
            Integer cID = new Integer(request.getParameter("CID"));
            String title = request.getParameter("CTitle");
            String desc = request.getParameter("CDescription");
            String cType = request.getParameter("CType");
            Part filePart = request.getPart("CFile");
            if (filePart.getSize() <= 16177215) {
                String contentType = filePart.getContentType();
                String fileName = filePart.getSubmittedFileName();
                int lastIndex = fileName.lastIndexOf(".");
                String ext = fileName.substring(lastIndex);
                String path = request.getServletContext().getRealPath(File.separator) + "\\FileUploads\\";// System.getProperty("user.dir");
                switch (contentType) {
                    case "image/png":
                    case "image/jpeg":
                        path += "Image";
                        break;
                    case "text/html":
                    case "text/richtext":
                    case "text/plain":
                        path += "Text";
                        break;
                    case "video/jpeg":
                    case "video/mpeg":
                    case "video/mp4":
                    case "video/3gpp":
                        path += "Video";
                        break;
                    case "audio/mp3":
                    case "audio/mp4":
                        path += "Audio";
                        break;
                    case "application/pdf":
                        path += "PDF";
                        break;
                    default:
                        request.setAttribute("display_error", true);
                        request.setAttribute("error_msg", "File format Invalid!");
                        getSubjectsEnroll(request, response, dao);
                        request.getRequestDispatcher("/AddContent.jsp").forward(request, response);
                        return false;
                }

                if (cType.equals("Lessons")) {
                    path += "\\Lessons";
                } else if (cType.equals("Test")) {
                    path += "\\Test";
                } else {
                    path += "\\Tutorials";
                }

                File file = new File(path);
                if (!file.exists()) {
                    file.mkdirs();
                }

                HttpSession session = request.getSession();
                Login login = (Login) session.getAttribute("user");
                Content con = new Content(title, desc, cType, cID, login.getUname(), "P");
                int conID = dao.addContent(con);
                con.setcID(conID);

                file = new File(path + "\\" + login.getUname() + "_" + conID + ext);
                InputStream input = filePart.getInputStream();
                Files.copy(input, file.toPath());
                con.setFilePath(file.getPath().replace(request.getServletContext().getRealPath(File.separator) + "\\", ""));

                DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                Date date = new Date();
                java.sql.Date sqlDate = new java.sql.Date(date.getTime());

                con.setDateCreated(sqlDate);
                return dao.addPendingContent(con);
            } else {
                request.setAttribute("display_error", true);
                request.setAttribute("error_msg", "Added Content Size more than 16MB!");
                getSubjectsEnroll(request, response, dao);
                request.getRequestDispatcher("/AddContent.jsp").forward(request, response);
            }
        } catch (IOException ex) {
            Logger.getLogger(ContentServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ServletException ex) {
            Logger.getLogger(ContentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    private void getContentList(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        Integer cID = new Integer(request.getParameter("categoryID"));
        Category cat = new Category(cID);
        List<Content> contentList = dao.getContentList(cat, login);
        if (contentList.size() > 0) {
            request.setAttribute("Content_List", contentList);
        } else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Content found!");
        }

    }

    private void getAllContentList(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        HttpSession session = request.getSession();
        Integer cID = new Integer(request.getParameter("categoryID"));
        Category cat = new Category(cID);
        List<Content> contentList = dao.getAllConList(cat);
        if (contentList.size() > 0) {
            request.setAttribute("Content_List", contentList);
        } else {
            request.setAttribute("display_error", true);
            request.setAttribute("error_msg", "No Content found!");
        }

    }

    private void getCategory(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Integer cID = new Integer(request.getParameter("categoryID"));
        Category subject = new Category(cID);
        request.setAttribute("displayCat", subject);
    }

    private void getConDetails(HttpServletRequest request, HttpServletResponse response, DAO dao) {

        //try {
        HttpSession session = request.getSession();
        Login login = (Login) session.getAttribute("user");
        Integer conID = Integer.parseInt(request.getParameter("contentID"));
        Content content = new Content(conID);
        content = dao.getContent(content);
        content.setFilePath(content.getFilePath());
        request.setAttribute("Content_Details", content);
    }

    private boolean removeContent(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        Integer conID = new Integer(request.getParameter("contentID"));
        Content content = new Content(conID);
        return dao.removeContent(content);
    }

    private void getSubjectList(HttpServletRequest request, HttpServletResponse response, DAO dao) {
        ArrayList<Subject> subList = dao.getSubList();
        request.setAttribute("Subject_List", subList);
    }
}
