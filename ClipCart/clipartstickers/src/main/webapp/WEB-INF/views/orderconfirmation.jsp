<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    background-color: #00b3b3;
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
 	<c:if test="${user.user_roleid == '2' && user.user_rolename != null  && username != null && username.trim().length() >0}">		
	
	<div align="center">
		<h1>Order Confirmation</h1>
		<form:form id="orderform"  method="post" modelAttribute="order">
	       <font id="quantityError" style="color: red;"></font></td>
	        <h2><font style="color: white;">Order Details CAS# ${order.order_id}</font></h2>
	       <table width="80%" height="100%"> 
	        <tr>
			<th > Order ID </th>
			<th > Order By </th>
			<th > Order Status </th>
			<th > Order Date </th>
			<th > Ship Date </th>
			<th > Order Total ($) </th>
			<tr>
			<tr>
			<td > <font style="color: white;font-weight:bold;">CAS# ${order.order_id}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.user_name}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.order_status}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.order_date}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.ship_date}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.order_total}</font> </td>
			<tr>	
		    <table width="80%" height="100%"> 
	        <tr>
			<th > Sticker Image </th>
			<th > Sticker Name </th>
			<th > Order Quantity </th>
			<th > Total Price ($)</th>
			<tr>
			<c:forEach items="${order.orderdetailslist}" var="orderdetails" varStatus="myIndex">
			<tr>
			<td ><img src="data:image/png;base64,${orderdetails.product_image_stringbase64}" width="50" height="30"></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.product_name}</font></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.order_quantity}</font></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.total_price}</font></td>	
			</tr>
		   </c:forEach>			
		    </table>
		     </table>
		</form:form>
	</div>
	
    </c:if>    
	
	<script>   
     document.getElementById("navDiv").className = 'animation start-tab3';
    </script>
			
</body>
 <div style="display: flex; justify-content: center; align-items: center;">
  <img src="images/thankyou.gif" alt="cat saying ok GIF" height="20%" width="20%">
</div>
<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>
</html>