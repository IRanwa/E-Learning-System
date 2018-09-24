<%-- 
    Document   : Header
    Created on : Sep 24, 2018, 1:56:56 PM
    Author     : Imesh Ranawaka
--%>


<%@page import="Model.Login"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% String title = pageContext.getServletContext().getInitParameter("Webpage-Title");%>
<%
    Login login = (Login) session.getAttribute("user");
%>
<!-- Navbar (sit on top) -->
<div class="w3-top">
    <div class="w3-bar w3-white w3-padding w3-card" style="letter-spacing:4px;">
        <!--Homepage redirection according to the user type -->
        <% if (login != null) {%>
        <% if (login.getRegType().equals("Admin")) {%>
        <a href="Admin_HomePage.jsp" class="w3-bar-item w3-button"><%= title%></a>
        <% } else if (login.getRegType().equals("Teacher")) {%>
        <a href="Teacher_HomePage.jsp" class="w3-bar-item w3-button"><%= title%></a>
        <% } else if (login.getRegType().equals("Student")) {%>
        <a href="#" class="w3-bar-item w3-button"><%= title%></a>
        <% }%>
        <% } else {%>
        <a href="index.jsp" class="w3-bar-item w3-button"><%= title%></a>
        <% } %>

        <!-- Right-sided navbar links. Hide them on small screens -->

        <div class="w3-right w3-hide-small">
            <a href="index.jsp#aboutUs" class="w3-bar-item w3-button">About</a>
            <a href="#menu" class="w3-bar-item w3-button">Contact</a>
            <% if (login != null) { %>
            <a href="LogoutServlet" class="w3-bar-item w3-button">Logout</a>
            <% } else { %>
            <a href="Registration.jsp#registration" class="w3-bar-item w3-button">Registration</a>
            <a href="Login.jsp#login" class="w3-bar-item w3-button">Login</a>
            <% } %>
        </div>

        <% if (login != null) {%>
            <% if (login.getRegType().equals("Manager")) { %>
            <div class="w3-right w3-hide-small" id="nav-dropdown" >
                <a href="UserServlet?User=View-User" class="w3-bar-item w3-button" >User</a>
                <div id="nav-dropdown-container" class="w3-white w3-card" 
                     style="position:absolute; margin-top:35px; width:120px">
                    <a href="UserServlet?User=Add-User" class="w3-bar-item w3-button">
                        Add User
                    </a>
                    <a href="UserServlet?User=Remove-User" class="w3-bar-item w3-button">
                        Remove User
                    </a>
                    <a href="UserServlet?User=Update-User" class="w3-bar-item w3-button">
                        Update User
                    </a>
                    <a href="UserServlet?User=View-User" class="w3-bar-item w3-button">
                        View User
                    </a>
                </div>
            </div>
            <% } %>

            <div class="w3-right w3-hide-small" id="nav-dropdown" >
                <a href="ContentServlet?Content=View-Content" class="w3-bar-item w3-button" >Content</a>
                <div id="nav-dropdown-container" class="w3-white w3-card" 
                     style="position:absolute; margin-top:35px; width:120px">
                    <% if (login.getRegType().equals("Teacher")) { %>
                    <a href="ContentServlet?Content=Add-Content" class="w3-bar-item w3-button">
                        Add Content
                    </a>
                    <% } %>
                    <% if (!login.getRegType().equals("Student")) { %>
                    <a href="ContentServlet?Content=Remove-Content" class="w3-bar-item w3-button">
                        Remove Content
                    </a>
                    <a href="ContentServlet?Content=Update-Content" class="w3-bar-item w3-button">
                        Update Content
                    </a>
                    <a href="ContentServlet?Content=View-Content" class="w3-bar-item w3-button">
                        View Content
                    </a>
                    <% } %>
                </div>
            </div>

            <% if (login.getRegType().equals("Admin") || login.getRegType().equals("Manager")) { %>
            <div class="w3-right w3-hide-small" id="nav-dropdown" >
                <a href="CategoryServlet?Category=View-Category" class="w3-bar-item w3-button" >Category</a>
                <div id="nav-dropdown-container" class="w3-white w3-card" 
                     style="position:absolute; margin-top:35px; width:120px">
                    <a href="CategoryServlet?Category=Add-Category" class="w3-bar-item w3-button">
                        Add Category
                    </a>
                    <a href="CategoryServlet?Category=Remove-Category" class="w3-bar-item w3-button">
                        Remove Category
                    </a>
                    <a href="CategoryServlet?Category=Update-Category" class="w3-bar-item w3-button">
                        Update Category
                    </a>
                    <a href="CategoryServlet?Category=View-Category" class="w3-bar-item w3-button">
                        View Category
                    </a>
                </div>
            </div>
            <% } %>

            <div class="w3-right w3-hide-small" id="nav-dropdown" >
                <a href="SubjectServlet?Subject=View-Subject" class="w3-bar-item w3-button" >Subject</a>
                <div id="nav-dropdown-container" class="w3-white w3-card" 
                     style="position:absolute; margin-top:35px; width:120px">
                    <% if (login.getRegType().equals("Admin") || login.getRegType().equals("Manager")) { %>
                    <a href="SubjectServlet?Subject=Add-Subject" class="w3-bar-item w3-button">
                        Add Subject
                    </a>
                    <a href="SubjectServlet?Subject=Remove-Subject" class="w3-bar-item w3-button">
                        Remove Subject
                    </a>
                    <a href="SubjectServlet?Subject=Update-Subject" class="w3-bar-item w3-button">
                        Update Subject
                    </a>
                    <% }%>
                    <% if (login.getRegType().equals("Teacher") || login.getRegType().equals("Student")) { %>
                    <a href="SubjectServlet?Subject=Enroll" class="w3-bar-item w3-button" style="width:100%">
                        Enroll
                    </a>
                    <a href="SubjectServlet?Subject=Un-Enroll" class="w3-bar-item w3-button">
                        Un-Enroll
                    </a>
                    <% }%>
                    <a href="SubjectServlet?Subject=View-Subject" class="w3-bar-item w3-button">
                        View Subject
                    </a>
                </div>
            </div>
        <% } %>
    </div>
</div>

<!-- Header -->
<header class="w3-display-container w3-content w3-wide" style="max-width:1600px;min-width:500px" id="home">
    <img class="w3-image" src="Images/e-learning%20(1).png" alt="Main Image" width="1600" height="800">
    <div class="w3-display-bottomleft w3-padding-large w3-opacity">
        <h1 class="w3-xxlarge"><%= title%></h1>
    </div>
</header>
