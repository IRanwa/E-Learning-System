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
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>
        
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
        <jsp:include page="Footer.jsp"/>
    </body>
</html>


