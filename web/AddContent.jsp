<%-- 
    Document   : AddContent
    Created on : Sep 13, 2018, 8:12:55 AM
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
                var elmnt = document.getElementById("add-content");
                elmnt.scrollIntoView();
            }
            function getCategory(){
                var sID = document.getElementById("sub-selection").value;
                if(sID !== ""){
                    window.location = ("ContentServlet?Content=Add-Content&subjectID=" + sID);
                }
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <%
            Login login = (Login) session.getAttribute("user");
        %>
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Successful Message -->
        <c:if test="${display_msg}">
            <div id="add-content" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%; text-align: center;">
                <h1>${msg}</h1>
            </div>
        </c:if>
        <!-- Successful Message End -->

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="add-content" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->

        <!-- Add Subject Form End -->
        <c:if test="${Subject_List!=null}">
            <form id="add-content" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%"
                  action="ContentServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="command" value="add-content"/>
                <div>
                    <h2>Add Content</h2>
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
                    <div>
                        <p><strong>Category Title <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round" name="CID" required>
                            <option value=""></option>
                            <c:forEach var="Cat" items="${Category_List}">
                                <option value="${Cat.cID}" > ${Cat.cTitle}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div>
                        <p><strong>Content Title <font color="red">*</font></strong></p>
                        <input class="w3-input" type="text" name="CTitle" placeholder="Content Title" required/>
                    </div>
                    <div>
                        <p><strong>Content Description <font color="red">*</font></strong></p>
                        <textarea class="w3-input w3-border-gray" style="border:1px solid" name="CDescription"  rows="3" placeholder="Content Description" required></textarea>
                    </div>
                    <div>
                        <p><strong>Content Type <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round" name="CType" required>
                            <option value=""></option>
                            <option value="Lessons">Lessons</option>
                            <option value="Test">Test</option>
                            <option value="Tutorials">Tutorials</option>
                        </select>
                    </div>
                    <div>
                        <p><strong>Select File <font color="red">*</font></strong></p>
                        <p style="font-weight: bold">Valid formats</p>
                        <ul>
                            <li>PDF</li>
                            <li>Text</li>
                            <li>Image</li>
                            <li>Audio</li>
                            <li>Video</li>
                        </ul>
                        
                        <input class="w3-input" type="file" name="CFile" required/>
                    </div>
                    <div>
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Submit"/>
                        <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                    </div> 
                </div>
            </form>
        </c:if>
        <!-- Add Subject Form -->


        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>

    </body>
</html>

