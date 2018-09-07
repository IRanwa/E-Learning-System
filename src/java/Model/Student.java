/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Imesh Ranawaka
 */
public class Student {
    String uname;
    String fname;
    String lname;
    String dob;
    String gender;

    public Student(String uname, String fname, String lname, String dob, String gender) {
        this.uname = uname;
        this.fname = fname;
        this.lname = lname;
        this.dob = dob;
        this.gender = gender;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getUname() {
        return uname;
    }

    public String getFname() {
        return fname;
    }

    public String getLname() {
        return lname;
    }

    public String getDob() {
        return dob;
    }

    public String getGender() {
        return gender;
    }
}
