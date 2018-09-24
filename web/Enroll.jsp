<%-- 
    Document   : EnrollSubject
    Created on : Sep 12, 2018, 9:20:30 AM
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

            #nav-dropdown-container{display:none;}
            #nav-dropdown:hover #nav-dropdown-container{color:red;display:block}
        </style>
        <script>
            function scrollToBody() {
                var elmnt = document.getElementById("enroll-subject");
                elmnt.scrollIntoView();
            }
            function viewSub() {
                var sID = document.getElementById("sub-selection").value;
                if (sID !== "") {
                    window.location = ("SubjectServlet?Subject=Enroll&subjectID=" + sID);
                }
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Successful Message -->
        <c:if test="${display_msg}">
            <div id="enroll-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%; text-align: center;">
                <h1>${msg}</h1>
            </div>
        </c:if>
        <!-- Successful Message End -->

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="enroll-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->

        <!-- Enroll Subject Form -->
        <c:if test="${Subject_List!=null}">
            <form id="enroll-subject" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:400px; margin: 2% 35%"
                  action="SubjectServlet" method="POST">
                <input type="hidden" name="command" value="enroll-subject"/>
                <div>
                    <h2>Enroll</h2>
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round" id="sub-selection" name="subjectID" required>
                            <option value=""></option>
                            <c:forEach var="Sub" items="${Subject_List}">
                                <c:choose>
                                    <c:when test="${displaySub.sID==Sub.sID}">
                                        <option value="${Sub.sID}" selected> ${Sub.sTitle}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${Sub.sID}" > ${Sub.sTitle}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </div>

                    <div>
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="button" value="View Details"
                               onclick="viewSub()"/>
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Enroll"/>
                        <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                    </div>
                </div>
            </form>
        </c:if>
        <!-- Enroll Subject Form End -->

        <!-- Display Subject & Category Details -->
        <c:if test="${displaySubDetails}">
            <div id="regerrormsg" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%">
                <table  class="w3-table w3-bordered">
                    <tr>
                        <th>Subject Title</th>
                        <th>Subject Description</th>
                    </tr>
                    <tr>
                        <td>${displaySub.sTitle}</td>
                        <td>${displaySub.sDes}</td>
                    </tr>
                </table>
                <table  class="w3-table w3-bordered">
                    <tr>
                        <th>Category Title</th>
                        <th>Category Description</th>
                    </tr>
                    <c:forEach var="cat" items="${Category_List}">
                        <tr>
                            <td>${cat.cTitle}</td>
                            <td>${cat.cDes}</td>
                        </tr>
                    </c:forEach>

                </table>
            </div>
        </c:if>
        <!-- Display Subject & Category Details End -->


        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>


    </body>
</html>

