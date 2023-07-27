<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.CartDAO"%>
<%@page import="model.User"%>
<%@page import="DAO.UserDAO"%>
<%@page import="utils.cookies"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>View Cart</title>
	
	<style>
		.container {
			width:80%;
			margin:70px auto;
		}
		
		h1 {
			font-size: 32px;
		}
		
		table {
			width: 100%;
			border-collapse: collapse;
		}
		
		th, td {
			padding: 10px;
			text-align: left;
		}
		
		th {
			background-color: #ddd;
		}
		
		tfoot td {
			font-weight: bold;
		}
		
		.checkout {
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
			margin-top: 20px;
		}
		
		.delete {
			background-color: #f44336;
			border: none;
			color: white;
			padding: 5px 10px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			font-size: 12px;
			border-radius: 5px;
			cursor: pointer;
		}
	</style>
	
</head>
<body>
	
	<div class="container">
		<form action="../CartServlet" method="POST">
			<h1>Shopping Cart</h1>
			<table>
				<thead>
					<tr>
						<th>Product Name</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Action</th>
					</tr>
				</thead>
				
				<%
					String username = cookies.getCookies(request);
					
					UserDAO userdao = new UserDAO();
				
					User user = userdao.getUserData(username);
					
					CartDAO cartdao = new CartDAO();
					ResultSet cartItems = cartdao.getAllCartItems(username);
					
					float total = 0;
				%>
				
				<tbody>
				
					<%
						if(cartItems != null && user != null){
							while(cartItems.next()){
								total += cartItems.getFloat(6);
					%>			
								<tr>
									<td><%=cartItems.getString(4) %></td>
									<td><%=cartItems.getString(5) %></td>
									<td><%=cartItems.getFloat(6) %></td>
									
									<td>
										<a 
											href="../CartServlet?operation=deleteCartItem&cartid=<%=cartItems.getInt(1)%>"
										>
											<button type="button" class="delete">Delete</button>
										</a>
										
										<input type="hidden" name="cartIDs" value="<%=cartItems.getString(1)%>">
										<input type="hidden" name="productNames" value="<%=cartItems.getString(4)%>">
										<input type="hidden" name="productPrices" value="<%=cartItems.getString(5)%>">
										
									</td>
									
									
								</tr>
								
					<%			
							}
					%>
							<tr>
								<td> 
									<input type="hidden" name="operation" value="checkout">
									<input type="hidden" name="orderTotal" value="<%=total%>">
									<input type="hidden" name="username" value="<%=username%>">
									<input type="hidden" name="customerName" value="<%=user.getName()%>">
								</td>
							 </tr>	
					<%	
						}
					%>
					
				</tbody>
				<tfoot>
					<tr>
						<td colspan="2">Order Total:</td>
						<td>$<%=total %></td>
					</tr>
				</tfoot>
			</table>
			<%if (total != 0){ %>
				<button type="submit" class="checkout">Checkout</button>
			<%} %>
			<a href="../homepage.jsp"><button type="button" class="checkout" style="background-color:black;">Go to home page</button></a>
		</form>
	</div>
</body>
</html>
