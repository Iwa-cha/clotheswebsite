package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import DAO.UserDAO;
import model.User;

/**
 * Servlet implementation class UserLogInServlet
 */
@WebServlet("/UserLogInServlet")
public class UserLogInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLogInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		response.setContentType("text/html");
		
    	String Username = request.getParameter("Username");
    	String Password = request.getParameter("Password");
    	
    	UserDAO userdao = new UserDAO();
    	
    	if(Username.equals("admin") && Password.equals("admin")) {
    		
    		response.sendRedirect("Pages/admin-dashboard.jsp");
    		
    	} else {
    		
    		try {

    			String msg = userdao.login(Username, Password);
    			
    			if(msg.equals("Password Matched")) {
    				
    				HttpSession session = request.getSession();
    				session.setAttribute("usersession", "log in session");
    				session.setMaxInactiveInterval(30*60);
    				
    				Cookie cookieObj = new Cookie("userData", Username);
    				
    				cookieObj.setMaxAge(30*60);
    				
    				response.addCookie(cookieObj);
    				
    				response.sendRedirect("homepage.jsp");
    				
    			} else if(msg != null) {
    				out.print("<h1>"+ msg + "</h1>");
    				out.print("<div><a href=\" Pages/login.jsp \"> Go to log in Page </a> </div>");
    				out.print("<div> <a href=\" Pages/Register.jsp \"> Go to Register Page </a> </div>");
    			}
    			
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    	}
    	
	}

}
