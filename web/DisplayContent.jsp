<%-- 
    Document   : DisplayContent
    Created on : Sep 23, 2018, 7:21:49 PM
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
            #content-details td{
                padding-right: 100px;
            }
            #nav-dropdown-container{display:none;}
            #nav-dropdown:hover #nav-dropdown-container{color:red;display:block}
        </style>
        <script type="text/javascript">
            function scrollToBody() {
                var elmnt = document.getElementById("details");
                elmnt.scrollIntoView();
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Content Details Section -->
        <c:if test="${Content_Details!=null}">
            <div id="details" class="w3-container w3-round w3-white w3-animate-top w3-padding-24" 
                 style="margin: 2%; display: inline-table">
                <h2>Content Details</h2>
                <table class="w3-table w3-bordered" id="content-details">
                    <tr>
                        <td><b>Title : </b></td>
                        <td>${Content_Details.title}</td>
                    </tr>
                    <tr>
                        <td><b>Description : </b></td>
                        <td>${Content_Details.desc}</td>
                    </tr>
                    <tr>
                        <td><b>Type : </b></td>
                        <td>${Content_Details.type}</td>
                    </tr>
                    <tr>
                        <td><b>Status : </b></td>
                        <c:choose>
                            <c:when test="${Content_Details.status == 'P' }">
                                <td>Pending</td>
                            </c:when>
                            <c:when test="${Content_Details.status == 'A'}">
                                <td>Approved</td>
                            </c:when>
                            <c:otherwise>
                                <td>Rejected</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                    <tr>
                        <td><b>Date Created : </b></td>
                        <td>${Content_Details.dateCreated}</td>
                    </tr>
                </table>
                <form action="" >
                    <div>
                        <input type="hidden" value="${Content_Details.cID}"/>
                        <a class="w3-button w3-round w3-text-black w3-teal w3-margin" href="${Content_Details.filePath}" 
                           download="${Content_Details.title}">Download</a>
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Remove"/>
                        
                        <c:choose>
                            <c:when test="${Content_Details.status == 'P' }">
                                <input class="w3-button w3-round w3-text-black w3-teal" type="submit" value="Approve"/>
                                <input class="w3-button w3-round w3-text-black w3-red" type="submit" value="Reject"/>
                            </c:when>
                            <c:when test="${Content_Details.status == 'A'}">
                                <input class="w3-button w3-round w3-text-black w3-red" type="submit" value="Reject"/>
                            </c:when>
                            <c:otherwise>
                                <input class="w3-button w3-round w3-text-black w3-green" type="submit" value="Approve"/>
                            </c:otherwise>
                        </c:choose>
                    </div> 
                </form>
            </div>

            <div class="w3-container w3-round w3-white w3-animate-top" 
                 style="margin: 2%;">
                <object data="${Content_Details.filePath}" type="text/html" 
                        class="w3-container w3-round w3-animate-top w3-margin"
                        style="width:100%; height:500px;">
                    <embed src="${Content_Details.filePath}" type="text/html"   />
                </object>
            </div>


        </c:if>
        <!-- User Details Section End -->

        
        
        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>


    </body>
</html>

