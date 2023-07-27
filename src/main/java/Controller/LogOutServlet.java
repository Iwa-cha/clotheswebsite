package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogOutServlet
 */
@WebServlet("/LogOutServlet")
public class LogOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogOutServlet() {
        super();
        // TODO Auto-generated constructor stub
    }



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Clear cookie
		Cookie[] cookies = request.getCookies();
		
    	if(cookies != null){
    		
	    	for(Cookie cookie : cookies){
	    		
	    		cookie.setMaxAge(0);
	    		response.addCookie(cookie);
	    	}
    	}
    	
        // Clear session
    	HttpSession session = request.getSession(false);
    	
    	if(session != null){
    		session.invalidate();
    	}
    	
    	response.sendRedirect("Pages/login.jsp");
		
	}

}
