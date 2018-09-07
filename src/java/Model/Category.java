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
public class Category {
    
    int sID;
    String cTitle;
    String cDesc;
    
    public Category(int sID, String cTitle, String cDesc) {
        this.sID = sID;
        this.cTitle = cTitle;
        this.cDesc = cDesc;
    }

    public void setsID(int sID) {
        this.sID = sID;
    }
    
    public void setcTitle(String cTitle) {
        this.cTitle = cTitle;
    }

    public void setcDesc(String cDesc) {
        this.cDesc = cDesc;
    }

    public int getsID() {
        return sID;
    }
    
    public String getcTitle() {
        return cTitle;
    }

    public String getcDesc() {
        return cDesc;
    }
    
}
