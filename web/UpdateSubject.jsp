<%-- 
    Document   : UpdateSubject
    Created on : Sep 8, 2018, 11:02:22 PM
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
                var elmnt = document.getElementById("update-subject");
                elmnt.scrollIntoView();
            }
            function updateSubBtnClick() {
                var sID = document.getElementById("sub-selection").value;
                if (sID !== "") {
                    window.location = ("SubjectServlet?Subject=Update-Subject&subjectID=" + sID);
                }
                return false;
            }
            function resetUpdateForm() {
                document.getElementById("subTitle").value = "";
                document.getElementById("subDesc").value = "";
            }
        </script>
    </head>
    <body class="w3-amber" onload="scrollToBody();">
        <!-- Header & Nav Bar -->
        <jsp:include page="Header.jsp"/>

        <!-- Successful Message -->
        <c:if test="${display_msg}">
            <div id="update-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%; text-align: center;">
                <h1>${msg}</h1>
            </div>
        </c:if>
        <!-- Successful Message End -->

        <!-- Error Message -->
        <c:if test="${display_error}">
            <div id="update-subject" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
                 style="max-width:400px; margin: 1% 35%">
                <p><font color="red">*</font> ${error_msg}</p>
            </div>
        </c:if>
        <!-- Error Message End -->

        <!-- Update Subject Form -->
        <c:if test="${Subject_List!=null}">
            <form id="update-subject" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:400px; margin: 2% 35%"
                  onsubmit="return updateSubBtnClick()" method="POST">
                <input type="hidden" name="command" value="update-subject"/>
                <div>
                    <h2>Update Subject</h2>
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
                        <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Submit"/>
                        <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
                    </div>
                </div>
            </form>
        </c:if>
        <!-- Update Subject Form End -->

        <!-- Update Subject Details -->
        <c:if test="${displaySubDetails}">
            <form class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
                  style="max-width:500px; margin: 2% 30%"
                  action="SubjectServlet" method="post">
                <input type="hidden" name="command" value="update-subject"/>
                <input type="hidden" name="subjectSID" value="${displaySub.sID}"/>
                <div>
                    <p style="color:red">Please fill in the form below.</p> 
                    <div>
                        <p><strong>Subject Title <font color="red">*</font></strong></p>
                        <input class="w3-input" type="text" id="subTitle" name="STitle" value="${displaySub.sTitle}" placeholder="Subject Title" required/>
                    </div>
                    <div>
                        <p><strong>Subject Description <font color="red">*</font></strong></p>
                        <textarea id="subDesc" class="w3-input w3-border-gray" style="border:1px solid" rows="3" name="SDescription" placeholder="Subject Description" required>${displaySub.sDes}</textarea>
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

