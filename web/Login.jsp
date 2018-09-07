<%-- 
    Document   : Login
    Created on : Aug 29, 2018, 3:37:17 PM
    Author     : Imesh Ranawaka
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% String title = pageContext.getServletContext().getInitParameter("Webpage-Title"); %>
    <head>
        <title>Home Page (E-Learning)</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="CSS/style.css">
        <style>
            body {font-family: "Times New Roman", Georgia, Serif;}
            h1,h2,h3,h4,h5,h6 {
                font-family: "Playfair Display";
                letter-spacing: 5px;
            }
        </style>
    </head>
    <body class="w3-amber">

        <!-- Navbar (sit on top) -->
        <div class="w3-top">
            <div class="w3-bar w3-white w3-padding w3-card" style="letter-spacing:4px;">
                <a href="index.html" class="w3-bar-item w3-button"><%= title %></a>
                <!-- Right-sided navbar links. Hide them on small screens -->
                <div class="w3-right w3-hide-small">
                    <a href="index.html#aboutUs" class="w3-bar-item w3-button">About</a>
                    <a href="#menu" class="w3-bar-item w3-button">Contact</a>
                    <a href="#contact" class="w3-bar-item w3-button">Registration</a>
                    <a href="Login.jsp#login" class="w3-bar-item w3-button">Login</a>
                </div>
            </div>
        </div>

        <!-- Header -->
        <header class="w3-display-container w3-content w3-wide" style="max-width:1600px;min-width:500px" id="home">
            <img class="w3-image" src="Images/e-learning%20(1).png" alt="Main Image" width="1600" height="800">
            <div class="w3-display-bottomleft w3-padding-large w3-opacity">
                <h1 class="w3-xxlarge"><%= title %></h1>
            </div>
        </header>

        <!-- Display Error Message -->
        <c:if test="${display_error}">
            <div id="regerrormsg" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%; text-align: center;">
                <h4>${msg}</h4>
            </div>
        </c:if>
        <!-- Display Error Message End-->

        <!-- Login Section -->
        <form id="login" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
              style="max-width:400px; margin: 2% 35%" id="Registration" 
              action="LoginServlet" method="post">
            <div>
                <h2>Login</h2>
                <p style="color:red">Please fill in the form below.</p>
                <div>
                    <p><strong>User Name <font color="red">*</font></strong></p>
                    <input class="w3-input" type="text" name="UName" placeholder="User Name" required/>
                </div>
                <div>
                    <p><strong>Password <font color="red">*</font></strong></p>
                    <input class="w3-input" type="password" name="Pass" placeholder="Password" required/>
                </div>
                <div>
                    <input class="w3-button w3-text-black w3-round w3-teal w3-margin" type="submit" value="Submit"/>
                    <input class="w3-button w3-text-black w3-round w3-teal " type="reset" value="Reset"/>
                </div>
            </div>
        </form>
        <!--End Login Section -->


        <!-- Footer -->
        <footer class="w3-center w3-light-grey w3-padding-32">
            <p>Copyright © 2018 <%= title %>. All rights reserved.</p>
        </footer>

    </body>
</html>