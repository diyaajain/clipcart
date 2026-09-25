<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
  <link rel="stylesheet" href="css/main.css">
    <script src="js/cssvalidation.js" />"></script>
  
  <script>
    function formsubmit(formaction, userid, roleid){   
    	   var form = document.createElement("form");
    	   document.body.appendChild(form);
    	   form.method = "POST";
    	   form.action = formaction;
    	   var element1 = document.createElement("INPUT");         
    	    element1.name="user_id"
    	    element1.value = userid;
    	    element1.type = 'hidden'
    	    form.appendChild(element1);   
    	    var element2 = document.createElement("INPUT");         
    	    element2.name="role_id"
    	    element2.value = roleid;
    	    element2.type = 'hidden'
    	    form.appendChild(element2);
    	    form.submit();
    }
    
    function forward()
    {
      window.history.forward(1);
   
    }
  </script>
 

</head>

<body onLoad="forward();">

<nav >

<% String username = (String) request.getSession().getAttribute("username"); %>
<%
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Expires","0");
response.setDateHeader("Expires",-1);
%>

<!-- Depending on the user role, shows pages in the web-site header -->
<form:form id="headerform"   modelAttribute="user">
 <a href="javascript: formsubmit('home','${user.user_id}','${user.user_roleid}');">Home</a>
 <c:choose> 
  <c:when test="${user.user_roleid == '1' && user.user_rolename != null && username != null && username.trim().length() >0}">
     <a href="javascript: formsubmit('useradministration','${user.user_id}','${user.user_roleid}');">Users</a>
     <a href="javascript: formsubmit('productinventory','${user.user_id}','${user.user_roleid}');">Products</a>
     <a href="javascript: formsubmit('orderhistory','${user.user_id}','${user.user_roleid}');">Orders</a>
     <a href="logout">Logout</a>
  </c:when>
  <c:when test="${user.user_roleid == '2'  && user.user_rolename != null && username != null && username.trim().length() >0}">
     <a href="javascript: formsubmit('profile','${user.user_id}','${user.user_roleid}');">Profile</a>
     <a href="javascript: formsubmit('shop','${user.user_id}','${user.user_roleid}');">Shop</a>
     <a href="javascript: formsubmit('orderhistory','${user.user_id}','${user.user_roleid}');">Orders</a>
     <a href="logout">Logout</a>
  </c:when>
  <c:otherwise>    
	<a href="login">Login</a>
	<a href="register">Register</a>
  </c:otherwise>
</c:choose>

	<div  id="navDiv" name="navDiv" class="animation start-tab1"> 
	</div>
</form:form>
	
</nav>


</body>
