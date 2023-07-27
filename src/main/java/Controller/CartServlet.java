package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CartDAO;
import DAO.OrderDAO;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String operation = request.getParameter("operation");
		String cartID = request.getParameter("cartid");
		CartDAO cartdao = new CartDAO();
		PrintWriter out = response.getWriter();
		
		response.setContentType("text/html");
    	
    	if(operation != null && operation.equals("deleteCartItem")) {
    		try {
    			String msg  = cartdao.deleteCartItem(cartID);
    			
    			if(msg != null) {
    				out.print("<h1>"+ msg + "</h1>");
    				out.print("<div><a href=\" Pages/product.jsp \"> Go to product Page </a> </div>");
    				out.print("<div><a href=\" Pages/view-cart.jsp \"> View Cart </a> </div>");
    			}
    			
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
    	} 
    	
    
        
    	
    }
    


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String operation = request.getParameter("operation");
		String productID = request.getParameter("id");
		String price = request.getParameter("price");
		String username = request.getParameter("username");
		String productname = request.getParameter("productname");
		
		PrintWriter out = response.getWriter();
		
		response.setContentType("text/html");
		
		CartDAO cartdao = new CartDAO();
		
		String msg = null;
		
		
		if(operation != null && operation.equals("addProduct")) {
			
			try {
				 msg = cartdao.addProductToCart(username, productID, price, productname);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
	if(operation != null && operation.equals("checkout")) {
    		
    		String[] cartIDs = request.getParameterValues("cartIDs");
    		String[] productNames = request.getParameterValues("productNames");
    		String[] productPrices = request.getParameterValues("productPrices");
    		
    		String orderTotal = request.getParameter("orderTotal");
    		String customerName = request.getParameter("customerName");
    		
    		OrderDAO orderdao = new OrderDAO();
    		
    		try {
    			
				int oderID = orderdao.placeOrder(username, orderTotal,customerName);
				
				for(int i = 0; i < cartIDs.length; i++) {
					msg = orderdao.addOrderItem(oderID, productNames[i], productPrices[i]);
					cartdao.deleteCartItem(cartIDs[i]);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	  		
    	}
    	
		
		if(msg != null) {
			out.print("<h1>"+ msg + "</h1>");
			out.print("<div><a href=\" Pages/product.jsp \"> Go to product Page </a> </div>");
			out.print("<div><a href=\" Pages/view-cart.jsp \"> View Cart </a> </div>");
		}
		
	}

}
