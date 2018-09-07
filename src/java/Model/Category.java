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

    String cTitle;
    String cDesc;
    
    public Category(String cTitle, String cDesc) {
        this.cTitle = cTitle;
        this.cDesc = cDesc;
    }

    public void setcTitle(String cTitle) {
        this.cTitle = cTitle;
    }

    public void setcDesc(String cDesc) {
        this.cDesc = cDesc;
    }

    public String getcTitle() {
        return cTitle;
    }

    public String getcDesc() {
        return cDesc;
    }
    
}
