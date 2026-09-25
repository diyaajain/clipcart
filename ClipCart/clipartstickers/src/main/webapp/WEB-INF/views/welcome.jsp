<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta charset="ISO-8859-1">
<title>Clip Art Stickers</title>

<style type="text/css">
table {
    border-collapse:separate;
    border:solid white 1px;
    border-radius:6px;
    padding: 5px 4px 6px 4px; 
}

td, th {
    border-left:solid white 1px;
    border-top:solid white 1px;
    padding: 5px 4px 6px 4px; 
}

th {
    background-color: blue;
    border-top: none;
    padding: 5px 4px 6px 4px; 
}

td:first-child, th:first-child {
     border-left: none;
}
</style>
</head>
<jsp:include page="header.jsp" />
<body>
   <div align="center">
	<img src = "images/logo.png" width= 800 height = 200 ></img>
	
	<form:form id="welcomeform"   modelAttribute="user">
		  
    <table width="50%" height="100%"> <tr><td align="center">
    <c:choose> 
     <c:when test="${user.user_rolename != null && username != null && username.trim().length() >0}">
		  <div style="position:relative; display:inline-block;">
		  <img src="images/mynameis.png" width=600 height= 400 style="display:block; vertical-align:middle; margin:auto;">
		  <div style="position:absolute; top:85%; left:35%; transform:translate(-50%,-50%); text-align: center; padding:20px;">
		  	<p style="display:inline-block; vertical-align:middle; font-size:40px; color:black;">${user.user_firstname} ${user.user_lastname}</p>
		</div>
		</div>
	  <br><br><font style="font-weight:bold; font-size:15px; color:white;">Role: ${user.user_rolename} </font>
	</c:when>
    <c:otherwise>    
	  <font style="font-weight:bold; font-size:20px; color:white;">Welcome </font> 
   </c:otherwise>
   </c:choose>
	
	</td></tr></table>
	</form:form>
	</div>
</body>
 <div style="display: flex; justify-content: center; align-items: center;">
  <img src="images/hello.gif" alt="divider GIF" height="15%" width="15%">
</div>

<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>
	
</html>