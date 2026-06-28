<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smartfarming.model.Farm" %>
<%@ page import="com.smartfarming.model.User" %>
<%
    // 💡 Session Protection සහ Admin Authorization
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null || !"Admin".equalsIgnoreCase(loggedUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    List<Farm> farmList = (List<Farm>) request.getAttribute("farmList");
%>
<html>
<head>
    <title>Farm Management - Smart Farming</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; }
        .container { max-width: 900px; background: white; padding: 20px; margin: auto; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"] { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { background-color: #2ecc71; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #27ae60; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #34495e; color: white; }
        .btn-edit { background-color: #3498db; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 14px; margin-right: 5px; }
        .btn-delete { background-color: #e74c3c; color: white; padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 14px; }
        .search-container { margin-bottom: 20px; display: flex; gap: 10px; }
        .search-input { flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
    </style>
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete this farm?");
        }

        // 💡 Client-side Search Functionality (පහසුවෙන් ලිස්ට් එක සෙවීම සඳහා)
        function filterFarms() {
            let input = document.getElementById('searchBar').value.toLowerCase();
            let rows = document.querySelectorAll('tbody tr');

            rows.forEach(row => {
                let text = row.innerText.toLowerCase();
                if(text.includes(input)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
    </script>
</head>
<body>

<div class="container">
    <h2>Farm Management (Admin Panel)</h2>
    <a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp" style="text-decoration: none; color: #3498db;">← Back to Dashboard</a>
    <hr>

    <h3>Search Farms</h3>
    <div class="search-container">
        <input type="text" id="searchBar" onkeyup="filterFarms()" placeholder="Search by name, location or owner ID..." class="search-input">
    </div>

    <br><hr>

    <h3>Add New Farm</h3>
    <form action="../FarmServlet" method="POST">
        <input type="hidden" name="action" value="add">

        <div class="form-group">
            <label>Farm Name:</label>
            <input type="text" name="farmName" required>
        </div>
        <div class="form-group">
            <label>Location:</label>
            <input type="text" name="location" required>
        </div>
        <div class="form-group">
            <label>Owner (User ID):</label>
            <input type="text" name="ownerId" value="<%= loggedUser.getId() %>" readonly style="background-color: #eee; cursor: not-allowed;">
        </div>
        <button type="submit" class="btn">Add Farm</button>
    </form>

    <br><hr><br>

    <h3>Farm List</h3>
    <table>
        <thead>
            <tr>
                <th>Farm ID</th>
                <th>Farm Name</th>
                <th>Location</th>
                <th>Owner ID</th>
                <th>Created Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                if (farmList != null && !farmList.isEmpty()) {
                    for (Farm farm : farmList) {
            %>
            <tr>
                <td><%= farm.getFarmId() %></td>
                <td><%= farm.getFarmName() %></td>
                <td><%= farm.getLocation() %></td>
                <td><%= farm.getOwnerId() %></td>
                <td><%= farm.getCreatedAt() %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/FarmServlet?action=edit&farmId=<%= farm.getFarmId() %>" class="btn-edit">Edit</a>
                    <a href="${pageContext.request.contextPath}/FarmServlet?action=delete&farmId=<%= farm.getFarmId() %>" class="btn-delete" onclick="return confirmDelete()">Delete</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6" style="text-align: center;">No farms found.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>