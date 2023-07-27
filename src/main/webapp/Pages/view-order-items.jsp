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
		<h1>Order Items list</h1>
		
		
		<table>
			<thead>
				<tr>
					<th>SN</th>
					<th>Product Name</th>
					<th>Price</th>
					<th>Quantity</th>
				</tr>
			</thead>
			<tbody>
			
					<%! String viewOrdersBy;%>
			
					<%
						viewOrdersBy = request.getParameter("viewBy");
						String orderID = request.getParameter("orderID");
						OrderDAO orderdao = new OrderDAO();
					
						ResultSet rs = orderdao.getOrderItems(orderID);
						
						int sn = 1;
						
						String username = cookies.getCookies(request);
						
						while(rs != null && rs.next()){
					%>
				
							<tr>
								<td><%=sn++ %></td>
								<td><%=rs.getString(2) %></td>
								<td>$<%=rs.getFloat(3) %></td>
								<td><%=rs.getInt(4) %></td>
							</tr>
					<%
						}
					%>
				<!-- add more rows for additional orders -->
			</tbody>
			
		</table>
		
		<%if(viewOrdersBy.equals("admin")){%>

			<a href="view-orders.jsp?viewBy=admin"><button class="checkout">View Orders</button></a>		
		
		<%} else {%>
			<a href="view-orders.jsp?viewBy=user"><button class="checkout">View Orders</button></a>	
		<%}%>
	</div>
</body>
</html>
    