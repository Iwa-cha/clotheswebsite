package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DAO.ProductDAO;
import DAO.UserDAO;
import model.User;

/**
 * Servlet implementation class userRegister
 */
@WebServlet("/userRegister")
@MultipartConfig( fileSizeThreshold=1024*1024,
maxFileSize=1024*1024*5, maxRequestSize=1024*1024*5*5)

public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
				
		response.setContentType("text/html");
		
		String Fullname = request.getParameter("Fullname");
    	String Username = request.getParameter("Username");
    	String Email = request.getParameter("Email");
    	String Password = request.getParameter("Password");
    	
    	Part imgPart = request.getPart("img");
    	
    	String imgUrl = ProductDAO.storeImg(imgPart);
    	
    	User user = new User(Fullname, Username, Email, Password, imgUrl);
    	
    	UserDAO userdao = new UserDAO();
    	
    	try {
			String msg = userdao.registerUser(user);
			
			if(msg != null) {
				out.print("<h1>"+ msg + "</h1>");
				out.print("<div><a href=\" homepage.jsp \"> Go to Home Page </a> </div>");
				out.print("<div> <a href=\" Pages/Register.jsp \"> Go to Register Page </a> </div>");
			}
			
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	
	}
}


