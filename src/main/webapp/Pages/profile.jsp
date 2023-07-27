<%@page import="DAO.UserDAO"%>
<%@page import="model.User"%>
<%@page import="utils.cookies"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>User Profile</title>
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
		h1 {
			text-align: center;
			margin-top: 50px;
		}
		.container {
			background-color: #fff;
			max-width: 600px;
			margin: auto;
			padding: 20px;
			border-radius: 5px;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			margin-top: 50px;
		}
		.details {
			text-align: center;
			margin-top: 20px;
		}
		.details p {
			margin: 10px 0;
			font-size: 18px;
		}
		
		.user-img{
			text-align:center;
		}
		
		.user-img img{
			width:150px;
			height:150px;
			object-fit: cover;
			border-radius:50%;
		}
	</style>
</head>
<body>
	<nav>
		<a href="../homepage.jsp">Home</a>
		<a href="profile.jsp">Profile</a>
		<a href="edit-profile.jsp">Edit Profile</a>
		<a href="view-orders.jsp?viewBy=user">View Orders</a>
	</nav>
	<h1>User Profile</h1>
	
	<%
		String username = cookies.getCookies(request);
		
		UserDAO userdao = new UserDAO();
	
		User user = userdao.getUserData(username);
	
	%>
	
	<div class="container">
		<section id="profile">
			<%if(user != null){ %>
				<div class="user-img">
					<img src="http://localhost:8080/Images/<%=user.getImg()%>" alt="User Image">
				</div>
				<div class="details">
					<p><strong>Name:</strong> <%=user.getName() %></p>
					<p><strong>Email:</strong> <%=user.getEmail() %></p>
					<p><strong>Username:</strong> <%=user.getUsername() %></p>
				</div>
			<%} %>
		</section>
	</div>
</body>
</html>