
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="../CSS/style.css" />
  <link rel="stylesheet" href="../CSS/signup.css" />
    
</head>
<body>
<div class="sign-up">
        <div style="text-align:center; margin:30px 0;">
	        <h1> Sign Up</h1>
	        <h4>Register Your Account</h4>
        </div>
        <div class="sign">
        <form action="../userRegister" method="post" class="form login" enctype="multipart/form-data">
            <label>Full Name</label>
            <input type="text" placeholder="" name="Fullname">
            <label>UserName</label>
            <input type="text" placeholder="" name="Username">
            <label>Email Address </label> <br>
            <input type="text" placeholder="" name="Email">
            <label>Password</label>
            <input type="password" placeholder="" name="Password">
            
            <label>Image</label>
            <input type="file" name="img">
            <br>
            <br>
            <input type="submit" value="Register">
            <br>
            <br>
        </form>
        </div> 
        <p> Already Have an account? 
            <a href="login.jsp">Login</a>
        </p>
        
        <p>
           	<a href="../homepage.jsp">Go to home page</a>
        </p>
         <br>
         <br>
    </div>
   

</body>
</html>