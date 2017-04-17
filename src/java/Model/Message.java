/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Timestamp;

/**
 *
 * @author daotao02
 */
public class Message {
    private int mId;
    private int sentId;
    private int receiveId;
    private String sAvatar;
    private String sName;
    private String content;
    private Timestamp time;
    private boolean sDeleted;
    private boolean rDeleted;

    public int getmId() {
        return mId;
    }

    public void setmId(int mId) {
        this.mId = mId;
    }

    public int getSentId() {
        return sentId;
    }

    public void setSentId(int sentId) {
        this.sentId = sentId;
    }

    public int getReceiveId() {
        return receiveId;
    }

    public void setReceiveId(int receiveId) {
        this.receiveId = receiveId;
    }

    public String getsAvatar() {
        return sAvatar;
    }

    public void setsAvatar(String sAvatar) {
        this.sAvatar = sAvatar;
    }

    public String getsName() {
        return sName;
    }

    public void setsName(String sName) {
        this.sName = sName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public boolean issDeleted() {
        return sDeleted;
    }

    public void setsDeleted(boolean sDeleted) {
        this.sDeleted = sDeleted;
    }

    public boolean isrDeleted() {
        return rDeleted;
    }

    public void setrDeleted(boolean rDeleted) {
        this.rDeleted = rDeleted;
    }

    
}
