/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Imesh Ranawaka
 */
public class DAO {

    private final Connection connection;

    public DAO() {
        connection = Database.getConnection();
    }

    /*Login Table*/
    public boolean checkUName(String uname) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from login where uname=?");
            ps.setString(1, uname);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean checkEmail(String email) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from login where email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean addLogin(Login login) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into login (uname,pass,email,lastLogin,regType) values (?,?,?,?,?)");
            ps.setString(1, login.getUname());
            ps.setString(2, login.getPass());
            ps.setString(3, login.getEmail());
            ps.setDate(4,login.getLastLogin());
            ps.setString(5, login.getRegType());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);

        }
        return false;
    }

    public String authenticateUser(Login login) {
        try {
            String userName = login.getUname();
            String password = login.getPass();

            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select uname,pass,regType from login where uname=? and pass=?");
            ps.setString(1, userName);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String NAME = rs.getString("uname");
                String PWD = rs.getString("pass");
                String ROLE = rs.getString("regType");
                if (userName.equals(NAME) && password.equals(PWD) && ROLE.equals("A")) {
                    return "Admin";
                } else if (userName.equals(NAME) && password.equals(PWD) && ROLE.equals("S")) {
                    return "Student";
                } else if (userName.equals(NAME) && password.equals(PWD) && ROLE.equals("T")) {
                    return "Teacher";
                } else if (userName.equals(NAME) && password.equals(PWD) && ROLE.equals("M")) {
                    return "Manager";
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "invalid";
    }

    /*Login Table End*/

 /*Student Table*/
    public boolean registerStudent(Student student) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into student (uname,fname,lname,dob,gender) values (?,?,?,?,?)");
            ps.setString(1, student.getUname());
            ps.setString(2, student.getFname());
            ps.setString(3, student.getLname());
            ps.setString(4, student.getDob());
            ps.setString(5, student.getGender());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /*Student Table End*/

 /*Teacher Table*/
    public boolean registerTeacher(Teacher teacher) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into teacher (uname,fname,lname,dob,gender) values (?,?,?,?,?)");
            ps.setString(1, teacher.getUname());
            ps.setString(2, teacher.getFname());
            ps.setString(3, teacher.getLname());
            ps.setString(4, teacher.getDob());
            ps.setString(5, teacher.getGender());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /*Teacher Table End*/

 /*Subject Table*/
    public boolean checkSubject(Subject subject) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where title=?");
            ps.setString(1, subject.getsTitle());
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean addSubject(Subject subject) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("Insert into subject (title,description) values (?,?)");
            ps.setString(1, subject.getsTitle());
            ps.setString(2, subject.getsDes());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int getSID(Subject subject) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select sID from subject where title=?");
            ps.setString(1, subject.getsTitle());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("sID");
            }

        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Subject> getSubList() {
        ArrayList<Subject> subList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int sID = rs.getInt("sID");
                String sTitle = rs.getString("title");
                String sDes = rs.getString("description");
                Subject subject = new Subject(sID, sTitle, sDes);
                subList.add(subject);
            }
            return subList;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subList;
    }

    public Subject getSubject(Subject subject) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where sID = ?");
            ps.setInt(1, subject.getsID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String sTitle = rs.getString("title");
                String sDes = rs.getString("description");
                subject.setsTitle(sTitle);
                subject.setsDes(sDes);
                return subject;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subject;
    }

    public boolean removeSubject(Subject subject) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("delete from subject where sID = ?");
            ps.setInt(1, subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateSubject(Subject subject) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("update subject set title = ?, description = ? where sID = ?");
            ps.setString(1, subject.getsTitle());
            ps.setString(2, subject.getsDes());
            ps.setInt(3, subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Subject getSubWithEnroll(Subject subject, Login login) {
        try {
            PreparedStatement ps;
            if (login.regType.equals("Teacher")) {
                ps = (PreparedStatement) connection.prepareStatement("SELECT s.*,IF(te.sID IS NULL, FALSE, TRUE) as status FROM teacherenroll as te right JOIN subject as s "
                        + "ON (s.sID = te.sID) where s.sID = ?");
            } else {
                ps = (PreparedStatement) connection.prepareStatement("SELECT s.*,IF(se.sID IS NULL, FALSE, TRUE) as status FROM studentenroll as se right JOIN subject as s "
                        + "ON (s.sID = se.sID) where s.sID = ?");
            }
            ps.setInt(1, subject.getsID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String sTitle = rs.getString("title");
                String sDes = rs.getString("description");
                boolean eStatus = rs.getBoolean("status");
                subject.setsTitle(sTitle);
                subject.setsDes(sDes);
                subject.setUserEnroll(eStatus);
                return subject;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subject;
    }

    public List<Subject> getSubListWithEnroll( Login login) {
        List<Subject> subList = new ArrayList<>();
        try {
            PreparedStatement ps;
            if (login.regType.equals("Teacher")) {
                ps = (PreparedStatement) connection.prepareStatement("SELECT s.*,IF(te.sID IS NULL, FALSE, TRUE) as status FROM teacherenroll as te right JOIN subject as s "
                        + "ON (s.sID = te.sID)");
            } else {
                ps = (PreparedStatement) connection.prepareStatement("SELECT s.*,IF(se.sID IS NULL, FALSE, TRUE) as status FROM studentenroll as se right JOIN subject as s "
                        + "ON (s.sID = se.sID)");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Integer sID = rs.getInt("sID");
                String sTitle = rs.getString("title");
                String sDes = rs.getString("description");
                boolean eStatus = rs.getBoolean("status");
                Subject subject = new Subject(sID,sTitle, sDes, eStatus);
                subList.add(subject);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subList;
    }
    /*Subject Table End*/

 /*Category Table*/
    public boolean addCategory(Category category) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into category (sID,title,description) values (?,?,?)");
            ps.setInt(1, category.getsID());
            ps.setString(2, category.getcTitle());
            ps.setString(3, category.getcDes());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public List<Category> getSubCatList(Subject subject) {
        List<Category> catList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from category where sID=?");
            ps.setInt(1, subject.getsID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int cID = rs.getInt("cID");
                String title = rs.getString("title");
                String desc = rs.getString("description");
                Category category = new Category(cID, title, desc);
                catList.add(category);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return catList;
    }

    public Category getCategory(Category category) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from category where cID=?");
            ps.setInt(1, category.getcID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String title = rs.getString("title");
                String desc = rs.getString("description");
                category.setcTitle(title);
                category.setcDes(desc);
                return category;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return category;
    }

    //Remove the all the categories related to the specific subject
    public boolean removeCategory(Subject subject) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("delete from category where sID = ?");
            ps.setInt(1, subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //Remove the specific category
    public boolean removeCategory(Category category) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("delete from category where cID = ?");
            ps.setInt(1, category.getcID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateCategory(Category category) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("update category set title = ?, description = ? where cID = ?");
            ps.setString(1, category.getcTitle());
            ps.setString(2, category.getcDes());
            ps.setInt(3, category.getcID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /*Category Table End*/

 /*Student Enroll Subject*/
    public boolean enrollStudent(Subject subject, Login login) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into studentenroll (uname,sID) values (?,?)");
            ps.setString(1, login.getUname());
            ps.setInt(2, subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean unenrollStudent(Subject subject, Login login) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("delete from studentenroll where uname=? and sID=?");
            ps.setString(1, login.getUname());
            ps.setInt(2, subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //Here checking at least enrolled for one subject
    public boolean checkEnrollStudent(Login login) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from studentenroll where uname=?");
            ps.setString(1, login.getUname());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /*Student Enroll Subject End*/

 /*Teacher Enroll Subject*/
    public boolean enrollTeacher(Subject subject, Login login) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into teacherenroll (uname,sID) values (?,?)");
            ps.setString(1, login.getUname());
            ps.setInt(2, subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean unenrollTeacher(Subject subject, Login login) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("delete from teacherenroll where uname=? and sID=?");
            ps.setString(1, login.getUname());
            ps.setInt(2, subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //Here checking at least enrolled for one subject
    public boolean checkEnrollTeacher(Login login) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from teacherenroll where uname=?");
            ps.setString(1, login.getUname());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /*Teacher Enroll Subject End*/
    //All Contents are available here
    /*Content Table*/
    public int addContent(Content content) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into content (title,description,cType,status,tUname,catID) values (?,?,?,?,?,?)",
                     Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, content.getTitle());
            ps.setString(2, content.getDesc());
            ps.setString(3, content.getType());
            ps.setString(4, content.getStatus());
            ps.setString(5, content.gettUName());
            ps.setInt(6, content.getCatID());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Content> getContentList(Category category, Login login) {
        List<Content> contentList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from content where catID=? and tUname=?");
            ps.setInt(1, category.getcID());
            ps.setString(2, login.getUname());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int conID = rs.getInt("cID");
                String conTitle = rs.getString("title");
                Content con = new Content(conID, conTitle);
                contentList.add(con);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return contentList;
    }

    public Content getContent(Content content) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from content as c left join pendingcontent as pc on (pc.cID = c.cID) where pc.cID=?");
            ps.setInt(1, content.getcID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                content.setTitle(rs.getString("title"));
                content.setDesc(rs.getString("description"));
                content.setType(rs.getString("cType"));
                content.setStatus(rs.getString("status"));
                content.setFilePath(rs.getString("cPath"));
                content.setDateCreated(rs.getDate("dateCreated"));
                return content;
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return content;
    }

    public boolean removeContent(Content content) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("delete from content where cID=?");
            ps.setInt(1, content.getcID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public List<Content> getAllConList(Category category) {
        List<Content> contentList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from content where catID=?");
            ps.setInt(1, category.getcID());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int conID = rs.getInt("cID");
                String conTitle = rs.getString("title");
                Content con = new Content(conID, conTitle);
                contentList.add(con);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return contentList;
    }
    /*Content Table End*/

 /*Pending Content Table*/
    public boolean addPendingContent(Content content) {
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into pendingcontent (cID,cPath,dateCreated) values (?,?,?)");
            ps.setInt(1, content.getcID());
            ps.setString(2, content.getFilePath());
            ps.setDate(3, content.getDateCreated());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /*Pending Content Table End*/

 /*Combine Table*/
    public List<Subject> getSubNotEnrollStudent(Login login) {
        List<Subject> subList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where sID not IN (select s.sID from subject as s left join studentenroll as se "
                    + "on s.sID=se.sID where se.uname=?)");
            ps.setString(1, login.getUname());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int sID = rs.getInt("sID");
                String title = rs.getString("title");
                String desc = rs.getString("description");
                Subject subject = new Subject(sID, title, desc);
                subList.add(subject);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subList;
    }

    public List<Subject> getSubNotEnrollTeacher(Login login) {
        List<Subject> subList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where sID not IN (select s.sID from subject as s left join teacherenroll as te "
                    + "on s.sID=te.sID where te.uname=?)");
            ps.setString(1, login.getUname());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int sID = rs.getInt("sID");
                String title = rs.getString("title");
                String desc = rs.getString("description");
                Subject subject = new Subject(sID, title, desc);
                subList.add(subject);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subList;
    }

    public List<Subject> getSubEnrollStudent(Login login) {
        List<Subject> subList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where sID IN (select s.sID from subject as s left join studentenroll as se "
                    + "on s.sID=se.sID where se.uname=?)");
            ps.setString(1, login.getUname());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int sID = rs.getInt("sID");
                String title = rs.getString("title");
                String desc = rs.getString("description");
                Subject subject = new Subject(sID, title, desc);
                subList.add(subject);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subList;
    }

    public List<Subject> getSubEnrollTeacher(Login login) {
        List<Subject> subList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where sID IN (select s.sID from subject as s left join teacherenroll as te "
                    + "on s.sID=te.sID where te.uname=?)");
            ps.setString(1, login.getUname());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int sID = rs.getInt("sID");
                String title = rs.getString("title");
                String desc = rs.getString("description");
                Subject subject = new Subject(sID, title, desc);
                subList.add(subject);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return subList;
    }
    /*Combine Table End*/
}
