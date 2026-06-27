package com.smartfarming.service;

import com.smartfarming.dao.DashboardDAO;
import com.smartfarming.model.Alert;
import com.smartfarming.model.DashboardStats;
import java.util.List;

public class DashboardService {
    private DashboardDAO dashboardDAO = new DashboardDAO();

    public DashboardStats getDashboardStatistics() {
        int users = dashboardDAO.countUsers();
        int farms = dashboardDAO.countFarms();
        int sensors = dashboardDAO.countSensors();
        int alerts = dashboardDAO.countAlerts();


        return new DashboardStats(users, farms, sensors, alerts);
    }

    public List<Alert> getRecentAlerts() {
        return dashboardDAO.getRecentAlerts();
    }
}