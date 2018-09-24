<%-- 
    Document   : AddCategory
    Created on : Sep 9, 2018, 7:50:42 AM
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
                var elmnt = document.getElementById("add-category");
                elmnt.scrollIntoView();
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Successful Message -->
        <c:if test="${display_msg}">
            <div id="add-category" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%; text-align: center;">
                <h1>${msg}</h1>
            </div>
        </c:if>
        <!-- Successful Message End -->

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="add-category" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->


        <!-- Add Category Form -->
        <c:if test="${Subject_List!=null}">
            <form id="add-category" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%" id="add-subject" 
                  action="CategoryServlet" method="post">
                <input type="hidden" name="command" value="add-category"/>
                <div>
                    <h2>Add Category</h2>
                    <p style="color:red">Please fill in the form below.</p> 
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round" id="sub-selection" name="SID" required>
                            <option value=""></option>
                            <c:forEach var="Sub" items="${Subject_List}">
                                <option value="${Sub.sID}" > ${Sub.sTitle}</option>
                            </c:forEach>
                        </select>
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
        </c:if>
        <!-- Add Category Form End -->


        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>

    </body>
</html>

