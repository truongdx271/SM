/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;

import Connection.DBUtils;
import Model.Message;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author daotao02
 */
public class MessageDao {

    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private int noOfRecords;
    private int sender;
    private int receiver;

    public MessageDao() {
        conn = DBUtils.getConnection();
    }

    public boolean sendMessage(int sender, int receiver, String content) {
        boolean result = false;
        try {
            String sql = "INSERT INTO `tbl_messages`(`sentId`, `receiveId`, `content`) VALUES (?,?,?)";
            ps = conn.prepareStatement(sql);

            ps.setInt(1, sender);
            ps.setInt(2, receiver);
            ps.setString(3, content);

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

    public List<Message> getListMessage(int sender, int receiver) {
        List<Message> list = null;
        try {
            String sql = "SELECT SQL_CALC_FOUND_ROWS tbl_messages.*,tbl_users.avatar,tbl_users.name FROM tbl_messages INNER JOIN `tbl_users` ON `sentId` = `uId` WHERE (sentId = ? AND receiveId = ? and sDeleted=false) OR (sentId = ? AND receiveId = ? and rDeleted=false)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, sender);
            ps.setInt(2, receiver);
            ps.setInt(3, receiver);
            ps.setInt(4, sender);

            rs = ps.executeQuery();
            if (rs != null) {
                list = new ArrayList<Message>();
                Message m = null;
                while (rs.next()) {
                    m = new Message();
                    m.setmId(rs.getInt("mId"));
                    m.setSentId(rs.getInt("sentId"));
                    m.setReceiveId(rs.getInt("receiveId"));
                    m.setContent(rs.getString("content"));
                    m.setTime(rs.getTimestamp("time"));
                    m.setsDeleted(rs.getBoolean("sDeleted"));
                    m.setrDeleted(rs.getBoolean("rDeleted"));
                    m.setsAvatar(rs.getString("avatar"));
                    m.setsName(rs.getString("name"));
                    list.add(m);
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
    
    public boolean editMessage(int mId, String content) {
        boolean result = false;
        try {
            String sql = "UPDATE tbl_messages SET content = ? WHERE mId = ?";
            ps = conn.prepareStatement(sql);

            ps.setString(1, content);
            ps.setInt(2, mId);

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

    public boolean deleteMessage(int mId, int userId) {
        boolean result = false;
        try {
            String sql = "SELECT * FROM tbl_messages WHERE mId=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, mId);
            rs = ps.executeQuery();
            if (rs != null) {
                while (rs.next()) {
                    sender = rs.getInt("sentId");
                    receiver = rs.getInt("receiveId");
                }
                rs.close();

                if (sender == userId) {
                    String sqld = "UPDATE tbl_messages SET sDeleted = true WHERE mId = ?";
                    ps = conn.prepareStatement(sqld);
                    ps.setInt(1, mId);
                    if (ps.executeUpdate() > 0) {
                        result = true;
                    } else {
                        result = false;
                    }
                }else{
                    String sqld = "UPDATE tbl_messages SET rDeleted = true WHERE mId = ?";
                    ps = conn.prepareStatement(sqld);
                    ps.setInt(1, mId);
                    if (ps.executeUpdate() > 0) {
                        result = true;
                    } else {
                        result = false;
                    }
                }

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
