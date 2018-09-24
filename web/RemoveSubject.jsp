<%-- 
    Document   : RemoveSubject
    Created on : Sep 8, 2018, 8:18:05 AM
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
            function viewSub() {
                var sID = document.getElementById("sub-selection").value;
                if (sID !== "") {
                    window.location = ("SubjectServlet?Subject=Remove-Subject&subjectID=" + sID);
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
            function scrollToBody() {
                var elmnt = document.getElementById("remove-subject");
                elmnt.scrollIntoView();
            }
            function removeSubBtnClick() {
                var modal = document.getElementById("popup-message");
                modal.style.display = "block";
                document.getElementById("sID").value = document.getElementById("sub-selection").value;
                return false;
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Successful Message -->
        <c:if test="${display_msg}">
            <div id="remove-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%; text-align: center;">
                <h1>${msg}</h1>
            </div>
        </c:if>
        <!-- Successful Message End -->

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="remove-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->

        <!-- Remove Subject Form -->
        <c:if test="${Subject_List!=null}">
            <form id="remove-subject" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:400px; margin: 2% 35%"
                  onsubmit="return removeSubBtnClick()" method="POST">
                <input type="hidden" name="command" value="remove-subject"/>
                <div>
                    <h2>Remove Subject</h2>
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
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Remove"/>
                        <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                    </div>
                </div>
            </form>
        </c:if>
        <!-- Remove Subject Form End -->

        <!-- Display Subject Details -->
        <c:if test="${displaySubDetails}">
            <div id="regerrormsg" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%">
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
            </div>
        </c:if>
        <!-- EDisplay Subject Details End -->

        <!-- Popup Confirm Box -->
        <div id="popup-message" class="popup-dialog">
            <form action="SubjectServlet" method="POST">
                <input type="hidden" name="command" value="remove-subject"/>
                <input type="hidden" id="sID" name="subjectSID" value=""/>
                <div class="w3-container w3-round w3-white w3-padding w3-animate-top" style="max-width:400px; margin: 1% 35%">
                    <span class="close" onclick="closePopup()">&times;</span>
                    <p class="w3-large">Are you sure you wish to remove the subject?</p>
                    <input class="w3-button w3-round w3-text-black w3-teal w3-margin-right" type="submit" value="Sure"/>
                    <input class="w3-button w3-round w3-text-black w3-teal " type="button" onclick="closePopup()" value="Close"/>
                </div>
            </form>
        </div>
        <!-- Popup Confirm Box  End -->

        <!-- Footer -->
        <jsp:include page="Footer.jsp"/>


    </body>
</html>
