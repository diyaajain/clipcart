function loginvalidate(){
	//alert('validate called');
    var f=document.getElementById("loginform");
   if (usernameValidate(f) && loginpasswordValidate(f)) {
	   f.action="login";
	   f.method="Post";
	   f.submit();
   }
}



function validate(){
	//alert('validate called');
    var f=document.getElementById("registerform");
   if ( firstNameValidate(f) &&
    lastNameValidate(f) &&
    usernameValidate(f) &&
    passwordValidate(f) &&
    addressValidate(f)  &&
    emailIDValidate(f) 
    ) {
	   f.action="register";
	   f.method="Post";
	   f.submit();
   }
   
}


	function firstNameValidate(form){
	 //alert('first name validate called');
	 var error=document.getElementById("firstNameError");

	    var firstName=form["user_firstname"].value.trim();

	    error.innerHTML="";

	    if( firstName==null || firstName==""){
	        error.innerHTML="Please enter First Name";
	        document.getElementById("user_firstname").focus();
	        return false;
	    }

	    else if(!isNaN(firstName)){
	        error.innerHTML="First Name Can Not be a number";
	        document.getElementById("user_firstname").focus();
	        return false;
	    }
	        return true;
	}

	function lastNameValidate(form){
	 var error=document.getElementById("lastNameError");

	    var lastName=form["user_lastname"].value.trim();

	    error.innerHTML="";

	    if( lastName==null || lastName==""){
	        error.innerHTML="Please enter Last Name";
	        document.getElementById("user_lastname").focus();
	        return false;
	    }

	    else if(!isNaN(lastName)){
	        error.innerHTML="Last Name Can Not be a number";
	        document.getElementById("user_lastname").focus();
	        return false;
	    }

	    return true;

	}
	
	function usernameValidate(form){
	    var error=document.getElementById("userNameError");

	    var username=form["user_name"].value.trim();

	    error.innerHTML="";

	    if( username==null || username==""){
	        error.innerHTML="Please enter User Name";
	        document.getElementById("user_name").focus();
	        return false;
	    }

	    else if(!isNaN(username)){
	        error.innerHTML="User Name Can Not be a number";
	        document.getElementById("user_name").focus();
	        return false;
	    }
	    return true;
	}

 function emailIDValidate(form){
     var error=document.getElementById("emailIDError");

     var email=form["user_emailid"].value;
     error.innerHTML="";
     
      var regx = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if( email==null || email==""){
    	error.innerHTML="Please enter Email ID";
    	document.getElementById("user_emailid").focus();
    	return false;
    }  else if(!email.match(regx)){
    	error.innerHTML="Invalid Email ID";
    	document.getElementById("user_emailid").focus();
    	return false;
    }
        return true;
 }

 function  passwordValidate(form){
    var error=document.getElementById("passwordError");
    error.innerHTML="";

    var password=form["user_password"].value.trim();
    var regx=/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).+$/;

    if( password==null || password==""){
        error.innerHTML="Please enter Password";
        document.getElementById("user_password").focus();
        return false;
    }else if(!password.match(regx)){
    	error.innerHTML="Password pattern does not match";
    	document.getElementById("user_password").focus();
    	return false;
    }

    return true;

}

 function  loginpasswordValidate(form){
	    var error=document.getElementById("passwordError");
	    error.innerHTML="";

	    var password=form["user_password"].value.trim();
	    var regx=/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).+$/;

	    if( password==null || password==""){
	        error.innerHTML="Please enter Password";
	        document.getElementById("user_password").focus();
	        return false;
	    }

	    return true;

	}


function addressValidate(form){
   var error=document.getElementById("addressError");

    var address=form["user_address"].value.trim();

     error.innerHTML="";

    if( address==null || address==""){
        error.innerHTML="Please enter Address";
        document.getElementById("user_address").focus();
        return false;
    }

    else if(!isNaN(address)){
        error.innerHTML="Address Can Not be a number";
        document.getElementById("user_address").focus();
        return false;
    }

    return true;     

 }

 