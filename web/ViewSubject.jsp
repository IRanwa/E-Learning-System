<%-- 
    Document   : ViewSubject
    Created on : Sep 8, 2018, 11:49:27 PM
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
        <script>
            function scrollToBody() {
                var elmnt = document.getElementById("view-subject");
                elmnt.scrollIntoView();
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <%
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

                <div class="w3-right w3-hide-small" id="nav-dropdown" >
                    <a href="SubjectServlet?Subject=View-Subject" class="w3-bar-item w3-button" >Subject</a>
                    <div id="nav-dropdown-container" class="w3-white w3-card" 
                         style="position:absolute; margin-top:35px; width:120px">
                        <% if (login.getRegType().equals("Admin")) { %>
                        <a href="SubjectServlet?Subject=Add-Subject" class="w3-bar-item w3-button">
                            Add Subject
                        </a>
                        <a href="SubjectServlet?Subject=Remove-Subject" class="w3-bar-item w3-button">
                            Remove Subject
                        </a>
                        <a href="SubjectServlet?Subject=Update-Subject" class="w3-bar-item w3-button">
                            Update Subject
                        </a>
                        <% } else { %>
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
            </div>
        </div>

        <!-- Header -->
        <header class="w3-display-container w3-content w3-wide" style="max-width:1600px;min-width:500px" id="home">
            <img class="w3-image" src="Images/e-learning%20(1).png" alt="Main Image" width="1600" height="800">
            <div class="w3-display-bottomleft w3-padding-large w3-opacity">
                <h1 class="w3-xxlarge"><%= title%></h1>
            </div>
        </header>

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="view-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->

        <!-- View Subject Form -->
        <c:if test="${Subject_List!=null}">
            <form id="view-subject" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:400px; margin: 2% 35%"
                  submit="SubjectServlet" method="POST">
                <input type="hidden" name="command" value="view-subject"/>
                <div>
                    <h2>View Subject</h2>
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round" id="sub-selection" name="subjectID" required>
                            <option value="All">All Subjects</option>
                            <c:forEach var="Sub" items="${Subject_List}">
                                <option value="${Sub.sID}" > ${Sub.sTitle}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Submit"/>
                        <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                    </div>
                </div>
            </form>
        </c:if>
        <!-- View Subject Form End -->

        <!-- View Subject & Category Details -->
        <c:if test="${displaySubDetails}">
            <div class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:60%; margin: 1% 20%">
                <h3>Subject Details</h3>
                <table  class="w3-table w3-bordered">
                    <tr>
                        <th>Subject ID</th>
                        <th>Subject Title</th>
                        <th>Subject Description</th>
                        <% if (!login.getRegType().equals("Admin")) {%>
                            <th>Enroll Status</th>
                        <%}%>
                    </tr>
                    <c:choose>
                        <c:when test="${All_Subjects}">
                            <c:forEach var="sub" items="${Subject_List}">
                                <tr>
                                    <td>${sub.sID}</td>
                                    <td>${sub.sTitle}</td>
                                    <td>${sub.sDes}</td>
                                    <% if (!login.getRegType().equals("Admin")) {%>
                                        <c:if test="${sub.userEnroll}">
                                            <td class="w3-text-green">Enrolled</td>
                                        </c:if>
                                        <c:if test="${!sub.userEnroll}">
                                            <td class="w3-text-red">Not Enrolled</td>
                                        </c:if>
                                    <%}%>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td>${displaySub.sID}</td>
                                <td>${displaySub.sTitle}</td>
                                <td>${displaySub.sDes}</td>
                                <% if (!login.getRegType().equals("Admin")) {%>
                                <c:if test="${displaySub.userEnroll}">
                                    <td class="w3-text-green">Enrolled</td>
                                </c:if>
                                <c:if test="${!displaySub.userEnroll}">
                                    <td class="w3-text-red">Not Enrolled</td>
                                </c:if>
                                <%}%>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </table>

                <c:if test="${displayCatDetails}">
                    <hr>
                    <h3>Category Details</h3>
                    <table  class="w3-table w3-bordered">
                        <tr>
                            <th>Category ID</th>
                            <th>Category Title</th>
                            <th>Category Description</th>
                        </tr>
                        <c:forEach var="Cat" items="${Category_List}">
                            <tr>
                                <td>${Cat.cID}</td>
                                <td>${Cat.cTitle}</td>
                                <td>${Cat.cDes}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            </div>
        </c:if>
        <!-- View Subject & Category Details End -->

        <!-- Footer -->
        <jsp:include page="footer.jsp"/>
    </body>
</html>


