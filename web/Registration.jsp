<%-- 
    Document   : Registration
    Created on : Aug 28, 2018, 7:06:26 PM
    Author     : Imesh Ranawaka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% String title = pageContext.getServletContext().getInitParameter("Webpage-Title");%>
    <head>
        <title>Home Page (E-Learning)</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="stylesheet" href="CSS/style.css">
        <style>
            body {font-family: "Times New Roman", Georgia, Serif;}
            h1,h2,h3,h4,h5,h6 {
                font-family: "Playfair Display";
                letter-spacing: 5px;
            }
        </style>
        <script>
    <script>
            function scrollToBody() {
               
                var elmnt = document.getElementById("registration");
            elmnt.scrollIntoView();
}
</script>
    </script>
</head>
<body class="w3-amber" onload="scrollToBody();">
    <!-- Header & Nav Bar -->
    <jsp:include page="Header.jsp"/>
    
    <!-- Successful Message -->
    <c:if test="${display_msg}">
        <div id="registration" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
             style="max-width:400px; margin: 1% 35%; text-align: center;">
            <h1>${msg}</h1>
        </div>
    </c:if>
    <!-- Successful Message End -->

    <!-- Error Message -->
    <c:if test="${display_error}">
        <div id="registration" class="w3-container w3-round w3-white w3-padding w3-animate-top" 
             style="max-width:400px; margin: 1% 35%">
            <c:forEach var="error_msg" items="${msgs}">
                <p><font color="red">*</font> ${error_msg}</p>
                </c:forEach>
        </div>
    </c:if>
    <!-- Error Message End -->

    <!-- Registraion Section -->
    <form id="registration" class="w3-container w3-round w3-white w3-padding-16 w3-animate-top" 
          style="max-width:400px; margin: 2% 35%" id="Registration" 
          action="RegistrationServlet" method="post">
        <div>
            <h2  >Registration Form</h2>
            <p style="color:red">Please fill in the form below.</p> 
            <div>
                <p><strong>Registration Type <font color="red">*</font></strong></p>
                <input class="w3-radio w3-margin" type="radio" name="RegType" value="T" required/> Teacher
                <input class="w3-radio w3-margin" type="radio" name="RegType" value="S" required/> Student
            </div>
            <div>
                <p><strong>User Name <font color="red">*</font></strong></p>
                <input class="w3-input" type="text" name="UName" placeholder="User Name" required/>
            </div>
            <div>
                <p><strong>Full Name <font color="red">*</font></strong></p>
                <input class="w3-input" type="text" name="FName" placeholder="First Name" required/>
                <input class="w3-input" type="text" name="LName" placeholder="Last Name" required/>
            </div>
            <div>
                <p><strong>Password <font color="red">*</font></strong></p>
                <input class="w3-input" type="password" name="Pass" placeholder="Password" required/>
                <input class="w3-input" type="password" name="CPass" placeholder="Confirm Password" required/>
            </div>
            <div>
                <p><strong>Date of Birth <font color="red">*</font></strong></p>
                <input class="w3-input" type="date" name="DOB" required />
            </div>
            <div>
                <p><strong>Email <font color="red">*</font></strong></p>
                <input class="w3-input" type="email" name="Email" placeholder="123@mail.com" required/>
            </div>
            <div>
                <p><strong>Contact No <font color="red">*</font></strong></p>
                <input class="w3-input" type="text" name="ContactNo" maxlength="10" placeholder="0771234567" required/>
            </div>
            <div>
                <p><strong>Gender <font color="red">*</font></strong></p>
                <select class="w3-select" name="Gender" required>
                    <option value="" >

                    </option>
                    <option value="M">
                        Male
                    </option>
                    <option value="F">
                        Female
                    </option>
                </select >
            </div>
            <div>
                <input class="w3-button w3-round w3-text-black w3-teal w3-margin" type="submit" value="Submit"/>
                <input class="w3-button w3-round w3-text-black w3-teal " type="reset" value="Reset"/>
            </div>
        </div>
    </form>
    <!-- Registraion Section End -->


    <!-- Footer -->
    <jsp:include page="Footer.jsp"/>

</body>
</html>