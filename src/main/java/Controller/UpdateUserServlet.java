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
import model.Encryption;
import model.User;

/**
 * Servlet implementation class UpdateUserServlet
 */
@WebServlet("/UpdateUserServlet")
@MultipartConfig( fileSizeThreshold=1024*1024,
maxFileSize=1024*1024*5, maxRequestSize=1024*1024*5*5)
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out = response.getWriter();
		
		response.setContentType("text/html");
		
		String Fullname = request.getParameter("Fullname");
    	String Email = request.getParameter("Email");
    	String oldImg = request.getParameter("oldImg");
    	String Username = request.getParameter("Username");
    	String Password = request.getParameter("Password");
    	

    	Part imgPart = request.getPart("img");
    	
    	String imgUrl = ProductDAO.storeImg(imgPart);
    	
    	//String name, String username, String email, String password, String img
    	
    	User user = new User(Fullname, Username, Email, Password, oldImg);
    	
    	if(!imgUrl.equals("noImg")) {
    		user.setImg(imgUrl);
    	}
    	
    	try {
    		
    		UserDAO userdao = new UserDAO();
    		
			String msg = userdao.updateUserDetails(user);
			
			if(msg != null) {
				out.print("<h1>"+ msg + "</h1>");
				out.print("<div> <a href=\" Pages/profile.jsp \"> View Profile </a> </div>");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	
		
	}

}
