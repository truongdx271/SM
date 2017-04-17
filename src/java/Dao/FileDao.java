/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Connection.DBUtils;
import Model.FileObj;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class FileDao {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private int noOfRecords;

    public FileDao() {
        conn = DBUtils.getConnection();
    }

    public FileObj getFileByName(String fileName) {
        FileObj f = null;
        try {
            String sql = "SELECT * FROM `tbl_files` WHERE fName = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fileName);

            rs = ps.executeQuery();
            if (rs != null) {
                f = new FileObj();
                while (rs.next()) {
                    f.setfId(rs.getInt("fId"));
                    f.setuId(rs.getInt("uId"));
                    f.setNote(rs.getString("note"));
                    f.setfName(rs.getString("fName"));
                    f.setpId(rs.getInt("pId"));
                    f.setStatus(rs.getBoolean("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    public FileObj getFileById(int fId) {
        FileObj f = null;
        try {
            String sql = "SELECT * FROM `tbl_files` WHERE fId = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, fId);

            rs = ps.executeQuery();
            if (rs != null) {
                f = new FileObj();
                while (rs.next()) {
                    f.setfId(rs.getInt("fId"));
                    f.setuId(rs.getInt("uId"));
                    f.setNote(rs.getString("note"));
                    f.setfName(rs.getString("fName"));
                    f.setpId(rs.getInt("pId"));
                    f.setStatus(rs.getBoolean("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<FileObj> getListFilePaging(int offset, int noOfRecords, String searchString) {
        List<FileObj> list = null;
        try {
            String sql;
            if (searchString != null) {
                sql = "SELECT SQL_CALC_FOUND_ROWS *  FROM tbl_files WHERE uId = 1 AND (note LIKE ? OR fName LIKE ?) AND status = true ORDER BY status DESC, fId DESC LIMIT ?,?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + searchString + "%");
                ps.setString(2, "%" + searchString + "%");
                ps.setInt(3, offset);
                ps.setInt(4, noOfRecords);
            } else {
                sql = "SELECT SQL_CALC_FOUND_ROWS *  FROM tbl_files WHERE uId = 1 AND status = true ORDER BY status DESC, fId DESC LIMIT ?,?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, offset);
                ps.setInt(2, noOfRecords);
            }
            rs = ps.executeQuery();
            if (rs != null) {
                list = new ArrayList<FileObj>();
                FileObj f = null;
                while (rs.next()) {
                    f = new FileObj();
                    f.setfId(rs.getInt("fId"));
                    f.setuId(rs.getInt("uId"));
                    f.setNote(rs.getString("note"));
                    f.setfName(rs.getString("fName"));
                    f.setpId(rs.getInt("pId"));
                    f.setStatus(rs.getBoolean("status"));

                    list.add(f);
                }
                rs.close();

                rs = ps.executeQuery("SELECT FOUND_ROWS()");
                if (rs.next()) {
                    this.noOfRecords = rs.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<FileObj> getListAnswerFile(int uId, int pId) {
        List<FileObj> list = null;
        try {
            String sql = "SELECT  *  FROM tbl_files WHERE uId = ? AND pId = ? AND status = true ORDER BY status DESC, fId DESC ";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, uId);
            ps.setInt(2, pId);

            rs = ps.executeQuery();
            if (rs != null) {
                list = new ArrayList<FileObj>();
                FileObj f = null;
                while (rs.next()) {
                    f = new FileObj();
                    f.setfId(rs.getInt("fId"));
                    f.setuId(rs.getInt("uId"));
                    f.setNote(rs.getString("note"));
                    f.setfName(rs.getString("fName"));
                    f.setpId(rs.getInt("pId"));
                    f.setStatus(rs.getBoolean("status"));

                    list.add(f);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<FileObj> getListAnswer(int pId) {
        List<FileObj> list = null;
        try {
            String sql = "SELECT  tbl_files.*,tbl_users.name  FROM tbl_files INNER JOIN tbl_users ON tbl_files.uId = tbl_users.uId WHERE pId = ? AND status = true ORDER BY status DESC, fId DESC ";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, pId);

            rs = ps.executeQuery();
            if (rs != null) {
                list = new ArrayList<FileObj>();
                FileObj f = null;
                while (rs.next()) {
                    f = new FileObj();
                    f.setfId(rs.getInt("fId"));
                    f.setuId(rs.getInt("uId"));
                    f.setNote(rs.getString("note"));
                    f.setfName(rs.getString("fName"));
                    f.setpId(rs.getInt("pId"));
                    f.setStatus(rs.getBoolean("status"));

                    list.add(f);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertFile(FileObj f) {
        boolean result = false;
        try {
            String sql = "INSERT INTO tbl_files "
                    + "(`uId`, `note`, `fName`, `pId`, `status`)"
                    + "VALUES(?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, f.getuId());
            ps.setString(2, f.getNote());
            ps.setString(3, f.getfName());
            ps.setInt(4, f.getpId());
            ps.setBoolean(5, true);
            if (ps.executeUpdate() > 0) {
                result = true;
            } else {
                result = false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }

}
