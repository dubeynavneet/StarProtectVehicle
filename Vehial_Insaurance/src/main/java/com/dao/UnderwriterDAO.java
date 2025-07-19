package com.dao;

import com.db.DBConnection;
import java.sql.*;

public class UnderwriterDAO {

    public boolean validate(String id, String password) {
        String query = "SELECT * FROM Underwriter WHERE id = ? AND password = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)
        ) {
            ps.setInt(1, Integer.parseInt(id)); // underwriterId is INTEGER
            ps.setString(2, password);          // password is TEXT

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // return true if record exists
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
