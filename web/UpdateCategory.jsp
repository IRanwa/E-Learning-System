<%-- 
    Document   : UpdateCategory
    Created on : Sep 9, 2018, 11:15:33 AM
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
                var elmnt = document.getElementById("update-category");
                elmnt.scrollIntoView();
            }

            function getCategory() {
                var sID = document.getElementById("sub-selection").value;
                if (sID !== "") {
                    window.location = ("CategoryServlet?Category=Update-Category&subjectID=" + sID);
                }
            }
            function displayCatDetails() {
                var sID = document.getElementById("sub-selection").value;
                var cID = document.getElementById("cat-selection").value;
                if (sID !== "" && cID !== "") {
                    window.location = ("CategoryServlet?Category=Update-Category&subjectID=" + sID +
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

        <!-- Successful Message -->
        <c:if test="${display_msg}">
            <div id="update-category" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%; text-align: center;">
                <h1>${msg}</h1>
            </div>
        </c:if>
        <!-- Successful Message End -->

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="update-category" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->


        <!-- Remove Category Form -->
        <c:if test="${Subject_List!=null}">
            <form id="update-category" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%" id="add-subject" 
                  action="CategoryServlet" method="post">
                <input type="hidden" name="command" value="update-category"/>
                <div>
                    <h2>Update Category</h2>
                    <p style="color:red">Please fill in the form below.</p> 
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round" id="sub-selection" name="SID" required
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
                            <select class="w3-select w3-round" id="cat-selection" name="CID" required
                                    onchange="displayCatDetails()">
                                <option value=""></option>
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
                    </c:if>
                </div>
            </form>
        </c:if>
        <!-- Remove Category Form End -->

        <!-- Update Subject Details -->
        <c:if test="${displayCat!=null}">
            <form class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%"
                  action="CategoryServlet" method="post">
                <input type="hidden" name="command" value="update-category"/>
                <input type="hidden" name="categoryCID" value="${displayCat.cID}"/>
                <div>
                    <p style="color:red">Please fill in the form below.</p> 
                    <div>
                        <p><strong>Category Title <font color="red">*</font></strong></p>
                        <input class="w3-input" type="text" id="catTitle" name="CTitle" value="${displayCat.cTitle}" placeholder="Category Title" required/>
                    </div>
                    <div>
                        <p><strong>Category Description <font color="red">*</font></strong></p>
                        <textarea id="catDesc" class="w3-input w3-border-gray" style="border:1px solid" rows="3" name="CDescription" placeholder="Category Description" required>${displayCat.cDes}</textarea>
                    </div>
                    <div>
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Update"/>
                        <input class="w3-button w3-round w3-text-black w3-teal " type="button" value="Reset" onclick="resetUpdateForm()"/>
                    </div>  
                </div>
            </form>
        </c:if>
        <!-- Update Subject Details End -->

        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>

    </body>
</html>


