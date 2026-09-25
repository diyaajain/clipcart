<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>User Registration Form</title>
<style type="text/css">
	label {
		display: inline-block;
		width: 200px;
		margin: 5px;
		text-align: left;
	}
	input[type=text], input[type=password], select {
		width: 200px;	
	}
	input[type=radio] {
		display: inline-block;
		margin-left: 45px;
	}
	input[type=checkbox] {
		display: inline-block;
		margin-right: 190px;
	}	
	
	button {
		padding: 10px;
		margin: 10px;
	}
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
		<h1>User Registration</h1>
		<form:form id="registerform"  method="post" modelAttribute="user">
		  
	      <span>${errMessage}</span>
	       <table width="80%" height="100%"> 
	        <form:hidden path="user_roleid"/>
	        <tr>
			<td width="20%"><form:label path="user_firstname"><font style="color: white;font-weight:bold;">* First Name:</font></form:label></td>
			<td width="60%"><form:input path="user_firstname"/>
			<font id="firstNameError" style="color: red;"></font> </td>
			</tr>
			
			<tr>
			<td width="20%"><form:label path="user_lastname"><font style="color: white;font-weight:bold;">* Last Name:</font></form:label></td>
			<td width="60%"><form:input path="user_lastname"/>
			<font id="lastNameError" style="color: red;"></font></td>
			</tr>
			
			<tr>
			<td width="20%"><form:label path="user_name"><font style="color: white;font-weight:bold;">* User Name:</font></form:label></td>
			<td width="60%"><form:input path="user_name"/>
			<font id="userNameError" style="color: red;"></font></td>
			</tr>
			
			<tr>
			<td width="20%"><form:label path="user_password"><font style="color: white;font-weight:bold;">* Password:</font></form:label></td>
			<td width="60%"><form:password path="user_password"/><br><font style="font-style: italic;color:white;">Password should have at least:<br>one upper case<br>one lower case<br>one number </font>	<br>
			<font id="passwordError" style="color: red;"></font></td>
			
			</tr>
			
			<tr>
			<td width="20%"><form:label path="user_address"><font style="color: white;font-weight:bold;">* Address:</font></form:label></td>
			<td width="60%"><form:input path="user_address"/>
			<font id="addressError" style="color: red;"></font></td>
			</tr>
			
			<tr>
			<td width="20%"><form:label path="user_emailid"><font style="color: white;font-weight:bold;">* Email ID:</font></form:label></td>
			<td width="60%"><form:input path="user_emailid"/>
			<font id="emailIDError" style="color: red;"></font></td>
			</tr>
		
			<tr>
			<td width="20%"> <font style="color: red;font-weight:italic;">* Required fields</font> </td>	
			<td width="60%"><input type="button" onclick="validate();" value="Register"/></td>	
			</tr>			
			</table>
		
		
		</form:form>
	</div>
<script>   
  document.getElementById("navDiv").className = 'animation start-tab3';
</script>	
</body>
 <div style="display: flex; justify-content: center; align-items: center;">
  <img src="images/star.gif" alt="divider GIF" height="5%" width="5%">
</div>

<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>
	
</html>