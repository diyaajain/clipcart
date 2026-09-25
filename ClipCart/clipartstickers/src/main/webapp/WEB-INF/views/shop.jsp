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
 var orderflag = true;	
 function validateOrderQuantity(availablequantity, orderquantity, index, rowprice){
	 //alert(availablequantity + ' , ' + orderquantity.value);
	 //alert(index);
	 orderflag = true;	
	 const formatter = new Intl.NumberFormat('en-US', {
        minimumFractionDigits: 2,      
        maximumFractionDigits: 2,
       });

	    var error=document.getElementById("quantityError");
	    error.innerHTML="";
	    var form = document.getElementById("shopform");
	    totalprice = form.elements.totalprice;  
	    totalprice[index].value = "";
	    var orderqty ;
	    var availqty ;
	    try{
	    	orderqty = Number(orderquantity.value);
	    	availqty = Number(availablequantity);
	    }catch(e){
	    	error.innerHTML="Enter valid Order Quantity";
	    	orderquantity.focus();
	    	orderflag = false;	
			return false;
	    }
	   // alert(orderqty);
	 if (isNaN(orderqty))  {
		 error.innerHTML="Enter valid Order Quantity";
		 orderquantity.focus();
		 orderflag = false;	
		 return false;
	 }else if (parseInt(orderqty) > parseInt(availqty)) {
		 error.innerHTML="Order Quantity can not be greater than Available Quantity";
		 orderquantity.focus();
		 orderflag = false;	
		 return false;
	 }else if(!Number.isInteger(orderqty)) {
		 error.innerHTML = "Enter valid Order Quantity";
		 orderquantity.value="0";
		 orderquantity.focus();
		 orderflag = false;	
		 return false;
	 }else if(parseInt(orderqty) < 0) {
		 error.innerHTML = "Order quantity cannot be less than 0 ";
		 orderquantity.value="0";
		 orderquantity.focus();
		 orderflag = false;	
		 return false;
	 }
	 
	 
	 totalprice[index].value =  formatter.format(parseInt(orderqty) * rowprice);
	 ordervalidate();
	 return true;
 }
 
 
 function ordervalidate(){
	 var orderprice = "0";
	 var form = document.getElementById("shopform");
	    totalprice = form.elements.totalprice;  
	 var index;
	 
	 const formatter = new Intl.NumberFormat('en-US', {
	        minimumFractionDigits: 2,      
	        maximumFractionDigits: 2,
	       });

	    if ('length' in totalprice  && 'item' in totalprice) {
	     
	      for (index = 0; index < totalprice.length; ++index) {
	        console.log(index + ": " + totalprice[index].value);
	        orderprice = Number(orderprice) + Number(totalprice[index].value);
	      }
	    }
	    document.getElementById("orderprice").value =  formatter.format(orderprice);
	    return true;
 }
 
 function orderconfirm(){
	 var error=document.getElementById("quantityError");
	 error.innerHTML="";
	 if (document.getElementById("orderprice").value.trim() != '' && document.getElementById("orderprice").value.trim() != '0.00') {
	 if (confirm("Do you want to confirm order?") == true) {
		 var form = document.getElementById("shopform");
		 form.action="order";
  	     form.method="Post";
  	     form.submit();
		} else {
		   //cancel
		}
	 }else{		
		 error.innerHTML = "Please enter Order quantity";
		 orderflag = false;	
	 }
 }
</script>

</head>
<jsp:include page="header.jsp" />

<body>
	<c:if test="${user.user_roleid == '2' && user.user_rolename != null  && username != null && username.trim().length() >0}">		
	
	<div align="center">
		<h1>Product List</h1>
		<form:form id="shopform"  method="post" modelAttribute="user">
	       <font id="quantityError" style="color: red;"></font>
	       <table width="80%" height="100%"> 
	        <tr>
			<th > Sticker Image </th>
			<th > Sticker Name </th>
			<th > Available Quantity </th>
			<th > Order Quantity </th>
			<th > Unit Price ($)  </th>
			<th > Total Price ($) </th>
			<tr>
			
			<c:forEach items="${products}" var="product" varStatus="myIndex">
			<input type="hidden" name="product_id" id="product_id" value="${product.product_id}">
			<input type="hidden" name="product_index" id="product_index" value="<c:out value="${myIndex.index}"/>">
			<input type="hidden" name="user_id" id="user_id" value="${user.user_id}">
			<tr>
			<td > <img src="data:image/png;base64,${product.product_image_stringbase64}" width="50" height="30"></img> </td>
			<td ><font style="color: white;font-weight:bold;">${product.product_name}</font></td>
			<td ><font style="color: white;font-weight:bold;">${product.product_quantity}</font></td>
			<td > <input name="order_quantity" id="order_quantity" type="text" onfocusout="return validateOrderQuantity('${product.product_quantity}', this, '<c:out value="${myIndex.index}"/>','${product.product_price}');"  maxLength="3" value="${product.order_quantity}"></td>
			<td ><font style="color: white;font-weight:bold;">${product.product_price}</font></td>	
			<td> <input name="totalprice" id="totalprice" type="text" size="10" maxLength="10" value="" readonly></td>	
			</tr>
		   </c:forEach>
		   <tr>
			<td  colspan="4" align="center"> <input type="button" onclick="orderconfirm();" value="Order"/> </td>
			<td ><font style="color: white;font-weight:bold;"> Order Total : </font></td>
			<td > <input name="orderprice" id="orderprice" type="text"  maxLength="10" value="" readonly></td>	
			</tr>
		    </table>
		</form:form>
	</div>
	
    </c:if>    

<script>   
  document.getElementById("navDiv").className = 'animation start-tab3';
</script>
			
</body>
 <div style="margin-top: 20px; display: flex; justify-content: center; align-items: center;">
  <img src="images/dogshopping.gif" alt="dog shopping GIF" height="10%" width="10%">
</div>
<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>

</html>