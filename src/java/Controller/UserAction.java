/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Char.CharControl;
import Dao.MessageDao;
import Dao.UserDao;
import Model.Message;
import Model.Role;
import Model.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author admin
 */
public class UserAction extends ActionSupport {

    private List<User> list;
    private List<Message> listms;
    private User usr;
    private int uId;
    private int id;
    private int page;
    private int noOfPages;
    private int noOfRecords;
    private int currentPage;
    private int userRole;
    private String searchString;
    private String listName;
    private int usercode;
    private String content;

    private Map session;

    private File userImage;
    private String userImageContentType;
    private String userImageFileName;

    private List<Role> role;

    UserDao dao = new UserDao();
    MessageDao mdao = new MessageDao();
    CharControl cc = new CharControl();

    public UserAction() {
    }

    public List<Message> getListms() {
        return listms;
    }

    public void setListms(List<Message> listms) {
        this.listms = listms;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getUsercode() {
        return usercode;
    }

    public void setUsercode(int usercode) {
        this.usercode = usercode;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public File getUserImage() {
        return userImage;
    }

    public void setUserImage(File userImage) {
        this.userImage = userImage;
    }

    public String getUserImageContentType() {
        return userImageContentType;
    }

    public void setUserImageContentType(String userImageContentType) {
        this.userImageContentType = userImageContentType;
    }

    public String getUserImageFileName() {
        return userImageFileName;
    }

    public void setUserImageFileName(String userImageFileName) {
        this.userImageFileName = userImageFileName;
    }

    public List<Role> getRole() {
        return role;
    }

    public void setRole(List<Role> role) {
        this.role = role;
    }

    public String getListName() {
        return listName;
    }

    public void setListName(String listName) {
        this.listName = listName;
    }

    public int getUserRole() {
        return userRole;
    }

    public void setUserRole(int userRole) {
        this.userRole = userRole;
    }

    public List<User> getList() {
        return list;
    }

    public void setList(List<User> list) {
        this.list = list;
    }

    public User getUsr() {
        return usr;
    }

    public void setUsr(User usr) {
        this.usr = usr;
    }

    public int getuId() {
        return uId;
    }

    public void setuId(int uId) {
        this.uId = uId;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getNoOfPages() {
        return noOfPages;
    }

    public void setNoOfPages(int noOfPages) {
        this.noOfPages = noOfPages;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }

    public void setNoOfRecords(int noOfRecords) {
        this.noOfRecords = noOfRecords;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public String getSearchString() {
        return searchString;
    }

    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public String execute() throws Exception {
        return "success";
    }

    public String getListPaging() {
        String result = "fail";

        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null) {
            userRole = (int) session.get("ROLE");
        } else {
            userRole = 0;
        }
        page = 1;
        int recordsPerPage = 5;
        if (ServletActionContext.getRequest().getParameter("page") != null) {
            page = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
        }
        list = new ArrayList<User>();
        list = dao.getListUserPaging((page - 1) * recordsPerPage, recordsPerPage, this.searchString);
        noOfRecords = dao.getNoOfRecords();
        noOfPages = noOfRecords / recordsPerPage + ((noOfRecords % recordsPerPage == 0) ? 0 : 1);
        currentPage = page;
        if (noOfRecords > 0) {
            result = "success";
        } else {
            result = "fail";
        }
        return result;
    }

    public String insertUsr() {
        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null && (int) session.get("ROLE") == 3) {
            role = new ArrayList<Role>();
            role.add(new Role(1, "Người dùng"));
            role.add(new Role(2, "Học sinh"));
            role.add(new Role(3, "Giáo viên"));

            return "success";
        } else {
            return "fail";
        }
    }

    public String insertUsrPr() {
        String result = "fail";
        if (dao.checkExistUser(usr.getUsername())) {
            return result;
        } else {
            try {
                if (this.userImageFileName != null) {
                    String filePath = ServletActionContext.getServletContext().getRealPath("/");

                    int a = filePath.indexOf("\\build\\web");
                    filePath = filePath.substring(0, a);
                    filePath = filePath.concat("/web/images");

                    String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
                    fileName = fileName.concat(cc.randomString(6)).concat(".").concat(this.userImageFileName.substring(this.userImageFileName.lastIndexOf(".") + 1).toLowerCase());

                    File fileToCreate = new File(filePath, fileName);
                    FileUtils.copyFile(this.userImage, fileToCreate);

                    usr.setAvatar(fileName);
                } else {
                    usr.setAvatar("default-user-image.png");
                }
                usr.setRole(Integer.parseInt(listName));
                if (dao.insertUser(usr)) {
                    result = "success";
                } else {
                    result = "fail";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            return result;
        }

    }

    public String editUsr() {
        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null && (int) session.get("ROLE") == 3) {

            if (id == 0) {
                id = (int) session.get("userId");
                session.remove("userId");
            }
//            if (ServletActionContext.getRequest().getParameter("uId") != null) {
//                uId = Integer.parseInt(ServletActionContext.getRequest().getParameter("uId"));
//            }

            usr = dao.getUserById(id);
            role = new ArrayList<Role>();
            role.add(new Role(1, "Người dùng"));
            role.add(new Role(2, "Học sinh"));
            role.add(new Role(3, "Giáo viên"));
            return "success";
        } else {
            return "fail";
        }
    }

    public String editUsrPr() {
        String result = "fail";
        try {
            if (this.userImageFileName != null) {
                String filePath = ServletActionContext.getServletContext().getRealPath("/");

                int a = filePath.indexOf("\\build\\web");
                filePath = filePath.substring(0, a);
                filePath = filePath.concat("/web/images");

                String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
                fileName = fileName.concat(cc.randomString(6)).concat(".").concat(this.userImageFileName.substring(this.userImageFileName.lastIndexOf(".") + 1).toLowerCase());

                File fileToCreate = new File(filePath, fileName);
                FileUtils.copyFile(this.userImage, fileToCreate);

                usr.setAvatar(fileName);
            }
            usr.setRole(Integer.parseInt(listName));
            if (dao.editUser(usr)) {
                result = "success";
            } else {
                result = "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public String deleteUsr() {
        String result = "fail";
        try {
            if (dao.deleteUser(id) > 0) {
                result = "success";
            } else {
                result = "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public String viewProfile() {
        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null) {
            userRole = (int) session.get("ROLE");
        } else {
            userRole = 0;
        }

        if (id == 0) {
            id = (int) session.get("userId");
//            session.remove("userId");
        } else {
            session.put("userId", id);
        }
        if (session.get("ID") != null) {
            usercode = (int) session.get("ID");
        } else {
            usercode = 0;
        }

        usr = dao.getUserById(id);
        if (usercode != 0) {
            listms = new ArrayList<Message>();
            listms = mdao.getListMessage(usercode, id);
            noOfRecords = mdao.getNoOfRecords();
        }

        return "success";
    }

    public String changeProfile() {
        session = ActionContext.getContext().getSession();

        usr = dao.getUserById((int) session.get("ID"));
        session.put("userId", (int) session.get("ID"));
        return "success";
    }

    public String changeProfilePr() {
        String result = "fail";
        try {
            if (this.userImageFileName != null) {
                String filePath = ServletActionContext.getServletContext().getRealPath("/");

                int a = filePath.indexOf("\\build\\web");
                filePath = filePath.substring(0, a);
                filePath = filePath.concat("/web/images");

                String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
                fileName = fileName.concat(cc.randomString(6)).concat(".").concat(this.userImageFileName.substring(this.userImageFileName.lastIndexOf(".") + 1).toLowerCase());

                File fileToCreate = new File(filePath, fileName);
                FileUtils.copyFile(this.userImage, fileToCreate);

                usr.setAvatar(fileName);
            }
            if (dao.editUser(usr)) {
                result = "success";
            } else {
                result = "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

//    public String sendMessage() {
//        String result = "fail";
//        if (id == 0) {
//            id = (int) session.get("userId");
//            session.remove("userId");
//        }
//        if (session.get("ID") != null) {
//            usercode = (int) session.get("ID");
//        } else {
//            usercode = 0;
//        }
//
//        if (dao.sendMessage(usercode,id,content)) {
//            result = "success";
//        } else {
//            result = "fail";
//        }
//
//        return result;
//    }
//    private String uploadFile(String filePath, File file) throws IOException {
//        String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
//        fileName = fileName.concat(cc.randomString(6)).concat(".").concat(this.userImageFileName.substring(this.userImageFileName.lastIndexOf(".") + 1).toLowerCase());
//
//        File fileToCreate = new File(filePath, fileName);
//        FileUtils.copyFile(file, fileToCreate);
//        return fileName;
//    }
}
