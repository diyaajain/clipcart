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

 function validateOrderQuantity(availablequantity, orderquantity, index, rowprice){
	 //alert(availablequantity + ' , ' + orderquantity.value);
	 //alert(index);
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
			return false;
	    }
	   // alert(orderqty);
	 if (isNaN(orderqty))  {
		 error.innerHTML="Enter valid Order Quantity";
		 orderquantity.focus();
		 return false;
	 }else if (orderqty > availqty) {
		 error.innerHTML="Order Quantity can not be greater than Available Quantity";
		 return false;
	 }
	 
	 
	 totalprice[index].value =  formatter.format(orderqty * rowprice);
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
 
 function productinventory(action, productid , productindex){
	 var productname;
	 var productprice;
	 var userid = document.getElementById("user_id").value;
	 var roleid = document.getElementById("role_id").value;
	 if (action == 'Add') {
		  productid = productid;
		  productname = document.getElementById("add_product_name").value;
		  productquantity = document.getElementById("add_product_quantity").value;
		  productprice = document.getElementById("add_product_price").value;
	 }else{
		productid = productid;
		productname = document.getElementsByName("product_name")[productindex].value;
		productquantity = document.getElementsByName("product_quantity")[productindex].value;
		productprice = document.getElementsByName("product_price")[productindex].value;
	 }
	 
	 var successmsg =document.getElementById("successmsg");
	 successmsg.innerHTML="";
	 
	 var errormsg =document.getElementById("errormsg");
	 errormsg.innerHTML="";
	 
	 //alert(userid);
	 //alert(productid);
	 //alert(productname);
	 //alert(productquantity);
	 //alert(productprice);
	    var formsubmit = true;
	    var productqty ;
	    var productpr ;
	    var error=document.getElementById("quantityError");
	    error.innerHTML="";
	    
	    try{
	    	productqty = Number(productquantity);
	    }catch(e){
	    	  error.innerHTML="Enter valid Product Quantity";
	    	  document.getElementsByName("product_quantity")[productindex].focus();
	    	 formsubmit = false;
	    }
	    
	    try{
	    	productpr = Number(productprice);	    	
	    }catch(e){
	    	  error.innerHTML="Enter valid Product Price";
	    	  document.getElementsByName("product_price")[productindex].focus();
	    	 formsubmit = false;
	    }
	   // alert(orderqty);
	    if (isNaN(productqty))  {
		 error.innerHTML="Enter valid Product Quantity";
		 document.getElementsByName("product_quantity")[productindex].focus();
		 formsubmit = false;
	    }else if (isNaN(productpr))  {
			 error.innerHTML="Enter valid Product Price";
			 document.getElementsByName("product_price")[productindex].focus();
			 formsubmit = false;
		}else if (isNaN(productpr))  {
			 error.innerHTML="Enter valid Product Price";
			 document.getElementsByName("product_price")[productindex].focus();
			 formsubmit = false;
		}else if(!Number.isInteger(productqty)) {
			 error.innerHTML = "Enter valid Product Quantity";
			 document.getElementsByName("product_quantity")[productindex].focus();
			 formsubmit = false;
		 }else if(parseInt(productqty) < 0) {
			 error.innerHTML = "Product quantity cannot be less than 0 ";
			 document.getElementsByName("product_quantity")[productindex].focus();
			 formsubmit = false;
		 }
	    
	 
	    if (action == 'Delete') {
			 if (confirm("Do you want to delete product?") == true) {
				  formsubmit = true;
			  } else {
				 formsubmit = false;
			 }
		}
	    
	    if (productname.trim() == '' ) {
	    	 error.innerHTML="Enter Product Name";
	    	 formsubmit = false;
	    }else if (productquantity.trim() == '' ) {
	    	 error.innerHTML="Enter Product Quantity";
	    	 formsubmit = false;
	    }else if (productprice.trim() == '' ) {
	    	 error.innerHTML="Enter Product Price";
	    	 formsubmit = false;
	    }else if (productpr <= '0' ) {
	    	 error.innerHTML="Enter valid Product Price";
	    	 formsubmit = false;
	    }
	    
	  if (formsubmit == true ) {
	   var form = document.createElement("form");
	   document.body.appendChild(form);
	   form.method = "POST";
	   form.action = 'updateproductinventory';
	   var element1 = document.createElement("INPUT");         
	    element1.name="action"
	    element1.value = action;
	    element1.type = 'hidden'
	    form.appendChild(element1);   
	    var element2 = document.createElement("INPUT");         
	    element2.name="product_name"
	    element2.value = productname;
	    element2.type = 'hidden'
	    form.appendChild(element2);
	    var element3 = document.createElement("INPUT");         
	    element3.name="product_quantity"
	    element3.value = productquantity;
	    element3.type = 'hidden'
	    form.appendChild(element3);
	    var element4 = document.createElement("INPUT");         
	    element4.name="product_price"
	    element4.value = productprice;
	    element4.type = 'hidden'
	    form.appendChild(element4);
	    var element5 = document.createElement("INPUT");         
	    element5.name="product_id"
	    element5.value = productid;
	    element5.type = 'hidden'
	    form.appendChild(element5);
	    var element6 = document.createElement("INPUT");         
	    element6.name="user_id"
	    element6.value = userid;
	    element6.type = 'hidden'
	    form.appendChild(element6);
	    var element7 = document.createElement("INPUT");         
	    element7.name="role_id"
	    element7.value = roleid;
	    element7.type = 'hidden'
	    form.appendChild(element7);
	    form.submit();  
	  }
 }
 
</script>

</head>
<jsp:include page="header.jsp" />

<body>
	<c:if test="${user.user_roleid == '1' && user.user_rolename != null  && username != null && username.trim().length() >0}">		
	
	<div align="center">
		<h1>Product Inventory</h1>
		<span id="successmsg" name="successmsg">${successMessage}</span>
		<span id="errormsg" name="errormsg">${errorMessage}</span>
		<br><font id="quantityError" style="color: red;"></font>
		<form:form id="shopform"  method="post" modelAttribute="user">
		<input type="hidden" name="user_id" id="user_id" value="${user.user_id}">
		<input type="hidden" name="role_id" id="role_id" value="${user.user_roleid}">
	       <font id="productError" style="color: red;"></font>
	       <table width="80%" height="100%"> 
	        <tr>
			<th > Sticker Image </th>
			<th > Sticker Name </th>
			<th > Available Quantity </th>
			<th > Unit Price ($)  </th>
			<th > Update Action </th>
			<th > Delete Action </th>
			<tr>			
			<c:forEach items="${products}" var="product" varStatus="myIndex">			
			<tr>
			<td > <img src="data:image/png;base64,${product.product_image_stringbase64}" width="50" height="30"></img> </td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="product_name" name="product_name" size="20" value="${product.product_name}"/> </font></td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="product_quantity" name="product_quantity" size="20" value="${product.product_quantity}"/> </font></td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="product_price" name="product_price" size="20" value="${product.product_price}"/> </font></td>	
			<td>  <input type="button" onclick="productinventory('Update','${product.product_id}', '${myIndex.index}');" value="Update"/> </td>	
			<td>  <input type="button" onclick="productinventory('Delete','${product.product_id}', '${myIndex.index}');" value="Delete"/> </td>	
			</tr>
		   </c:forEach>
		   <tr>
			<td >  </td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="add_product_name" name="add_product_name" size="20" value=""/> </font></td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="add_product_quantity" name="add_product_quantity" size="20" value="${product.product_quantity}"/> </font></td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="add_product_price" name="add_product_price" size="20" value="${product.product_price}"/> </font></td>	
			<td> <input type="button" onclick="productinventory('Add','0', '0');" value="Add"/> </td>	
			<td>  </td>	
			</tr>
		    </table>
		</form:form>
	</div>
	
    </c:if>    

<script>   
  document.getElementById("navDiv").className = 'animation start-tab3';
</script>
			
</body>
 <div style="display: flex; justify-content: center; align-items: center;">
  <img src="images/cat-shopping.gif" alt="cat shopping GIF" height="10%" width="10%">
</div>
<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>
</html>