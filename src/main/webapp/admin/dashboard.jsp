<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.smartfarming.model.User" %>
<%
    // Session Protection & Admin Authorization
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    if (!"Admin".equalsIgnoreCase(loggedUser.getRole())) {
        out.println("Access Denied: Only Admins can view this dashboard.");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Smart Farming</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background-color: #f4f7f6; }
        .navbar { background-color: #2c3e50; color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h1 { margin: 0; font-size: 20px; }
        .logout-btn { background-color: #e74c3c; color: white; padding: 8px 15px; text-decoration: none; border-radius: 4px; font-size: 14px; }

        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .welcome-text { font-size: 24px; color: #333; margin-bottom: 20px; }

        /* Stats Cards Line */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .card { color: white; padding: 25px; border-radius: 8px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .card-users { background-color: #007bff; }
        .card-farms { background-color: #28a745; }
        .card-sensors { background-color: #ffc107; color: #333; }
        .card-alerts { background-color: #dc3545; }
        .card h3 { margin: 0 0 10px 0; font-size: 18px; }
        .card .value { font-size: 36px; font-weight: bold; }

        /* Lower Layout */
        .dashboard-layout { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; }
        .panel { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .panel h3 { margin-top: 0; color: #333; border-bottom: 2px solid #eee; padding-bottom: 10px; }

        /* Table */
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f8f9fa; color: #555; }

        /* Quick Actions Buttons */
        .actions-list { display: flex; flex-direction: column; gap: 10px; margin-top: 15px; }
        .action-btn { display: block; padding: 12px; background: white; border: 1px solid #ddd; border-radius: 6px; text-decoration: none; color: #333; font-weight: bold; transition: all 0.2s; }
        .action-btn:hover { background-color: #f8f9fa; border-color: #b9b9b9; }
    </style>
</head>
<body>

    <div class="navbar">
        <h1> Smart Farming Admin Panel</h1>
        <div>
            <span style="margin-right: 15px;">Welcome, Admin</span>
            <a href="../LogoutServlet" class="logout-btn">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="welcome-text">Dashboard Overview</div>

        <div class="stats-grid">
            <div class="card card-users">
                <h3>Total Users</h3>
                <div class="value">1</div>
            </div>
            <div class="card card-farms">
                <h3>Total Farms</h3>
                <div class="value">0</div>
            </div>
            <div class="card card-sensors">
                <h3>Total Sensors</h3>
                <div class="value">0</div>
            </div>
            <div class="card card-alerts">
                <h3>Total Alerts</h3>
                <div class="value">0</div>
            </div>
        </div>

        <div class="dashboard-layout">
            <div class="panel">
                <h3> Recent Alerts (Latest 5)</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Message</th>
                            <th>Severity</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="3" style="text-align: center; color: #777; padding: 20px;">No recent alerts found.</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="panel">
                <h3>⚡ Quick Actions</h3>
                <div class="actions-list">
                    <a href="${pageContext.request.contextPath}/FarmServlet?action=list" class="action-btn"> Add Farm</a>
                    <a href="#" class="action-btn"> Add Sensor</a>
                    <a href="#" class="action-btn"> View Alerts</a>
                    <a href="#" class="action-btn"> Generate Report</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>