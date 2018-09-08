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
public class Subject {

    private int sID;
    private String sTitle;
    private String sDes;
    
    public Subject(int sID) {
        this.sID = sID;
    }
    
    
    public Subject( String sTitle) {
        this.sTitle = sTitle;
    }
    
    public Subject( String sTitle, String sDes) {
        this.sTitle = sTitle;
        this.sDes = sDes;
    }
    
    public Subject(int sID, String sTitle, String sDes) {
        this.sID = sID;
        this.sTitle = sTitle;
        this.sDes = sDes;
    }
    
    public void setsID(int sID) {
        this.sID = sID;
    }

    public void setsTitle(String sTitle) {
        this.sTitle = sTitle;
    }

    public void setsDes(String sDes) {
        this.sDes = sDes;
    }

    public int getsID() {
        return sID;
    }

    public String getsTitle() {
        return sTitle;
    }

    public String getsDes() {
        return sDes;
    }
}
