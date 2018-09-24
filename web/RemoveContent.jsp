<%-- 
    Document   : RemoveContent
    Created on : Sep 22, 2018, 10:18:22 AM
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

            .popup-dialog{
                display:none;
                position: fixed;
                z-index: 1;
                left:0;
                right:0;
                top:0;
                padding-top: 100px;
                height:100%;
                width:100%;
                overflow:auto;
                background-color: grey;
                background-color: rgba(0,0,0,0.5);
            }

            .close:hover,.close:focus{
                text-decoration: none;
                cursor: pointer;
                color: black;
            }
        </style>
        <script>
            function scrollToBody() {
                var elmnt = document.getElementById("remove-content");
                elmnt.scrollIntoView();
            }
            function getCategory() {
                var sID = document.getElementById("sub-selection").value;
                if (sID !== "") {
                    window.location = ("ContentServlet?Content=Remove-Content&subjectID=" + sID);
                }
            }
            function getContent() {
                var sID = document.getElementById("sub-selection").value;
                var cID = document.getElementById("cat-selection").value;
                var cIDSelected = document.getElementById("cat-selection").selected;
                if (sID !== "" && cID !== "" && cIDSelected !== cID) {
                    window.location = ("ContentServlet?Content=Remove-Content&subjectID=" + sID + "&categoryID=" + cID);
                }
            }
            function closePopup() {
                var modal = document.getElementById("popup-message");
                modal.style.display = "none";
            }
            window.onclick = function (event) {
                var modal = document.getElementById("popup-message");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };
            function removeConBtnClick() {
                var modal = document.getElementById("popup-message");
                modal.style.display = "block";
                document.getElementById("conID").value = document.getElementById("con-selection").value;

                return false;
            }
            function viewContent() {
                var cID = document.getElementById("con-selection").value;
                if (cID !== "") {
                    window.open("ContentServlet?Content=Remove-Content&contentID=" + cID);
                }
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <%
            Login login = (Login)session.getAttribute("user");
            session.setAttribute("user", login);
        %>
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Successful Message -->
        <c:if test="${display_msg}">
            <div id="remove-content" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%; text-align: center;">
                <h1>${msg}</h1>
            </div>
        </c:if>
        <!-- Successful Message End -->

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="remove-content" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:500px; margin: 1% 30%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->


        <!-- Remove Category Form -->
        <c:if test="${Subject_List!=null}">
            <form id="remove-content" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%" id="add-subject" 
                  onsubmit="return removeConBtnClick()" method="post">
                <input type="hidden" name="command" value="remove-content"/>
                <div>
                    <h2>Remove Content</h2>
                    <p style="color:red">Please fill in the form below.</p> 
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <select class="w3-select w3-round w3-padding-small" id="sub-selection" name="SID" required
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
                                    onchange="getContent()">
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
                    <c:if test="${Content_List!=null}">
                        <div>
                            <p><strong>Content Title <font color="red">*</font></strong></p>
                            <select class="w3-select w3-round" id="con-selection" name="ConID" required>
                                <option value=""></option>
                                <c:forEach var="Con" items="${Content_List}">
                                    <option value="${Con.cID}" > ${Con.title}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </c:if>
                    <div>
                        <c:if test="${Content_List!=null}">
                            <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="button" value="View Details"
                                   onclick="viewContent()"/>
                            <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Remove"/>
                            <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                        </c:if>
                    </div>
                </div>
            </form>
        </c:if>
        <!-- Remove Category Form End -->

        <!-- Popup Confirm Box -->
        <div id="popup-message" class="popup-dialog">
            <form action="ContentServlet" method="POST">
                <input type="hidden" name="command" value="remove-content"/>
                <input type="hidden" id="conID" name="contentID" value=""/>
                <div class="w3-container w3-round w3-white w3-padding w3-animate-top" style="max-width:400px; margin: 1% 35%">
                    <span class="close" onclick="closePopup()">&times;</span>
                    <p class="w3-large ">Are you sure you wish to remove the content?</p>
                    <input class="w3-button w3-round w3-text-black w3-teal w3-margin-right" type="submit" value="Sure"/>
                    <input class="w3-button w3-round w3-text-black w3-teal" type="button" onclick="closePopup()" value="Close"/>
                </div>
            </form>
        </div>
        <!-- Popup Confirm Box  End -->

        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>

    </body>
</html>



