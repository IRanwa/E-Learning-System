<%-- 
    Document   : AddSubject
    Created on : Sep 7, 2018, 9:21:03 AM
    Author     : Imesh Ranawaka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <% String title = pageContext.getServletContext().getInitParameter("Webpage-Title");%>
    <head>
        <title>Home Page (<%= title%>)</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" type="text/css" href="CSS/style.css">
        <style>
            body {font-family: "Times New Roman", Georgia, Serif;}
            h1,h2,h3,h4,h5,h6 {
                font-family: "Playfair Display";
                letter-spacing: 5px;
            }

            #nav-subject-container{display:none;}
            #nav-subject:hover #nav-subject-container{color:red;display:block}
        </style>
        <script>
            function scrollToBody() {
                var elmnt = document.getElementById("add-subject");
                elmnt.scrollIntoView();
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">

        <!-- Navbar (sit on top) -->
        <div class="w3-top">
            <div class="w3-bar w3-white w3-padding w3-card" style="letter-spacing:4px;">
                <a href="index.html" class="w3-bar-item w3-button"><%= title%></a>
                <!-- Right-sided navbar links. Hide them on small screens -->

                <div class="w3-right w3-hide-small">
                    <a href="index.html#aboutUs" class="w3-bar-item w3-button">About</a>
                    <a href="#menu" class="w3-bar-item w3-button">Contact</a>
                    <a href="LogoutServlet" class="w3-bar-item w3-button">Logout</a>
                </div>

                <div class="w3-right w3-hide-small" id="nav-subject" >
                    <a href="CategoryServlet?Category=View-Category" class="w3-bar-item w3-button" >Category</a>
                    <div id="nav-subject-container" class="w3-white w3-card" 
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

                <div class="w3-right w3-hide-small" id="nav-subject" >
                    <a href="SubjectServlet?Subject=View-Subject" class="w3-bar-item w3-button" >Subject</a>
                    <div id="nav-subject-container" class="w3-white w3-card" 
                         style="position:absolute; margin-top:35px; width:120px">
                        <a href="SubjectServlet?Subject=Add-Subject" class="w3-bar-item w3-button">
                            Add Subject
                        </a>
                        <a href="SubjectServlet?Subject=Remove-Subject" class="w3-bar-item w3-button">
                            Remove Subject
                        </a>
                        <a href="SubjectServlet?Subject=Update-Subject" class="w3-bar-item w3-button">
                            Update Subject
                        </a>
                        <a href="SubjectServlet?Subject=View-Subject" class="w3-bar-item w3-button">
                            View Subject
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Header -->
        <header class="w3-display-container w3-content w3-wide" style="max-width:1600px;min-width:500px" id="home">
            <img class="w3-image" src="Images/e-learning%20(1).png" alt="Main Image" width="1600" height="800">
            <div class="w3-display-bottomleft w3-padding-large w3-opacity">
                <h1 class="w3-xxlarge"><%= title%></h1>
            </div>
        </header>

            <!-- Successful Message -->
            <c:if test="${display_msg}">
                <div id="add-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                     style="max-width:500px; margin: 1% 30%; text-align: center;">
                    <h1>${msg}</h1>
                </div>
            </c:if>
            <!-- Successful Message End -->

            <!-- Error Message -->
            <c:if test="${display_error}">
                <div id="add-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                     style="max-width:500px; margin: 1% 30%">
                    <p><font color="red">*</font> ${error_msg}</p>
                </div>
            </c:if>
            <!-- Error Message End -->

            <!-- Add Subject Form End -->
            <form id="add-subject" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%" id="add-subject" 
                  action="SubjectServlet" method="post">
                <input type="hidden" name="command" value="add-subject"/>
                <div>
                    <h2>Add Subject</h2>
                    <p style="color:red">Please fill in the form below.</p> 
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <input class="w3-input" type="text" name="STitle" placeholder="Subject Title" required/>
                    </div>
                    <div>
                        <p><strong>Subject Description <font color="red">*</font></strong></p>
                        <textarea class="w3-input w3-border-gray" style="border:1px solid" name="SDescription"  rows="3" placeholder="Subject Description" required></textarea>
                    </div>
                    <div>
                        <p><strong>Category Title <font color="red">*</font></strong></p>
                        <input class="w3-input" type="text" name="CTitle" placeholder="Category Title" required/>
                    </div>
                    <div>
                        <p><strong>Category Description <font color="red">*</font></strong></p>
                        <textarea class="w3-input w3-border-gray" style="border:1px solid" name="CDescription"  rows="3" placeholder="Category Description" required></textarea>
                    </div>
                    <div>
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Submit"/>
                        <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                    </div>  
                </div>
            </form>
            <!-- Add Subject Form -->
            
            
        <!-- Footer -->
        <footer class="w3-center w3-light-grey w3-padding-32">
            <label>Copyright &#169; 2018 <%= title%>. All rights reserved.</label>
        </footer>

    </body>
</html>
