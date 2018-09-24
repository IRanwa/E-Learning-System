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
                    <a href="ContentServlet?Content=View-Content" class="w3-bar-item w3-button" >Content</a>
                    <div id="nav-dropdown-container" class="w3-white w3-card" 
                         style="position:absolute; margin-top:35px; width:120px">
                        <a href="ContentServlet?Content=Add-Content" class="w3-bar-item w3-button">
                            Add Content
                        </a>
                        <a href="ContentServlet?Content=Remove-Content" class="w3-bar-item w3-button">
                            Remove Content
                        </a>
                        <a href="ContentServlet?Content=Update-Content" class="w3-bar-item w3-button">
                            Update Content
                        </a>
                        <a href="ContentServlet?Content=View-Content" class="w3-bar-item w3-button">
                            View Content
                        </a>
                    </div>
                </div>

                <div class="w3-right w3-hide-small" id="nav-dropdown" >
                    <a href="SubjectServlet?Subject=Enroll" class="w3-bar-item w3-button" >Subject</a>
                    <div id="nav-dropdown-container" class="w3-white w3-card" 
                         style="position:absolute; margin-top:35px; width:130px">
                        <a href="SubjectServlet?Subject=Enroll" class="w3-bar-item w3-button" style="width:100%">
                            Enroll
                        </a>
                        <a href="SubjectServlet?Subject=Un-Enroll" class="w3-bar-item w3-button">
                            Un-Enroll
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Nav Bar End -->

        <!-- Header -->
        <header class="w3-display-container w3-content w3-wide" style="max-width:1600px;min-width:500px" id="home">
            <img class="w3-image" src="Images/e-learning%20(1).png" alt="Main Image" width="1600" height="800">
            <div class="w3-display-bottomleft w3-padding-large w3-opacity">
                <h1 class="w3-xxlarge"><%= title%></h1>
            </div>
        </header>
        <!-- Header End -->

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
        <footer class="w3-center w3-light-grey w3-padding-32">
            <label>Copyright &#169; 2018 <%= title%>. All rights reserved.</label>
        </footer>


    </body>
</html>

