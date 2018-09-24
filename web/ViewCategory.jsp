<%-- 
    Document   : ViewCategory
    Created on : Sep 9, 2018, 1:12:33 PM
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
                var elmnt = document.getElementById("view-category");
                elmnt.scrollIntoView();
            }

            function getCategory() {
                var sID = document.getElementById("sub-selection").value;
                if (sID !== "") {
                    window.location = ("CategoryServlet?Category=View-Category&subjectID=" + sID);
                }
            }
            function displayCatDetails() {
                var sID = document.getElementById("sub-selection").value;
                var cID = document.getElementById("cat-selection").value;
                if (sID !== "" && cID !== "") {
                    window.location = ("CategoryServlet?Category=View-Category&subjectID=" + sID +
                            "&categoryID=" + cID);
                }
            }
            function resetUpdateForm() {
                document.getElementById("catTitle").value = "";
                document.getElementById("catDesc").value = "";
            }


        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="view-category" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->


        <!-- Remove Category Form -->
        <c:if test="${Subject_List!=null}">
            <form id="view-category" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%" id="add-subject" 
                  action="CategoryServlet" method="post">
                <input type="hidden" name="command" value="view-category"/>
                <div>
                    <h2>View Category</h2>
                    <p style="color:red">Please fill in the form below.</p> 
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round" id="sub-selection" name="subjectID" required
                                onchange="getCategory()">
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
                    <c:if test="${Category_List!=null}">
                        <div>
                            <p><strong>Category Title <font color="red">*</font></strong></p>
                            <select class="w3-select w3-round" id="cat-selection" name="categoryID" required>
                                <option value="All">All Categories</option>
                                <c:forEach var="Cat" items="${Category_List}">
                                    <c:choose>
                                        <c:when test="${displayCat.cID==Cat.cID}">
                                            <option value="${Cat.cID}" selected> ${Cat.cTitle}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${Cat.cID}" > ${Cat.cTitle}</option>
                                        </c:otherwise>
                                    </c:choose>

                                </c:forEach>
                            </select>
                        </div> 
                        <div>
                            <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Submit"/>
                            <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                        </div>
                    </c:if>
                </div>
            </form>
        </c:if>
        <!-- Remove Category Form End -->

        <!-- Update Subject Details -->
        <c:if test="${Category_List!=null}">
            <div class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:60%; margin: 1% 20%">
                <h3>Subject Details</h3>
                <table  class="w3-table w3-bordered">
                    <tr>
                        <th>Subject ID</th>
                        <th>Subject Title</th>
                        <th>Subject Description</th>
                    </tr>
                    <tr>
                        <td>${displaySub.sID}</td>
                        <td>${displaySub.sTitle}</td>
                        <td>${displaySub.sDes}</td>
                    </tr>
                </table>

                <hr>
                <h3>Category Details</h3>
                <table  class="w3-table w3-bordered">
                    <tr>
                        <th>Category ID</th>
                        <th>Category Title</th>
                        <th>Category Description</th>
                    </tr>
                    <c:choose>
                        <c:when test="${displayCat!=null    }">
                            <tr>
                                <td>${displayCat.cID}</td>
                                <td>${displayCat.cTitle}</td>
                                <td>${displayCat.cDes}</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="Cat" items="${Category_List}">
                                <tr>
                                    <td>${Cat.cID}</td>
                                    <td>${Cat.cTitle}</td>
                                    <td>${Cat.cDes}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </table>
            </div>
        </c:if>
        <!-- Update Subject Details End -->

        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>

    </body>
</html>



