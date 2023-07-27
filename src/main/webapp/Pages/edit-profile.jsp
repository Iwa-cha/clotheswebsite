<%@page import="model.User"%>
<%@page import="utils.cookies"%>
<%@page import="DAO.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Edit Profile</title>
	<link rel="stylesheet" href="style.css">
	
	<style>
	
		body {
			font-family: Arial, sans-serif;
			background-color: #f2f2f2;
			margin: 0;
			padding: 0;
		}
	
		nav {
			background-color: #333;
			overflow: hidden;
			display: flex;
			justify-content: center;
		}
		nav a {
			color: #fff;
			text-align: center;
			padding: 14px 16px;
			text-decoration: none;
			font-size: 18px;
		}
		nav a:hover {
			background-color: #ddd;
			color: #333;
		}
		.container {
			margin-top: 70px;
			margin-left: 20px;
			display:flex;
			justify-content:center;

		}
		
		h1 {
			font-size: 32px;
		}
		
		form {
			margin-top: 20px;
		}
		
		label {
			display: inline-block;
			margin-bottom: 5px;
			font-weight: bold;
		}
		
		input[type="file"] {
			margin-bottom: 10px;
		}
		
		input[type="text"], input[type="email"], input[type="password"] {
			width: 300px;
			height: 30px;
			font-size: 16px;
			padding-left: 10px;
			margin-bottom: 10px;
			border-radius: 5px;
			border: 1px solid #ccc;
		}
		
		input[type="submit"] {
			background-color: #4CAF50;
			border: none;
			color: white;
			padding: 10px 20px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 16px;
			border-radius: 5px;
			cursor: pointer;
			margin-top: 10px;
		}
		
	</style>
</head>
<body>
	<nav>
		<a href="../homepage.jsp">Home</a>
		<a href="profile.jsp">Profile</a>
		<a href="edit-profile.jsp">Edit Profile</a>
	</nav>
	
	<%
		String username = cookies.getCookies(request);
		
		UserDAO userdao = new UserDAO();
	
		User user = userdao.getUserData(username);
	
	%>
	
	<div class="container">
		<div>
			<h1>Edit Profile</h1>
			
			<%
				if(user != null){
			%>
			
				<form action="../UpdateUserServlet" method="post" enctype="multipart/form-data">
				
					<input type="hidden" name="oldImg" value="<%=user.getImg()%>">
					<input type="hidden" name="Username" value="<%=user.getUsername()%>">
					
					<label for="img">Profile Picture:</label><br>
					<input type="file" id="img" name="img"><br>
					
					<label for="name">Name:</label><br>
					<input type="text" id="name" name="Fullname" value="<%=user.getName()%>"><br>
					
					<label for="email">Email:</label><br>
					<input type="email" id="email" name="Email" value="<%=user.getEmail()%>"><br>
					
					<label for="email">New Password:</label><br>
					<input type="password" id="email" name="Password"><br>
					
					<input type="submit" value="Updated">
				</form>
			<%}%>
		</div>
	</div>
</body>
</html>
