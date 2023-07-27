<%@page import="utils.cookies"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="model.Product"%>
<%@page import="DAO.ProductDAO"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Products</title>
    
    <link rel="stylesheet" href="../CSS/style.css" />
    <link rel="stylesheet" href="../CSS/product.css" />
    
    <style type="text/css">
    	
	.search-box{
		display:flex;
		justify-content: center;
		align-content: center;
		margin: 30px 0;
	}
	
	.search-box div input{
		width:350px;
		height: 40px;
		padding:0 10px;
	}
	
	.search-box div select{
		height: 40px;
	}
	
	.clothe-product-page .image-row-1{
	  display: flex;
	  flex-wrap:wrap;
	  gap:30px;
	  justify-content: start;
	}
	
	.productImg img{
		width: 240px;
		height:240px;
		object-fit:cover;
	}
    
    </style>
    
  </head>
<body>
    <section class="wrapper-home-page">
      <header class="header">
        <div class="logo-header">
          <h1>Glamela</h1>
        </div>

        <ul class="links">
          <li><a href="../homepage.jsp">Home</a></li>
          <li><a href="product.jsp">Product</a></li>
          <li><a href="login.jsp">Dashbord</a></li>
        </ul>

        <div class="cart-account-search">
	       <%
        	String userLoggedIn = cookies.getCookies(request);
        	
        	if(userLoggedIn != null){
        		out.print("<a href=\"profile.jsp\">Profile</a> | ");
    			out.print(" <a href=\"view-cart.jsp\">Cart</a> | ");
    			out.print(" <a href=\"../LogOutServlet\">Signout</a>");
        	}
        	 else{
     			out.print("<a href=\"login.jsp\">Log In</a>");
     		}
        %>
          
        </div>
      </header>
      
      <div class="search-box">
      
      	<div>
	      	<form method="GET">
	      		<select name="filterBy" required>
		      		<option value=""> Select One </option>
		      		<option value="category">Category</option>
		      		<option value="price">Price</option>
		      		<option value="brand">Brand</option>
	      		</select>
	      	
	      		<input type="search" name="q" required>
	      	</form>
      	</div>
      	
      </div>
      
      <div class="product-page-body-wrapper">
      
        <div class="category-product-page">
          <h3>Category</h3>
          <p><a href="product.jsp">view all</a></p>
          <p><a href="product.jsp?filterBy=category&q=men">Men</a></p>
          <p><a href="product.jsp?filterBy=category&q=women">Women</a></p>
          
          <br>
          
          <h3>Brand</h3>
          <p><a href="product.jsp?filterBy=brand&q=zara">Zara</a></p>
          <p><a href="product.jsp?filterBy=brand&q=addidas">Addidas</a></p>
          <p><a href="product.jsp?filterBy=brand&q=lewis">lewis</a></p>
          
          <br>
          
          <h3>Price</h3>
          <form>
          	<input type="hidden" name="filterBy" value="price">
          	<input type="number" name="q" step="any"/>
          	<button style="width:80px;">filter</button>
          </form>
          
           <br>
          
          <h3>Rating</h3>
          <form>
          	<input type="hidden" name="filterBy" value="rating">
          	<input type="number" name="q" step="any"/>
          	<button style="width:80px;">filter</button>
          </form>

        </div>
        
        <div class="clothe-product-page">
        
        	<div class="image-row-1">
        	
        	<%
        	
        		String filterBy =request.getParameter("filterBy");
        		String value = request.getParameter("q");
        		
        		ProductDAO productdao = new ProductDAO();
        		List<Product> products = productdao.filterProduct(filterBy,value);
        		
        		for(Product p: products){
        	
        	
        	%>
	          
			            <div class="image-1">
			          
			          	<div class="productImg">
			          		    <img src="http://localhost:8080/Images/<%=p.getImg()%>" alt="" />
			          	</div>  
			          
			              <p><%=p.getName() %></p>
			              <p><%=p.getBrand() %> || $<%=p.getPrice() %></p>
			              <p>rating(<%=p.getRating()%>) || stock(<%=p.getStock()%>)</p>
			              
						<form action="../CartServlet" method="POST">
							
							<input type="hidden" name="id" value="<%=p.getId()%>"> 
							<input type="hidden" name="productname" value="<%=p.getName()%>"> 
							<input type="hidden" name="price" value="<%=p.getPrice()%>">
							<input type="hidden" name="username" value="<%=userLoggedIn%>"> 
							<input type="hidden" name="operation" value="addProduct"> 
							
							<%
								if(userLoggedIn != null){
									out.print("<button type=\"submit\" style=\"padding:5px 10px; margin-top:10px;\">Add to cart</button>");
								}
							%>
						
						</form>
			              
			            </div>
			           
			       
			          
			     <%}%>
		     
			</div>
         	
	
        </div>
      </div>
      <footer class="footer">
        <div class="footer-section">
          <div class="logo-footer">
            <h1>Glamela</h1>
            <p>Putalisadak, Kathmandu</p>
            <p>01-1425252</p>
            <p>01-9077474</p>
          </div>
          <div class="quick-links">
            <a href="../homepage.html">Home</a>
            <a href="Product.html">Product</a>
            <a href="Contactus.html">Contact us</a>
          </div>
          <div class="follow-us">
            <img src="../Images/fb.png" alt="" />
            <img src="../Images/insta.jpg" alt="" />
            <img src="../Images/twitter.png" alt="" />
          </div>
        </div>
      </footer>
    </section>
  </body>
</html>
