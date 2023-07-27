<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
 <link rel="stylesheet" href="../CSS/style.css" />
    <link rel="stylesheet" href="../CSS/login.css" />
</head>
<body>
 <div class="wrapper-login">
      <div class="login">
        <h1>Login</h1>
        <div class="Login_form">
          <form action="../UserLogInServlet" method="POST">
          
            <label>UserName</label>
            <input type="text" placeholder="" name="Username"/>
            <label>Password</label>
            <input type="Password" placeholder="" name="Password"/>
  
            <div class="Loginbutton">
              <button type="submit">Login</button>
            </div>

            <p>
              	Already have an account?
              	<a href="Register.jsp">Sign in</a>
            </p>
            
             <p>
              	<a href="../homepage.jsp">Go to home page</a>
            </p>
            
          </form>
        </div>
      </div>
    </div>
  </body>
</html>

