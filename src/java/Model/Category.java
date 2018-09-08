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
    
    int cID;
    String cTitle;
    String cDes;
    
    public Category(int cID, String cTitle, String cDes) {
        this.cID = cID;
        this.cTitle = cTitle;
        this.cDes = cDes;
    }

    public void setcID(int cID) {
        this.cID = cID;
    }
    
    public void setcTitle(String cTitle) {
        this.cTitle = cTitle;
    }

    public void setcDes(String cDes) {
        this.cDes = cDes;
    }

    public int getcID() {
        return cID;
    }
    
    public String getcTitle() {
        return cTitle;
    }

    public String getcDes() {
        return cDes;
    }
    
}
