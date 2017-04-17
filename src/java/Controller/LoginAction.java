/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Dao.UserDao;
import Model.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.util.Map;
import org.apache.struts2.dispatcher.SessionMap;

/**
 *
 * @author admin
 */
public class LoginAction extends ActionSupport {

    private User usr = new User();
    UserDao dao = new UserDao();
    private Map session;

    public User getUsr() {
        return usr;
    }

    public void setUsr(User usr) {
        this.usr = usr;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public LoginAction() {
    }

    public String execute() throws Exception {
        return "success";
    }

    public String login() {
        if (dao.checkLogin(usr.getUsername(), usr.getPassword())) {
            usr = dao.getUserByUsername(usr.getUsername());

            String name = null;
            if (usr.getName().contains(" ")) {
                name = usr.getName().substring(usr.getName().lastIndexOf(" "), usr.getName().length());
            } else {
                name = usr.getName();
            }
            
            session = ActionContext.getContext().getSession();
            ((SessionMap) this.session).invalidate();
            session.put("USER", name);
            session.put("USERNAME", usr.getUsername());
            session.put("ROLE", usr.getRole());
            session.put("AVATAR", usr.getAvatar());
            session.put("ID", usr.getuId());
            return "success";
        } else {
            return "fail";
        }
    }

    public String logout() {
        session = ActionContext.getContext().getSession();
        session.clear();
        ((SessionMap) this.session).invalidate();
        return "success";
    }

}
