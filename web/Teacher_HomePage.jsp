<%-- 
    Document   : Teacher_HomePage
    Created on : Sep 9, 2018, 6:24:03 PM
    Author     : Imesh Ranawaka
--%>

<%@page import="Model.Login"%>
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

            #nav-dropdown-container{display:none;}
            #nav-dropdown:hover #nav-dropdown-container{color:red;display:block}
        </style>
        <script type="text/javascript">
            function scrollToBody() {
                var elmnt = document.getElementById("welcome");
                elmnt.scrollIntoView();
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <%
            HttpSession sessions = request.getSession();
            Login login = (Login) session.getAttribute("user");
        %>
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

                <div class="w3-right w3-hide-small" id="nav-dropdown" >
                    <a href="ContentServlet?Content=View-Content" class="w3-bar-item w3-button" >Content</a>
                    <div id="nav-dropdown-container" class="w3-white w3-card" 
                         style="position:absolute; margin-top:35px; width:120px">
                        <a href="ContentServlet?Content=Add-Content" class="w3-bar-item w3-button">
                            Add Content
                        </a>
                        <a href="ContentServlet?Content=Remove-Content" class="w3-bar-item w3-button">
                            Remove Content
                        </a>
                        <a href="ContentServlet?Content=Update-Content" class="w3-bar-item w3-button">
                            Update Content
                        </a>
                        <a href="ContentServlet?Content=View-Content" class="w3-bar-item w3-button">
                            View Content
                        </a>
                    </div>
                </div>

                <div class="w3-right w3-hide-small" id="nav-dropdown" >
                    <a href="SubjectServlet?Subject=Enroll" class="w3-bar-item w3-button" >Subject</a>
                    <div id="nav-dropdown-container" class="w3-white w3-card" 
                         style="position:absolute; margin-top:35px; width:130px">
                        <a href="SubjectServlet?Subject=Enroll" class="w3-bar-item w3-button" style="width:100%">
                            Enroll
                        </a>
                        <a href="SubjectServlet?Subject=Un-Enroll" class="w3-bar-item w3-button">
                            Un-Enroll
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Nav Bar End -->

        <!-- Header -->
        <header class="w3-display-container w3-content w3-wide" style="max-width:1600px;min-width:500px" id="home">
            <img class="w3-image" src="Images/e-learning%20(1).png" alt="Main Image" width="1600" height="800">
            <div class="w3-display-bottomleft w3-padding-large w3-opacity">
                <h1 class="w3-xxlarge"><%= title%></h1>
            </div>
        </header>
        <!-- Header End -->

        <!-- User Details Section -->
        <div id="welcome" class="w3-container w3-round w3-white w3-animate-top" style="max-width:300px; margin: 2%">
            <h3>Welcome!</h3>
            <p style="margin:0"><%= login.getUname()%></p>
            <a href="#" style="text-decoration: none;">View Profile</a>
        </div>
        <!-- User Details Section End -->

        <!-- Approve Content Section -->
        <div class="w3-container w3-round w3-white w3-animate-top" style="max-width:100%; margin: 2%">
            <table class="w3-table w3-bordered">
                <tr>
                    <td>Subject</td>
                    <td>Category</td>
                    <td>Type</td>
                    <td>Sort By</td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <select name="subject" class="w3-round" style="width:75%">
                            <option value="all">All</option>
                            <c:forEach var="tempSub" items="${SubList}">
                                <option value="${tempSub}">${tempSub}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <select name="category" class="w3-round" style="width:75%">
                            <option value="all">All</option>
                            <c:forEach var="tempCat" items="${CatList}">
                                <option value="${tempCat}">${tempCat}</option>
                            </c:forEach>
                        </select>
                    </td>
                    <td>
                        <select name="type" class="w3-round" style="width:75%">
                            <option value="all">All</option>
                            <option value="lessons">Lessons</option>
                            <option value="test">Test</option>
                            <option value="tutorials">Tutorials</option>
                        </select>
                    </td>
                    <td>
                        <select name="sortBy" class="w3-round" style="width:75%">
                            <option value="default"></option>
                            <option value="By Name A-Z">By Name : A-Z</option>
                            <option value="By Name Z-A">By Name : Z-A</option>
                            <option value="By Date Newest">By Date : Newest</option>
                            <option value="By Date Oldest">By Date : oldest</option>
                            <option value="By Status Approved">By Status : Approved</option>
                            <option value="By Status Rejected">By Status : Rejected</option>
                            <option value="By Status Waiting">By Status : Waiting</option>
                        </select>
                    </td>
                    <td>
                        <button class="w3-round w3-button w3-cyan" style="width:50%; padding: 2%" onclick="" >Search</button>
                    </td>
                </tr>
            </table>
            <hr>
        </div>
        <!-- Approve Content Section End -->


        <!-- Footer -->
        <footer class="w3-center w3-light-grey w3-padding-32">
            <label>Copyright &#169; 2018 <%= title%>. All rights reserved.</label>
        </footer>


    </body>
</html>