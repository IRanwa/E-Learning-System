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
public class Content {

    int cID;
    String title;
    String desc;
    String type;
    int catID;
    String tUName;
    String status;
    String filePath;
    Date dateCreated;

    public Content(String title, String desc, String type, int catID, String tUName, String status) {
        this.title = title;
        this.desc = desc;
        this.type = type;
        this.catID = catID;
        this.tUName = tUName;
        this.status = status;
    }

    public int getcID() {
        return cID;
    }

    public String getTitle() {
        return title;
    }

    public String getDesc() {
        return desc;
    }

    public String getType() {
        return type;
    }

    public int getCatID() {
        return catID;
    }

    public String gettUName() {
        return tUName;
    }

    public String getStatus() {
        return status;
    }
    
    public String getFilePath() {
        return filePath;
    }

    public Date getDateCreated() {
        return dateCreated;
    }
    
    public void setcID(int cID) {
        this.cID = cID;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setCatID(int catID) {
        this.catID = catID;
    }

    public void settUName(String tUName) {
        this.tUName = tUName;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
    
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }
}
