/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Char.CharControl;
import Dao.FileDao;
import Model.FileObj;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
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
public class FileAction extends ActionSupport {

    private List<FileObj> list;
    private FileObj f;
    private int uId;
    private int id;
    private int usercode;
    private int page;
    private int noOfPages;
    private int noOfRecords;
    private int currentPage;
    private int userRole;
    private String searchString;
    private String fileName;

    private Map session;

    private File taskFile;
    private String taskFileContentType;
    private String taskFileFileName;

    private InputStream fileInputStream;

    FileDao fdao = new FileDao();
    CharControl cc = new CharControl();

    public FileAction() {
    }

    public InputStream getFileInputStream() {
        return fileInputStream;
    }

    public void setFileInputStream(InputStream fileInputStream) {
        this.fileInputStream = fileInputStream;
    }

    public List<FileObj> getList() {
        return list;
    }

    public void setList(List<FileObj> list) {
        this.list = list;
    }

    public FileObj getF() {
        return f;
    }

    public void setF(FileObj f) {
        this.f = f;
    }

    public int getUsercode() {
        return usercode;
    }

    public void setUsercode(int usercode) {
        this.usercode = usercode;
    }

    public int getuId() {
        return uId;
    }

    public void setuId(int uId) {
        this.uId = uId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getUserRole() {
        return userRole;
    }

    public void setUserRole(int userRole) {
        this.userRole = userRole;
    }

    public String getSearchString() {
        return searchString;
    }

    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Map getSession() {
        return session;
    }

    public void setSession(Map session) {
        this.session = session;
    }

    public File getTaskFile() {
        return taskFile;
    }

    public void setTaskFile(File taskFile) {
        this.taskFile = taskFile;
    }

    public String getTaskFileContentType() {
        return taskFileContentType;
    }

    public void setTaskFileContentType(String taskFileContentType) {
        this.taskFileContentType = taskFileContentType;
    }

    public String getTaskFileFileName() {
        return taskFileFileName;
    }

    public void setTaskFileFileName(String taskFileFileName) {
        this.taskFileFileName = taskFileFileName;
    }

    public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public String getListTask() {
        String result = "fail";
        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null) {
            userRole = (int) session.get("ROLE");
            usercode = (int) session.get("ID");
            if (userRole < 2) {
                return result;
            }
        } else {
            return result;
        }

        page = 1;
        int recordsPerPage = 5;
        if (ServletActionContext.getRequest().getParameter("page") != null) {
            page = Integer.parseInt(ServletActionContext.getRequest().getParameter("page"));
        }
        list = new ArrayList<FileObj>();
        list = fdao.getListFilePaging((page - 1) * recordsPerPage, recordsPerPage, this.searchString);
        noOfRecords = fdao.getNoOfRecords();
        noOfPages = noOfRecords / recordsPerPage + ((noOfRecords % recordsPerPage == 0) ? 0 : 1);
        currentPage = page;
        if (noOfRecords > 0) {
            result = "success";
        } else {
            result = "fail";
        }

        return result;
    }

    public String insertTask() {
        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null && (int) session.get("ROLE") == 3) {
            return "success";
        } else {
            return "fail";
        }
    }

    public String insertTaskPr() {
        String result = "fail";
        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null && (int) session.get("ROLE") != 3) {
            return "fail";
        } else {
            if (session.get("ID") != null) {
                usercode = (int) session.get("ID");
            } else {
                return "fail";
            }
            try {
                if (this.taskFileFileName != null) {
                    String filePath = ServletActionContext.getServletContext().getRealPath("/");

                    int a = filePath.indexOf("\\build\\web");
                    filePath = filePath.substring(0, a);
                    filePath = filePath.concat("/web/task/");
                    filePath = filePath.concat(Integer.toString(usercode));

                    String fileName = new SimpleDateFormat("yyyyMMddHHmmss").format(Calendar.getInstance().getTime());
                    fileName = fileName.concat(cc.randomString(6)).concat(".").concat(this.taskFileFileName.substring(this.taskFileFileName.lastIndexOf(".") + 1).toLowerCase());

                    File fileToCreate = new File(filePath, fileName);
                    FileUtils.copyFile(this.taskFile, fileToCreate);

                    f.setfName(fileName);
                }
                f.setuId(usercode);
                f.setStatus(true);
                f.setpId(0);
                if (fdao.insertFile(f)) {
                    result = "success";
                } else {
                    result = "fail";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    public String answerTask() {
        String result = "fail";
        session = ActionContext.getContext().getSession();
        if (session.get("USER") != null) {
            userRole = (int) session.get("ROLE");
            usercode = (int) session.get("ID");
            if (userRole < 2) {
                return result;
            }
        } else {
            return result;
        }

        if (userRole == 3) {
            list = new ArrayList<FileObj>();
            list = fdao.getListAnswer(id);

            result = "success";
        } else {
            list = new ArrayList<FileObj>();
            list = fdao.getListAnswerFile(usercode, id);

            result = "success";
        }

        return result;
    }

    public String downloadFile() throws FileNotFoundException {

        f = fdao.getFileById(id);

        String filePath = ServletActionContext.getServletContext().getRealPath("/");

        int a = filePath.indexOf("\\build\\web");
        filePath = filePath.substring(0, a);
        filePath = filePath.concat("/web/task/");
        filePath = filePath.concat(Integer.toString(f.getuId())).concat("/");
        filePath = filePath.concat(f.getfName());
        fileInputStream = new FileInputStream(new File(filePath));
        fileName = f.getfName();

        return "success";
    }

}
