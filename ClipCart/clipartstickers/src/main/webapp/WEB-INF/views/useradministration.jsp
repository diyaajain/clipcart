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
 
 function useradministration(action, userid , userindex){
	 var firstname;
	 var lastname;
	 var address;
	 var emailid;
	 var roleid;
	 
	 var luserid = document.getElementById("user_id").value;
	 
	
	    userid = userid;
	    firstname = document.getElementsByName("user_firstname")[userindex].value;
	    lastname = document.getElementsByName("user_lastname")[userindex].value;
	    address = document.getElementsByName("user_address")[userindex].value;
	    emailid = document.getElementsByName("user_emailid")[userindex].value;
	    roleid = document.getElementsByName("user_roleid")[userindex].value;
	
	 
	 var successmsg =document.getElementById("successmsg");
	 successmsg.innerHTML="";
	 
	 var errormsg =document.getElementById("errormsg");
	 errormsg.innerHTML="";
	 
	 //alert(userid);
	 //alert(firstname);
	 //alert(lastname);
	 //alert(address);
	 //alert(emailid);
	 //alert(roleid);
	 
	    var formsubmit = true;
	    var error=document.getElementById("userError");
	    error.innerHTML="";
	    var regx = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	    
	    if( firstname.trim() == null || firstname.trim()==""){
	        error.innerHTML="Please enter First Name";
	        document.getElementsByName("user_firstname")[userindex].focus();
	        formsubmit = false;
	    }else if( lastname.trim()==null || lastname.trim()==""){
	        error.innerHTML="Please enter Last Name";
	        document.getElementsByName("user_lastname")[userindex].focus();
	        formsubmit = false;
	    }else if( address.trim() ==null || address.trim() ==""){
	        error.innerHTML="Please enter Address";
	        document.getElementsByName("user_address")[userindex].focus();
	        formsubmit = false;
	    }else if( emailid.trim()==null || emailid.trim()==""){
	        error.innerHTML="Please enter Email ID";
	        document.getElementsByName("user_emailid")[userindex].focus();
	        formsubmit = false;
	    } else if(!emailid.trim().match(regx)){
	    	error.innerHTML="Invalid Email ID";
	    	document.getElementsByName("user_emailid")[userindex].focus();
	    	formsubmit = false;
	    }
	    
	 
	    if (action == 'Delete') {
			 if (confirm("Do you want to delete user?") == true) {
				  formsubmit = true;
			  } else {
				 formsubmit = false;
			 }
		}
	    
	    //alert(formsubmit);
	 
	    
	  if (formsubmit == true ) {
	   var form = document.createElement("form");
	   document.body.appendChild(form);
	   form.method = "POST";
	   form.action = 'updateuser';
	   var element1 = document.createElement("INPUT");         
	    element1.name="action"
	    element1.value = action;
	    element1.type = 'hidden'
	    form.appendChild(element1);   
	    var element2 = document.createElement("INPUT");         
	    element2.name="user_firstname"
	    element2.value = firstname;
	    element2.type = 'hidden'
	    form.appendChild(element2);
	    var element3 = document.createElement("INPUT");         
	    element3.name="user_lastname"
	    element3.value = lastname;
	    element3.type = 'hidden'
	    form.appendChild(element3);
	    var element4 = document.createElement("INPUT");         
	    element4.name="user_address"
	    element4.value = address;
	    element4.type = 'hidden'
	    form.appendChild(element4);
	    var element5 = document.createElement("INPUT");         
	    element5.name="user_emailid"
	    element5.value = emailid;
	    element5.type = 'hidden'
	    form.appendChild(element5);
	    var element6 = document.createElement("INPUT");         
	    element6.name="user_userid"
	    element6.value = userid;
	    element6.type = 'hidden'
	    form.appendChild(element6);
	    var element7 = document.createElement("INPUT");         
	    element7.name="user_roleid"
	    element7.value = roleid;
	    element7.type = 'hidden'
	    form.appendChild(element7);
	    var element8 = document.createElement("INPUT");         
	    element8.name="luser_id"
	    element8.value = luserid;
	    element8.type = 'hidden'
	    form.appendChild(element8);
	    form.submit();  
	  } 
 }
 
</script>

</head>
<jsp:include page="header.jsp" />

<body>    
	<c:if test="${user.user_roleid == '1' && user.user_rolename != null  && username != null && username.trim().length() >0}">		
	
	<div align="center">
		<h1>User Administration</h1>
		<span id="successmsg" name="successmsg">${successMessage}</span>
		<span id="errormsg" name="errormsg">${errorMessage}</span>
		<br><font id="userError" style="color: red;"></font>
		<form:form id="shopform"  method="post" modelAttribute="user">
		<input type="hidden" name="user_id" id="user_id" value="${user.user_id}">
	       <font id="productError" style="color: red;"></font>
	       <table width="80%" height="100%"> 
	        <tr>
			<th > User Name </th>
			<th > First Name </th>
			<th > Last Name </th>
			<th > Address  </th>
			<th > Email ID  </th>
			<th > Role ID  </th>
			<th > Update Action </th>
			<th > Delete Action </th>
			<tr>			
			<c:forEach items="${users}" var="userrec" varStatus="myIndex">			
			<tr>
			<td > <font style="color: white;font-weight:bold;"> ${userrec.user_name} </font> </td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="user_firstname" name="user_firstname" size="20" value="${userrec.user_firstname}"/> </font></td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="user_lastname" name="user_lastname" size="20" value="${userrec.user_lastname}"/> </font></td>
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="user_address" name="user_address" size="20" value="${userrec.user_address}"/> </font></td>	
			<td ><font style="color: white;font-weight:bold;"><input type="text" id="user_emailid" name="user_emailid" size="20" value="${userrec.user_emailid}"/> </font></td>	
			<td ><font style="color: white;font-weight:bold;">
			       <select name="user_roleid"  id="user_roleid">
				    <option value="1" ${userrec.user_roleid == 1 ? 'selected' : ''}>Admin</option>
				    <option value="2" ${userrec.user_roleid == 2 ? 'selected' : ''}>User</option>
				  </select>
			</font></td>	
			<td>  <input type="button" onclick="useradministration('Update','${userrec.user_id}', '${myIndex.index}');" value="Update"/> </td>	
			<td>  <input type="button" onclick="useradministration('Delete','${userrec.user_id}', '${myIndex.index}');" value="Delete"/> </td>	
			</tr>
		   </c:forEach>
		  
		    </table>
		</form:form>
	</div>
	
    </c:if>    

<script>   
  document.getElementById("navDiv").className = 'animation start-tab2';
</script>
			
</body>
 <div style="display: flex; justify-content: center; align-items: center;">
  <img src="images/clippy.gif" alt="divider GIF" height="10%" width="10%">
</div>
	
<div style="margin-top:20px; bottom: 20px;width: 100%;text-align: center;color: #ecf0f1; font-family: 'Cherry Swash',cursive; font-size: 16px;"> By <font style="color: #2BD6B4;">Niharika, Hetvi, Diya</font> </div>
</html>