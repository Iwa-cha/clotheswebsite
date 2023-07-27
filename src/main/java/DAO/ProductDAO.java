package DAO;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

import model.Product;
import utils.cookies;

public class ProductDAO {
	
	public static List<Product> fetchProductsFromDB(){
		
		
		List<Product> products = new ArrayList<Product>();
		
		Connection con = DBConnection.getDbConnection();
		
		String query = "select * from products"	;
	
		if(con != null) {
			
			try {
				
				PreparedStatement st = con.prepareStatement(query);
				
				ResultSet rs = st.executeQuery();
				
				while(rs.next()) {
					
					Product product = new Product(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getFloat(6), rs.getFloat(7), rs.getInt(8));
					product.setId(rs.getInt(1));
					products.add(product);

				}
				
				return products;
						
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}	
		}
		
		return null;
	}
	
	
	public  List<Product> filterProduct(String filterBy, String value) {
		
		List<Product> newProducts = new ArrayList<Product>();		
		List<Product> products = fetchProductsFromDB();
		
		if(filterBy != null && value != null) {
			
			try {
				
				for(Product p: products) {
					
					if(filterBy.equals("category") && p.getCategory().equals(value.toLowerCase())) {
						
						newProducts.add(p);
						
					} else if(filterBy.equals("brand") && p.getBrand().equals(value.toLowerCase())) {
						newProducts.add(p);
						
					} else if(filterBy.equals("price") && p.getPrice() == Float.parseFloat(value)) {
						newProducts.add(p);
						
					} else if(filterBy.equals("rating") && p.getRating() == Float.parseFloat(value)) {
						newProducts.add(p);
					}
					
				}
				
			} catch (NumberFormatException e) {

				return products;
			}
			
			
			
		} else {
			newProducts = products;
		}
		
		
		return newProducts;
		
	}
	
	

	public static String storeImg(Part imgPart) {
		
			String fileDir = "xampp\\tomcat\\webapps\\ROOT\\Images\\";
			String filePath = "C:" + File.separator + fileDir;
			
			File fileSaveDir = new File(filePath);
			
			String imageUrlFromPart = null;
			
			if (!fileSaveDir.exists()) {
				fileSaveDir.mkdir();
			}
			
			String contentDisp = imgPart.getHeader("content-disposition");
			
			String[] items = contentDisp.split(";");
			
			
			for (String s : items) {
				if (s.trim().startsWith("filename")) {
					imageUrlFromPart = s.substring(s.indexOf("=") + 2, s.length() - 1);
				}
			}
			
			if(imageUrlFromPart == null || imageUrlFromPart.isEmpty()) {
				imageUrlFromPart = "noImg";
			}
			
			try {
				if (!imageUrlFromPart.isEmpty() && imageUrlFromPart != null) {
					imgPart.write(filePath + imageUrlFromPart);
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		
			return imageUrlFromPart;
	}
	
	
	public Boolean addProduct(Product product) {
		
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
					
			String query = "INSERT INTO products(name, brand, category, img, price, rating, stock) VALUES(?,?,?,?,?,?,?)";
		
			try {
				
				PreparedStatement statement = con.prepareStatement(query);
				
				statement.setString(1, product.getName());
				statement.setString(2,product.getBrand());
				statement.setString(3,product.getCategory());
				statement.setString(4, product.getImg());
				statement.setFloat(5,product.getPrice());
				statement.setFloat(6,product.getRating());
				statement.setInt(7,product.getStock());

				int rows = statement.executeUpdate();		
				
				if(rows > 0) {
					return true;
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
		
		return false;
	}
	
	
	public Product getProductById(int productID) throws SQLException, IOException {
		
		Connection con = DBConnection.getDbConnection();
		
		
		if(con != null) {
			
			String query = "SELECT * FROM PRODUCTS WHERE ID = ?";
			
			PreparedStatement st = con.prepareStatement(query);
			
			st.setInt(1, productID);
			
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				
				Product product = new Product(rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getFloat(6), rs.getFloat(7), rs.getInt(8));
				
				return product;		
				
			}

		}
		
		return null;	
		
	}
	
	
	public Boolean updateProductInfo(Product product){
		
		Connection con = DBConnection.getDbConnection();
		
		String query = "UPDATE Products SET name = ?, brand = ?, category = ?, price = ?, rating = ?, stock = ? WHERE id = ?";
		
		if(con != null) {
			
			try {
				
				PreparedStatement st = con.prepareStatement(query);
				
				st.setString(1, product.getName());
				st.setString(2, product.getBrand());
				st.setString(3, product.getCategory());
				st.setFloat(4, product.getPrice());
				st.setFloat(5, product.getRating());
				st.setInt(6, product.getStock());
				st.setInt(7, product.getId());
				
				int rows = st.executeUpdate();
				
				if(rows > 0) {
					return true;
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
			
			
			
		}
		
		return false;
	}
	
	
	public Boolean deleteProduct(int productID) {
		
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
			
			String query = "DELETE FROM products WHERE id = ?";
			
			try {
				
				PreparedStatement st = con.prepareStatement(query);
				
				st.setInt(1, productID);
				
				int result = st.executeUpdate();

				
				if(result > 0) {
					return true;
				}
				
			} catch (SQLException e) {
				
				return false;
			}

		}
		
		return false;
		
	}
	
	
}
