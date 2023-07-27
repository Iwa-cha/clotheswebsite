<%@page import="model.Product" %>
<%@page import="java.util.List" %>
<%@page import="DAO.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" href="../CSS/admin-dashboard.css" />
    
   <style type="text/css">
   
	   .admin-dashboard-wrapper .table-product {
	   		width:100%;
	   }
	   
	   	.table-product table{
	   		width:100%
	   	}
	   	
	   	.table-product table{
			border-collapse: collapse;
			border:1px solid black;  
	   	}
	   	
	   	.table-product table tr th{
	   		padding:10px 0px;
	   	}
   	
   		.table-product table tr td{
   			border-bottom:1px solid black; 
   			border-top:1px solid black; 
   			padding:10px 0px;
   		}
   	
 		.table-product table td{
 			text-align:center;
 		}
   
   </style>
   </head>
<body>
	 <section class="admin-dashboard-page">
      <div class="admin-dashboard-wrapper">
        <div class="admin-dashboard-1">
          <div style="text-align:center;">
          	<p>Admin</p>
          <p>admin@gmail.com</p>
          </div>
          <br />
          <div class="admin-links">
            <a href="admin-dashboard.jsp">Dashboard</a>
            <br />
            <a href="admin-add-product.html">Add Product</a>
            <br />
            <a href="view-orders.jsp?viewBy=admin">Orders</a>
            <br />
            <a href="product.jsp">Go to product page</a>
          </div>
        </div>
        <div class="admin-dashboard-2">
          
          <div class="products">
            <h3>Products</h3>
            <div class="table-product">
            
              <table>
              
                <tr>
                	<th> SN </th>  
                	<th> Name </th> 
                	<th> Brand </th> 
                	<th> Price </th>  
                	<th> Stock </th>  
                </tr>
                
                <%	
	        	
	        		int sn = 1;
	        		List<Product> products = ProductDAO.fetchProductsFromDB();
	        		for(Product p: products){
	        	%>
	        			
			             <tr>
			             	<td><%=sn++%></td>
			             	<td><%=p.getName() %></td>
			              	<td><%=p.getBrand()%></td>
			                <td>$<%=p.getPrice() %></td>
			              	<td><%=p.getStock()%></td>
			              	
			              	<td>
			              		<a href="edit-product.jsp?productID=<%=p.getId()%>"><button>Edit</button></a>
			              	<td>
			              	
			              	<td>
			              		<form action="../ProductOperationServlet" method="post">
			              			<input type="hidden" name="operation" value="delete product" required>
			              			<input type="hidden" name="id" value="<%=p.getId() %>" required>
			              			<input type="submit" value="delete">
			              		</form>
			              	<td>
			              	
			             </tr>
			     <%}%>
                
              </table>
              
            </div>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>
	

