<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.smartfarming.model.DashboardStats" %>
<%@ page import="com.smartfarming.model.Alert" %>
<%@ page import="com.smartfarming.model.User" %>
<%@ page import="java.util.List" %>
<%

    DashboardStats stats = (DashboardStats) request.getAttribute("stats");
    List<Alert> recentAlerts = (List<Alert>) request.getAttribute("recentAlerts");
    User loggedUser = (User) session.getAttribute("loggedUser");


    if(stats == null) {
        stats = new DashboardStats(0, 0, 0, 0);
    }
%>
<html>
<head>
    <title>Admin Dashboard - Smart Farming</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark">
        <div class="container-fluid">
            <span class="navbar-brand mb-0 h1"><i class="fa-solid fa-leaf me-2"></i>Smart Farming Admin Panel</span>
            <div class="d-flex align-items-center">
                <span class="text-white me-3">Welcome, <%= (loggedUser != null) ? loggedUser.getName() : "Admin" %></span>
                <a href="../logout" class="btn btn-outline-danger btn-sm">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">Dashboard Overview</h2>

        <div class="row text-white text-center mb-5">
            <div class="col-md-3 mb-3">
                <div class="card bg-primary shadow-sm h-100 py-3">
                    <div class="card-body">
                        <i class="fa-solid fa-users fa-2x mb-2"></i>
                        <h5 class="card-title">Total Users</h5>
                        <h2 class="display-6 fw-bold"><%= stats.getTotalUsers() %></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card bg-success shadow-sm h-100 py-3">
                    <div class="card-body">
                        <i class="fa-solid fa-tractor fa-2x mb-2"></i>
                        <h5 class="card-title">Total Farms</h5>
                        <h2 class="display-6 fw-bold"><%= stats.getTotalFarms() %></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card bg-warning shadow-sm h-100 py-3">
                    <div class="card-body">
                        <i class="fa-solid fa-microchip fa-2x mb-2"></i>
                        <h5 class="card-title">Total Sensors</h5>
                        <h2 class="display-6 fw-bold"><%= stats.getTotalSensors() %></h2>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card bg-danger shadow-sm h-100 py-3">
                    <div class="card-body">
                        <i class="fa-solid fa-triangle-exclamation fa-2x mb-2"></i>
                        <h5 class="card-title">Total Alerts</h5>
                        <h2 class="display-6 fw-bold"><%= stats.getTotalAlerts() %></h2>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-white fw-bold"><i class="fa-solid fa-bell me-2 text-danger"></i>Recent Alerts (Latest 5)</div>
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Message</th>
                                    <th>Severity</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if(recentAlerts != null && !recentAlerts.isEmpty()) {
                                        for(Alert alert : recentAlerts) {
                                            String badgeClass = "bg-secondary";
                                            if("CRITICAL".equalsIgnoreCase(alert.getSeverity())) badgeClass = "bg-danger";
                                            else if("WARNING".equalsIgnoreCase(alert.getSeverity())) badgeClass = "bg-warning text-dark";
                                            else if("INFO".equalsIgnoreCase(alert.getSeverity())) badgeClass = "bg-info text-dark";
                                %>
                                <tr>
                                    <td><%= alert.getMessage() %></td>
                                    <td><span class="badge <%= badgeClass %>"><%= alert.getSeverity() %></span></td>
                                    <td><small class="text-muted"><%= alert.getCreatedAt() %></small></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="3" class="text-center text-muted py-3">No recent alerts found.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-white fw-bold"><i class="fa-solid fa-bolt me-2 text-warning"></i>Quick Actions</div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="manage-farms.jsp" class="btn btn-outline-dark text-start"><i class="fa-solid fa-plus me-2"></i>Add Farm</a>
                            <a href="manage-sensors.jsp" class="btn btn-outline-dark text-start"><i class="fa-solid fa-plus me-2"></i>Add Sensor</a>
                            <a href="manage-alerts.jsp" class="btn btn-outline-dark text-start"><i class="fa-solid fa-eye me-2"></i>View Alerts</a>
                            <a href="reports.jsp" class="btn btn-outline-dark text-start"><i class="fa-solid fa-file-invoice me-2"></i>Generate Report</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>