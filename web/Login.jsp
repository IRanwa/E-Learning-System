<%-- 
    Document   : Login
    Created on : Aug 29, 2018, 3:37:17 PM
    Author     : Imesh Ranawaka
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% String title = pageContext.getServletContext().getInitParameter("Webpage-Title");%>
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
        <script>
            function scrollToBody() {
                var elmnt = document.getElementById("login");
                elmnt.scrollIntoView();
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Display Error Message -->
        <c:if test="${display_error}">
            <div id="login" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
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
        <jsp:include page="Footer.jsp"/>

    </body>
</html>