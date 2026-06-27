package com.smartfarming.model;

public class DashboardStats {
    private int totalUsers;
    private int totalFarms;
    private int totalSensors;
    private int totalAlerts;

    // Constructors
    public DashboardStats() {}

    public DashboardStats(int totalUsers, int totalFarms, int totalSensors, int totalAlerts) {
        this.totalUsers = totalUsers;
        this.totalFarms = totalFarms;
        this.totalSensors = totalSensors;
        this.totalAlerts = totalAlerts;
    }

    // Getters & Setters
    public int getTotalUsers() { return totalUsers; }
    public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }

    public int getTotalFarms() { return totalFarms; }
    public void setTotalFarms(int totalFarms) { this.totalFarms = totalFarms; }

    public int getTotalSensors() { return totalSensors; }
    public void setTotalSensors(int totalSensors) { this.totalSensors = totalSensors; }

    public int getTotalAlerts() { return totalAlerts; }
    public void setTotalAlerts(int totalAlerts) { this.totalAlerts = totalAlerts; }
}