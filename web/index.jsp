<%-- 
    Document   : index
    Created on : Sep 24, 2018, 1:47:44 PM
    Author     : Imesh Ranawaka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
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
            #nav-dropdown-container{display:none;}
            #nav-dropdown:hover #nav-dropdown-container{color:red;display:block}
        </style>
    </head>
    <body class="w3-amber">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Page content -->
        <div class="w3-content" style="max-width:1100px;">

            <!-- About Section -->
            <div class="w3-row w3-padding-64" id="about">
                <div class="w3-col m6 w3-padding-large w3-hide-small w3-animate-left">
                    <img src="Images/logo.jpg" class="w3-round w3-image " alt="About Us" width="600" height="750">
                </div>

                <div id="aboutUs" class="w3-col m6 w3-padding-large">
                    <h1 class="w3-center">About Us</h1><br>
                    <p class="w3-large">
                        E-Learning Sri Lanka is a place where Ordinary Level students can gain more learning outcome from different subject areas. On this website first, the user needs to Register as a Student or a Contributor (Teacher). As a student, they can view lessons, tests, and tutorials on a specific to a particular subject. Also, As a teacher, they can add lessons, tests, and tutorials on a specific subject.
                    </p>
                </div>
            </div>
            <!-- End page content -->
        </div>

        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>

    </body>
</html>
