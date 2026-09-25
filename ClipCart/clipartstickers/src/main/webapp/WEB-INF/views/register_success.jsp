<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Success</title>
<style type="text/css">
	span {
		display: inline-block;
		width: 200px;
		text-align: left;
	}
</style>
</head>
<body>	
<jsp:include page="header.jsp" />			
	<div align="center">
		<h1>Registration Succeeded!</h1>
		<span>First Name:</span><span>${user.user_firstname}</span><br/>
		<span>Last Name:</span><span>${user.user_lastname}</span><br/>
		<span>Username:</span><span>${user.user_name}</span><br/>
		<span>Password:</span><span>${user.user_password}</span><br/>
		<span>Address:</span><span>${user.user_address}</span><br/>
		<span>Email ID:</span><span>${user.user_emailid}</span><br/>
	</div>
</body>
 <div style="display: flex; justify-content: center; align-items: center;">
  <img src="images/ok.gif" alt="divider GIF" height="20%" width="20%">
</div>

<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>
	
</html>