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
<script>

 function updateOrder(orderid, orderstatusindex, userid){
	 //alert(orderid);	 
	 var e = document.getElementsByName("orderstatus")[orderstatusindex];
	 var orderstatus = e.options[e.selectedIndex].value;
	 //alert(orderstatus);
	 //alert(userid);
	 
	 var form = document.createElement("form");
	   document.body.appendChild(form);
	   form.method = "POST";
	   form.action = 'updateorder';
	   var element1 = document.createElement("INPUT");         
	    element1.name="user_id"
	    element1.value = userid;
	    element1.type = 'hidden'
	    form.appendChild(element1);   
	    var element2 = document.createElement("INPUT");         
	    element2.name="order_id"
	    element2.value = orderid;
	    element2.type = 'hidden'
	    form.appendChild(element2);
	    var element3 = document.createElement("INPUT");         
	    element3.name="order_status"
	    element3.value = orderstatus;
	    element3.type = 'hidden'
	    form.appendChild(element3);
	    form.submit();
 }
 

	 
	 </script>

</head>
<jsp:include page="header.jsp" />

<body>
	<c:if test="${user.user_roleid == '2' && user.user_rolename != null  && username != null && username.trim().length() >0}">		
	
	<div align="center">
		<h1>Order History</h1>
		<form:form id="orderhistoryform"  method="post" modelAttribute="orders">
	       <font id="quantityError" style="color: red;"></font>
	       
           <c:forEach items="${orders}" var="order" varStatus="myIndex">	
            <h2><font style="color: white;">Order Details CAS# ${order.order_id}</font></h2>
	       <table width="80%" height="100%"> 
	        <tr>
			<th > Order ID </th>
			<th > Order By </th>
			<th > Order Status </th>
			<th > Order Date </th>
			<th > Ship Date </th>
			<th > Order Total ($) </th>
			</tr>
			<tr>
			<td > <font style="color: white;font-weight:bold;">CAS# ${order.order_id}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.user_name}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.order_status}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.order_date}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.ship_date}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.order_total}</font> </td>
			</tr>	
		   
		   
		    <table width="80%" height="100%"> 
	        <tr>
	        <th > Sticker Image </th>
			<th > Sticker Name </th>
			<th > Order Quantity </th>
			<th > Total Price ($)</th>
			</tr>
			<c:forEach items="${order.orderdetailslist}" var="orderdetails" varStatus="myIndex1">
			<tr>
			<td ><img src="data:image/png;base64,${orderdetails.product_image_stringbase64}" width="50" height="30"></img></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.product_name}</font></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.order_quantity}</font></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.total_price}</font></td>	
			</tr>
			</c:forEach> 
		    </table>
		    <br>
		   
		   
			 <br>
			 </table>
		   </c:forEach>
		</form:form>
	</div>
	
    </c:if>    
    
    
    <c:if test="${user.user_roleid == '1' && user.user_rolename != null  && username != null && username.trim().length() >0}">		
	
	<div align="center">
		<h1>Order History</h1>
		<span>${successMessage}</span>
		<form:form id="orderhistoryform"  method="post" modelAttribute="orders">
	      
           <c:forEach items="${orders}" var="order" varStatus="myIndex">	
            <h2><font style="color: white;">Order Details CAS# ${order.order_id}</font></h2>
            
	       <table width="80%" height="100%"> 
	        <tr>
			<th > Order ID </th>
			<th > Order By </th>
			<th > Order Status </th>
			<th > Order Date </th>
			<th > Ship Date </th>
			<th > Order Total ($) </th>
			<th > Action </th>
			</tr>
			<tr>
			<td > <font style="color: white;font-weight:bold;">CAS# ${order.order_id}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.user_name}</font> </td>
			<td >
			     <%-- <font style="color: white;font-weight:bold;">${order.order_status}</font>  --%>
			  	<select name="orderstatus"  id="orderstatus">
				    <option value="Canceled" ${order.order_status == 'Canceled' ? 'selected' : ''}>Canceled</option>
				    <option value="Created" ${order.order_status == 'Created' ? 'selected' : ''}>Created</option>
				    <option value="Shipped" ${order.order_status == 'Shipped' ? 'selected' : ''}>Shipped</option>
				    <option value="Delivered" ${order.order_status == 'Delivered' ? 'selected' : ''}>Delivered</option>
				  </select>
			 </td>
			
			<td > <font style="color: white;font-weight:bold;">${order.order_date}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.ship_date}</font> </td>
			<td > <font style="color: white;font-weight:bold;">${order.order_total}</font> </td>
			<td > <input type="button" id="UpdateOrder" value="Update"  onclick="updateOrder('${order.order_id}', '${myIndex.index}','${user.user_id}');"> </td>
			</tr>	
		   
		   
		    <table width="80%" height="100%"> 
	        <tr>
	        <th > Sticker Image </th>
			<th > Sticker Name </th>
			<th > Order Quantity </th>
			<th > Total Price ($)</th>
			</tr>
			<c:forEach items="${order.orderdetailslist}" var="orderdetails" varStatus="myIndex1">
			<tr>
			<td ><img src="data:image/png;base64,${orderdetails.product_image_stringbase64}" width="50" height="30"></img></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.product_name}</font></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.order_quantity}</font></td>
			<td ><font style="color: white;font-weight:bold;">${orderdetails.total_price}</font></td>	
			</tr>
			</c:forEach> 
		    </table>
		    <br>
		   
		   
			 <br>
			 </table>
		   </c:forEach>
		</form:form>
	</div>
	
    </c:if> 
<script>   
  document.getElementById("navDiv").className = 'animation start-tab4';
</script>	
 <div style="display: flex; justify-content: center; align-items: center;">
  <img src="images/divider-stars.gif" alt="divider GIF" height="20%" width="20%">
</div>

<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>
		
</body>


</html>