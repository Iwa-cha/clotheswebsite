<%@page import="utils.cookies"%>
<%@page import="DAO.OrderDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>View Orders</title>
	
	<Style>
		.container{
			margin:auto;
			width:80%
		}
		/* table styles */
		table {
		  border-collapse: collapse;
		  width: 100%;
		  margin-bottom: 20px;
		}
		
		th, td {
		  padding: 8px;
		  text-align: left;
		  border-bottom: 1px solid #ddd;
		}
		
		th {
		  background-color: #f2f2f2;
		}
		
		tr:hover {
		  background-color: #f5f5f5;
		}
		
		/* button styles */
		.view-items-btn {
		  background-color: #4CAF50;
		  border: none;
		  color: white;
		  padding: 8px 16px;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 14px;
		  margin: 4px 2px;
		  cursor: pointer;
		  border-radius: 4px;
		}
		
		.view-items-btn:hover {
		  background-color: #3e8e41;
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
		
				
	</Style>
	
</head>
<body>
	<div class="container">
		<h1>View Orders</h1>
		
		
		<table>
			<thead>
				<tr>
					<th>SN</th>
					<th>Customer Name</th>
					<th>Order Total</th>
					<th>Order Date</th>
					<th>View Items</th>
				</tr>
			</thead>
			<tbody>
			
			<%! String viewOrdersBy;%>
			
					<%
						viewOrdersBy = request.getParameter("viewBy"); 
						OrderDAO orderdao = new OrderDAO();
					
						ResultSet rs = orderdao.getAllOrderDetails();
						
						int sn = 1;
						
						String username = cookies.getCookies(request);
						
						while(rs != null && rs.next()){
							
							if(viewOrdersBy.equals("user") && username != null && rs.getString(2).equals(username)){
					%>
	
								<tr>
									<td><%=sn++ %></td>
									<td><%=rs.getString(5) %></td>
									<td>$<%=rs.getFloat(3) %></td>
									<td><%=rs.getString(4).replace("T", " ").substring(0, 19) %></td>
									<td><a href="view-order-items.jsp?viewBy=user&orderID=<%=rs.getInt(1)%>">View Items</a></td>
								</tr>
					<%		} else if(viewOrdersBy.equals("admin") && viewOrdersBy != null){ %>
					
					<tr>
									<td><%=sn++ %></td>
									<td><%=rs.getString(5) %></td>
									<td>$<%=rs.getFloat(3) %></td>
									<td><%=rs.getString(4).replace("T", " ").substring(0, 19) %></td>
									<td><a href="view-order-items.jsp?viewBy=admin&orderID=<%=rs.getInt(1)%>">View Items</a></td>
								</tr>
					<%		}
						}
					%>
				<!-- add more rows for additional orders -->
			</tbody>
			
		</table>
		
		<%if(viewOrdersBy.equals("admin")){%>
	
			<a href="admin-dashboard.jsp"><button class="checkout">Go to dashboard page</button></a>		
		
		<%} else {%>
			<a href="../homepage.jsp"><button class="checkout">Go to Home page</button></a>	
		<%}%>
	</div>
</body>
</html>
    