/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.MySQLConnection;
import com.mysql.jdbc.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Imesh Ranawaka
 */
public class DAO {
    private Connection connection;
    
    public DAO(){
        connection= Database.getConnection();
    }
    
    /*Login Table*/
    public boolean checkUName(String uname){
        try{
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from login where uname=?");
            ps.setString(1, uname);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }catch(Exception ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean checkEmail(String email){
        try{
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from login where email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }catch(Exception ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean addLogin(Login login){
        try{
            PreparedStatement ps = (PreparedStatement) connection
                    .prepareStatement("insert into login (uname,pass,email,regType) values (?,?,?,?)");
            ps.setString(1, login.getUname());
            ps.setString(2, login.getPass());
            ps.setString(3, login.getEmail());
            ps.setString(4, login.getRegType());
            ps.executeUpdate();
            return true;
        }catch(Exception ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
            
        }
        return false;
    }
    
    public String authenticateUser(Login login){
        try{
            String userName = login.getUname();
            String password = login.getPass();
            
            PreparedStatement ps = (PreparedStatement) connection
                    .prepareStatement("select uname,pass,regType from login where uname=? and pass=?");
            ps.setString(1, userName);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                String NAME = rs.getString("uname");
                String PWD = rs.getString("pass");
                String ROLE = rs.getString("regType");
                if(userName.equals(NAME) && password.equals(PWD) && ROLE.equals("A"))
                    return "Admin";
                else if(userName.equals(NAME) && password.equals(PWD) && ROLE.equals("S"))
                    return "Student";
                else if(userName.equals(NAME) && password.equals(PWD) && ROLE.equals("T"))
                    return "Teacher";
            }
        }catch(Exception ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "invalid";
    }
    /*Login Table End*/
    
    /*Student Table*/
    public boolean registerStudent(Student student){
        try{
            PreparedStatement ps = (PreparedStatement) connection
                    .prepareStatement("insert into student (uname,fname,lname,dob,gender) values (?,?,?,?,?)");
            ps.setString(1, student.getUname());
            ps.setString(2, student.getFname());
            ps.setString(3, student.getLname());
            ps.setString(4, student.getDob());
            ps.setString(5, student.getGender());
            ps.executeUpdate();
            return true;
        }catch(Exception ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    /*Student Table End*/
    
    /*Teacher Table*/
    public boolean registerTeacher(Teacher teacher){
        try{
            PreparedStatement ps = (PreparedStatement) connection
                    .prepareStatement("insert into teacher (uname,fname,lname,dob,gender) values (?,?,?,?,?)");
            ps.setString(1, teacher.getUname());
            ps.setString(2, teacher.getFname());
            ps.setString(3, teacher.getLname());
            ps.setString(4, teacher.getDob());
            ps.setString(5, teacher.getGender());
            ps.executeUpdate();
            return true;
        }catch(Exception ex){
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    /*Teacher Table End*/
    
    /*Subject Table*/
    public boolean checkSubject(Subject subject){
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where title=?");
            ps.setString(1,subject.getsTitle());
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean addSubject(Subject subject){
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("insert into subject (title,description) values (?,?)");
            ps.setString(1, subject.getsTitle());
            ps.setString(2, subject.getsDes());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public int getSID(Subject subject){
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select sID from subject where title=?");
            ps.setString(1, subject.getsTitle());
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                return rs.getInt("sID");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
    
    public ArrayList<Subject> getSubList(){
        ArrayList<Subject> subList = new ArrayList<>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
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
    
    public Subject getSubject(Subject subject){
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from subject where sID = ?");
            ps.setInt(1,subject.getsID());
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
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
    
    public boolean removeSubject(Subject subject){
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("delete from subject where sID = ?");
            ps.setInt(1,subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean updateSubject(Subject subject){
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("update subject set title = ?, description = ? where sID = ?");
            ps.setString(1,subject.getsTitle());
            ps.setString(2,subject.getsDes());
            ps.setInt(3,subject.getsID());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    /*Subject Table End*/
    
    /*Category Table*/
    public boolean addCategory(Category category){
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
    
    public List<Category> getSubCatList(Subject subject){
        List<Category> catList = new ArrayList<Category>();
        try {
            PreparedStatement ps = (PreparedStatement) connection.prepareStatement("select * from category where sID=?");
            ps.setInt(1,subject.getsID());
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
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
    /*Category Table End*/
}
