<%@page import="utils.cookies"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home Page</title>
    <link rel="stylesheet" href="CSS/style.css" />
    <link rel="stylesheet" href="CSS/homepage.css" />
    <script
      src="https://kit.fontawesome.com/1c6c06e40c.js"
      crossorigin="anonymous"
    ></script>
    
    <style>
    	.image-banner h4{
    		font-family:'Times New Roman', Times, serif;
    		font-weight: 100;
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
          <li><a href="homepage.jsp">Home</a></li>
          <li><a href="Pages/product.jsp">Product</a></li>
           <li><a href="Pages/login.jsp">Dashbord</a></li>
        </ul>

        <div class="cart-account-search">
        
        <%
        	String userLoggedIn = cookies.getCookies(request);
        	
        	if(userLoggedIn != null){
        		out.print("<a href=\"Pages/profile.jsp\">Profile</a> | ");
    			out.print(" <a href=\"Pages/view-cart.jsp\">Cart</a> | ");
    			out.print(" <a href=\"LogOutServlet\">Signout</a>");
        	}
        	 else{
     			out.print("<a href=\"Pages/login.jsp\">Log In</a>");
     		}
        %>

        </div>
      </header>
      <div id="drop-down-user">
        <div class="prof-header">
          <img src="Images/twitter.png" alt="" />
          <h3>James Shrestha</h3>
        </div>
        <br />
        <hr />
        <br />
        <div class="prof-contents">
          <a href="">Edit Profile</a>
          <a href="">History</a>
          <a href="">Change Password</a>
          <a href="">Logout</a>
        </div>
      </div>
      <div class="home-page-body-wrapper">
        <div class="image-banner">
          <h4><i>"You are the one who defines your own beauty, not society out there." <br> - Singer Lady Gaga</i></h4>
        </div>
        <h1>Men's Collection</h1>
        <div class="men-collection">
          <div class="men-image-1">
            <img src="Images/white-suit.jpg" alt="" />
            <p>White Suit</p>
            <p>Louis Vuittons</p>
            <p>$212.01</p>
          </div>
          <div class="men-image-2">
            <img src="Images/black-shirt.jpg" alt="" />
            <p>Black Shirt</p>
            <p>Gucci</p>
            <p>$100.01</p>
          </div>
          <div class="men-image-3">
            <img src="Images/henly-shirt.jfif" alt="" />
            <p>Henly Shirt</p>
            <p>Louis Vuittons</p>
            <p>$300.01</p>
          </div>
        </div>
        <h1>Women's Collection</h1>
        <div class="women-collection">
          <div class="women-image-1">
            <img src="Images/V-neck.jpg" alt="" />
            <p>V-neck Sweater</p>
            <p>Louis Vuittons</p>
            <p>$500.01</p>
          </div>
          <div class="women-image-2">
            <img src="Images/elie.jpg" alt="" />
            <p>Elie Suit</p>
            <p>Gucci</p>
            <p>$250.01</p>
          </div>
          <div class="women-image-3">
            <img src="Images/tanktop.jpg" alt="" />
            <p>Tank Top</p>
            <p>Gucci</p>
            <p>$350.01</p>
          </div>
        </div>
      </div>
      <br />
      <footer class="footer">
        <div class="footer-section">
          <div class="logo-footer">
            <h1>Glamela</h1>
            <p>Putalisadak, Kathmandu</p>
            <p>01-1425252</p>
            <p>01-9077474</p>
          </div>
          <div class="quick-links">
            <a href="#">Home</a>
            <a href="#">Product</a>
            <a href="#">Contact us</a>
          </div>
          <div class="follow-us">
            <img src="Images/fb.png" alt="" />
            <img src="Images/insta.jpg" alt="" />
            <img src="Images/twitter.png" alt="" />
          </div>
        </div>
      </footer>
    </section>
  </body>
</html>
    