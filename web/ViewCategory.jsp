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
        <jsp:include page="footer.jsp"/>

    </body>
</html>



