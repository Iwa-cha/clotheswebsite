package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.User;

public class CartDAO {
	
	public String addProductToCart(String username, String productID, String price, String productname) throws SQLException {
		
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
			
			UserDAO userdao = new UserDAO();
			
			User user = userdao.getUserData(username);
			
			String fetchCartItemQuery = "select * from cartitems where userid = ? and productid = ?";
			
			PreparedStatement st = con.prepareStatement(fetchCartItemQuery);
			
			st.setInt(1, user.getId());
			st.setInt(2, Integer.parseInt(productID));
			
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				return "Item Already Exists in cart";
			}
			
			String addItem = "insert into cartitems(userid, productid, quantity, price, productname) values(?,?,?,?,?)";
			
			PreparedStatement st2 = con.prepareStatement(addItem);
			st2.setInt(1, user.getId());
			st2.setInt(2, Integer.parseInt(productID));
			st2.setInt(3, 1);
			st2.setFloat(4, Float.parseFloat(price));
			st2.setString(5, productname);
			
			int result = st2.executeUpdate();
			
			if(result > 0) {
				return "Item is added to the cart";
			}

		}
		
		return null;

	}
	
	
	public ResultSet getAllCartItems(String username) throws SQLException {
		
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
			
			String selectQuery = "SELECT * FROM cartitems";
			
			PreparedStatement st = con.prepareStatement(selectQuery);
			
			return st.executeQuery();
			
		}
		
		return null;
	}
	
	
	public String deleteCartItem(String cartID) throws SQLException {
		
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
			
			String deleteQuery = "DELETE FROM cartitems where cartid = ?";
			
			PreparedStatement st = con.prepareStatement(deleteQuery);
			
			st.setInt(1, Integer.parseInt(cartID));
			
			int result = st.executeUpdate();
			
			if(result > 0) {
				return "CART ITEM DELETED SUCESSFULLY";
			}
			
		}
		
		return null;
	}
	
}
