/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Date;

/**
 *
 * @author Imesh Ranawaka
 */
public class Login {

    String uname;
    String pass;
    String email;
    String regType;
    Date lastLogin;

    public Login(String uname, String pass, String email, String regType, Date lastLogin) {
        this.uname = uname;
        this.pass = pass;
        this.email = email;
        this.regType = regType;
        this.lastLogin = lastLogin;
    }
    
    public Login(String uname, String pass) {
        this.uname = uname;
        this.pass = pass;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setRegType(String regType) {
        this.regType = regType;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }
    
    public String getUname() {
        return uname;
    }

    public String getPass() {
        return pass;
    }

    public String getEmail() {
        return email;
    }

    public String getRegType() {
        return regType;
    }
    
    public Date getLastLogin() {
        return lastLogin;
    }
}
