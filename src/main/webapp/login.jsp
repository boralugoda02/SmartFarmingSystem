<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Smart Farming</title>
</head>
<body>
    <h2>Login</h2>

    <% if(request.getParameter("success") != null) { %>
        <p style="color:green;"><%= request.getParameter("success") %></p>
    <% } %>
    <% if(request.getParameter("error") != null) { %>
        <p style="color:red;"><%= request.getParameter("error") %></p>
    <% } %>

    <form action="login" method="post">
        <label>Email:</label><br>
        <input type="email" name="email" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button type="submit">Login</button>
    </form>
    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
</body>
</html>