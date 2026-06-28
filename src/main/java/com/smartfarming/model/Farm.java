package com.smartfarming.model;

import java.sql.Timestamp;

public class Farm {
    private int farmId;
    private String farmName;
    private String location;
    private int ownerId;
    private Timestamp createdAt;

    // Default Constructor
    public Farm() {}

    // Overloaded Constructor
    public Farm(String farmName, String location, int ownerId) {
        this.farmName = farmName;
        this.location = location;
        this.ownerId = ownerId;
    }

    // Getters and Setters
    public int getFarmId() { return farmId; }
    public void setFarmId(int farmId) { this.farmId = farmId; }

    public String getFarmName() { return farmName; }
    public void setFarmName(String farmName) { this.farmName = farmName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public int getOwnerId() { return ownerId; }
    public void setOwnerId(int ownerId) { this.ownerId = ownerId; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "Farm{" + "farmId=" + farmId + ", farmName='" + farmName + '\'' + ", location='" + location + '\'' + ", ownerId=" + ownerId + '}';
    }
}