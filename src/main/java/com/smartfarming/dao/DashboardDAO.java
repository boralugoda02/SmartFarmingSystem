package com.smartfarming.dao;

import com.smartfarming.model.Alert;
import com.smartfarming.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {


    private int getCount(String query) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countUsers() { return getCount("SELECT COUNT(*) FROM users"); }
    public int countFarms() { return getCount("SELECT COUNT(*) FROM farms"); }
    public int countSensors() { return getCount("SELECT COUNT(*) FROM sensors"); }
    public int countAlerts() { return getCount("SELECT COUNT(*) FROM alerts"); }

    // STEP 9: Recent Alerts 5ක් ලබා ගැනීම
    public List<Alert> getRecentAlerts() {
        List<Alert> alerts = new ArrayList<>();
        String query = "SELECT * FROM alerts ORDER BY created_at DESC LIMIT 5";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Alert alert = new Alert();
                alert.setId(rs.getInt("id"));
                alert.setMessage(rs.getString("message"));
                alert.setSeverity(rs.getString("severity"));
                alert.setCreatedAt(rs.getString("created_at"));
                alerts.add(alert);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return alerts;
    }
}