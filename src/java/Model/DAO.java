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
    public boolean checkSubject(String sTitle){
        try {
            PreparedStatement ps = new PreparedStatement((MySQLConnection) connection,"select * from subject where title=?");
            ps.setString(1,sTitle);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public boolean addSubject(Subject subject){
        try {
            PreparedStatement ps =new PreparedStatement((MySQLConnection) connection, "insert into subject (sTitle,sDesc) values (?,?)");
            ps.setString(1, subject.getsTitle());
            ps.setString(2, subject.getsDes());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    /*Subject Table End*/
}