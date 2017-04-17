/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.MessageDao;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;

/**
 *
 * @author daotao02
 */
public class MessageAction extends ActionSupport {

    private int id;
    private int messid;
    private int usercode;
    private String content;
    private Map session;

    MessageDao dao = new MessageDao();

    public MessageAction() {
    }

    public int getMessid() {
        return messid;
    }

    public void setMessid(int messid) {
        this.messid = messid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUsercode() {
        return usercode;
    }

    public void setUsercode(int usercode) {
        this.usercode = usercode;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String sendMessage() {
        String result = "fail";
        session = ActionContext.getContext().getSession();
        if (id == 0) {
            id = (int) session.get("userId");
//            session.remove("userId");
        }
        if (session.get("ID") != null) {
            usercode = (int) session.get("ID");
        } else {
            usercode = 0;
        }

        if (dao.sendMessage(usercode, id, content)) {
            result = "success";
        } else {
            result = "fail";
        }

        return result;
    }
    
    public String editMessage(){
        String result="fail";
        if (dao.editMessage(messid, content)) {
            result = "success";
        } else {
            result = "fail";
        }
        return result;
    }
    

    public String deleteMesssage() {
        String result = "fail";
        session = ActionContext.getContext().getSession();
        if (session.get("ID") != null) {
            usercode = (int) session.get("ID");
        } else {
            usercode = 0;
        }

        if (dao.deleteMessage(messid, usercode)) {
            result = "success";
        } else {
            result = "fail";
        }

        return result;
    }
}
