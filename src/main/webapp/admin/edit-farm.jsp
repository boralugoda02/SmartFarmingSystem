<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.smartfarming.model.Farm" %>
<%@ page import="com.smartfarming.model.User" %>
<%
    // Session Protection
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null || !"Admin".equalsIgnoreCase(loggedUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Farm farm = (Farm) request.getAttribute("farm");
    if (farm == null) {
        response.sendRedirect("../FarmServlet?action=list");
        return;
    }
%>
<html>
<head>
    <title>Edit Farm - Smart Farming</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; padding: 20px; }
        .container { max-width: 500px; background: white; padding: 20px; margin: auto; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"] { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn { background-color: #3498db; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; }
        .btn:hover { background-color: #2980b9; }
        .btn-cancel { background-color: #95a5a6; color: white; text-decoration: none; padding: 10px 15px; border-radius: 4px; margin-left: 10px; display: inline-block; }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit Farm Details</h2>
    <hr><br>

    <form action="../FarmServlet" method="POST">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="farmId" value="<%= farm.getFarmId() %>">

        <div class="form-group">
            <label>Farm Name:</label>
            <input type="text" name="farmName" value="<%= farm.getFarmName() %>" required>
        </div>

        <div class="form-group">
            <label>Location:</label>
            <input type="text" name="location" value="<%= farm.getLocation() %>" required>
        </div>

        <div class="form-group">
            <label>Owner ID:</label>
            <input type="text" name="ownerId" value="<%= farm.getOwnerId() %>" required>
        </div>

        <button type="submit" class="btn">Update Farm</button>
        <a href="../FarmServlet?action=list" class="btn-cancel">Cancel</a>
    </form>
</div>

</body>
</html>