<%-- 
    Document   : Admin_HomePage
    Created on : Aug 30, 2018, 1:16:42 PM
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
            Login login = (Login) session.getAttribute("user");
        %>
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

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
        <jsp:include page="Footer.jsp"/>


    </body>
</html>