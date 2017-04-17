/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Connection.DBUtils;
import Model.User;
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
public class UserDao {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private int noOfRecords;

    public UserDao() {
        conn = DBUtils.getConnection();
    }

    public boolean checkLogin(String username, String password) {
        boolean status = false;
        if (username != null && password != null) {
            try {
                String sql = "SELECT * FROM tbl_users WHERE username=? AND password=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);

//                String sql = "SELECT * FROM tbluser WHERE Username='" + username + "' AND Password='" + encryptedPwd + "'";
//                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                status = rs.next();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            status = false;
        }
        return status;
    }

    public boolean checkExistUser(String username) {
        boolean status = false;
        try {
            String sql = "SELECT Username FROM tbl_users WHERE Username=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            rs = ps.executeQuery();
            status = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return status;
    }

    public User getUserByUsername(String username) {
        User usr = null;
        try {
            String sql = "SELECT * FROM `tbl_users` WHERE username = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            rs = ps.executeQuery();
            if (rs != null) {
                usr = new User();
                while (rs.next()) {
                    usr.setuId(rs.getInt("uId"));
                    usr.setUsername(rs.getString("username"));
                    usr.setPassword(rs.getString("password"));
                    usr.setName(rs.getString("name"));
                    usr.setEmail(rs.getString("email"));
                    usr.setPhone(rs.getString("phone"));
                    usr.setAvatar(rs.getString("avatar"));
                    usr.setRole(rs.getInt("role"));
                    usr.setStatus(rs.getBoolean("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usr;
    }

    public User getUserById(int id) {
        User usr = null;
        try {
            String sql = "SELECT * FROM `tbl_users` WHERE uId = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();
            if (rs != null) {
                usr = new User();
                while (rs.next()) {
                    usr.setuId(rs.getInt("uId"));
                    usr.setUsername(rs.getString("username"));
                    usr.setPassword(rs.getString("password"));
                    usr.setName(rs.getString("name"));
                    usr.setEmail(rs.getString("email"));
                    usr.setPhone(rs.getString("phone"));
                    usr.setAvatar(rs.getString("avatar"));
                    usr.setRole(rs.getInt("role"));
                    usr.setStatus(rs.getBoolean("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usr;
    }

    public List<User> getListUserPaging(int offset, int noOfRecords, String searchString) {
        List<User> list = null;
        try {
            String sql;
            if (searchString != null) {
                sql = "SELECT SQL_CALC_FOUND_ROWS *  FROM tbl_users WHERE username LIKE ? OR name LIKE ? OR email LIKE ? ORDER BY role DESC, uId DESC, status DESC LIMIT ?,?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, "%" + searchString + "%");
                ps.setString(2, "%" + searchString + "%");
                ps.setString(3, "%" + searchString + "%");
                ps.setInt(4, offset);
                ps.setInt(5, noOfRecords);
            } else {
                sql = "SELECT SQL_CALC_FOUND_ROWS *  FROM tbl_users ORDER BY role DESC, uId DESC,status DESC LIMIT ?,?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, offset);
                ps.setInt(2, noOfRecords);
            }
            rs = ps.executeQuery();
            if (rs != null) {
                list = new ArrayList<User>();
                User u = null;
                while (rs.next()) {
                    u = new User();
                    u.setuId(rs.getInt("uId"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setName(rs.getString("name"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getString("phone"));
                    u.setAvatar(rs.getString("avatar"));
                    u.setStatus(rs.getBoolean("status"));
                    u.setRole(rs.getInt("role"));

                    list.add(u);
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

    public boolean insertUser(User usr) {
        boolean result = false;

        try {
            String sql = "INSERT INTO `tbl_users` ("
                    + "`username`,`password`,`name`,`email`,`phone`,`avatar`,`status`,`role`)"
                    + "VALUES(?,?,?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, usr.getUsername());
            ps.setString(2, usr.getPassword());
            ps.setString(3, usr.getName());
            ps.setString(4, usr.getEmail());
            ps.setString(5, usr.getPhone());
            ps.setString(6, usr.getAvatar());
            ps.setBoolean(7, true);
            ps.setInt(8, usr.getRole());

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
    
    public boolean editUser(User usr) {
        boolean result = false;

        try {
            String sql = "UPDATE `tbl_users` SET `name`=?,`email`=?,`phone`=?,`avatar`=?,`role`=? WHERE `username`=?";
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, usr.getName());
            ps.setString(2, usr.getEmail());
            ps.setString(3, usr.getPhone());
            ps.setString(4, usr.getAvatar());
            ps.setInt(5, usr.getRole());
            ps.setString(6, usr.getUsername());

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
    

    public int deleteUser(int id) {
        try {
            String sql = "UPDATE `tbl_users` SET `status` = FALSE WHERE `uId` = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }
    
}
