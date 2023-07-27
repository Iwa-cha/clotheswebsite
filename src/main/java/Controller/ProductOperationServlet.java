package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DAO.ProductDAO;
import model.Product;

/**
 * Servlet implementation class ProductOperationServlet
 */
@WebServlet("/ProductOperationServlet")
@MultipartConfig(maxFileSize = 16177215)
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductOperationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
String operation = request.getParameter("operation");
		
		PrintWriter out = response.getWriter();
		
		response.setContentType("text/html");
	
		
		if(operation.equals("add product")) {
			
			String name = request.getParameter("name");
			String brand = request.getParameter("brand");
			String category = request.getParameter("category");
			float price = Float.parseFloat(request.getParameter("price"));
			float rating = Float.parseFloat(request.getParameter("rating"));
			int stock = Integer.parseInt(request.getParameter("stock"));
			
			Part img = request.getPart("img");
			
			ProductDAO productdao = new ProductDAO();
			
			String imgName = ProductDAO.storeImg(img);
			
			Product product = new Product(name, brand, category, imgName, price, rating, stock);
			
			Boolean productAdded = productdao.addProduct(product);	
			
			if(productAdded) {
				
				out.print("<h1> Product Added </h1>");
				out.print("<a href=\" Pages/admin-dashboard.jsp \"> Go to Dashboard </a>");
				
			}
			
		}
		
		
		if(operation.equals("editProduct")) {
			
			String name = request.getParameter("name");
			String brand = request.getParameter("brand");
			String category = request.getParameter("category");
			float price = Float.parseFloat(request.getParameter("price"));
			float rating = Float.parseFloat(request.getParameter("rating"));
			int stock = Integer.parseInt(request.getParameter("stock"));
			
			String productCategory = category;
			String productBrand = brand;
			int id = Integer.parseInt(request.getParameter("id"));
			
			if(category.equals("")) {
				productCategory = request.getParameter("oldCategory");
			}
			
			if(brand.equals("")) {
				productBrand = request.getParameter("oldBrand");
			}
			

			Product product = new Product(name, productBrand, productCategory, "", price, rating, stock);
			product.setId(id);
			
			ProductDAO productdao = new ProductDAO();
			
			Boolean productInfoUpdated = productdao.updateProductInfo(product);
			
			if(productInfoUpdated) {
				
				out.print("<h1>Product Detials Updated</h1>");
				
				out.print("<a href=\" Pages/admin-dashboard.jsp \"> Go to Dashboard </a>");
				
			}
						
		}
		
		
		if(operation.equals("delete product")) {
			
			int id = Integer.parseInt(request.getParameter("id"));
			
			ProductDAO productdao = new ProductDAO();
			
			Boolean productDeleted = productdao.deleteProduct(id);
			
			if(productDeleted) {
				out.print("<h1>Product Deleted Updated</h1>");
				
				out.print("<a href=\" Pages/admin-dashboard.jsp \"> Go to Dashboard </a>");
			}
			
		}
		
	}

}
