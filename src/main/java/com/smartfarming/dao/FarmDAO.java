package com.smartfarming.dao;

import com.smartfarming.model.Farm;
import com.smartfarming.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FarmDAO {

    // 1. Add Farm
    public boolean addFarm(Farm farm) {
        String query = "INSERT INTO farms (farm_name, location, owner_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, farm.getFarmName());
            ps.setString(2, farm.getLocation());
            ps.setInt(3, farm.getOwnerId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Get All Farms
    public List<Farm> getAllFarms() {
        List<Farm> farms = new ArrayList<>();
        String query = "SELECT * FROM farms";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Farm farm = new Farm();
                farm.setFarmId(rs.getInt("farm_id"));
                farm.setFarmName(rs.getString("farm_name"));
                farm.setLocation(rs.getString("location"));
                farm.setOwnerId(rs.getInt("owner_id"));
                farm.setCreatedAt(rs.getTimestamp("created_at"));
                farms.add(farm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return farms;
    }

    // 3. Get Farm By ID
    public Farm getFarmById(int farmId) {
        String query = "SELECT * FROM farms WHERE farm_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, farmId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Farm farm = new Farm();
                    farm.setFarmId(rs.getInt("farm_id"));
                    farm.setFarmName(rs.getString("farm_name"));
                    farm.setLocation(rs.getString("location"));
                    farm.setOwnerId(rs.getInt("owner_id"));
                    farm.setCreatedAt(rs.getTimestamp("created_at"));
                    return farm;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Update Farm
    public boolean updateFarm(Farm farm) {
        String query = "UPDATE farms SET farm_name = ?, location = ?, owner_id = ? WHERE farm_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, farm.getFarmName());
            ps.setString(2, farm.getLocation());
            ps.setInt(3, farm.getOwnerId());
            ps.setInt(4, farm.getFarmId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Delete Farm
    public boolean deleteFarm(int farmId) {
        String query = "DELETE FROM farms WHERE farm_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, farmId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}