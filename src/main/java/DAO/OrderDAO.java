package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;

import model.User;

public class OrderDAO {
	
	public int placeOrder(String username, String orderTotal, String customerName) throws SQLException {
		
		Connection con = DBConnection.getDbConnection();
		String query = "INSERT INTO ORDERS(username,customerName, orderTotal, orderDate) VALUES(?,?,?,?);";
		
		if(con != null) {
				
				LocalDateTime orderDate = LocalDateTime.now();
				
				PreparedStatement st = con.prepareStatement(query,Statement.RETURN_GENERATED_KEYS );
				
				st.setString(1, username);
				st.setString(2, customerName);
				st.setDouble(3, Double.parseDouble(orderTotal));
				st.setString(4, orderDate.toString());
				
				int result = st.executeUpdate();
				
				ResultSet rs = st.getGeneratedKeys();
				
			    while(rs.next()) {
			    	int orderId = rs.getInt(1);
					
					if(result > 0) {
						return orderId;
					}
			    }
			    
			   
		}
		
		return 0;

	}
	
	public String addOrderItem(int orderID, String productname, String price) throws SQLException {
		
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
			
			String addItem = "insert into orderitem(orderid, productName, price, quantity) values(?,?,?,?)";
			
			PreparedStatement st2 = con.prepareStatement(addItem);
			st2.setInt(1, orderID);
			st2.setString(2, productname);
			st2.setFloat(3, Float.parseFloat(price));
			st2.setInt(4, 1);
		
			int result = st2.executeUpdate();
			
			if(result > 0) {
				return "Thank you for your purchase!";
			}

		}
		
		return null;
	}
	
	
	public ResultSet getAllOrderDetails() throws SQLException {
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
			String selectOrders = "SELECT * FROM ORDERS";
			PreparedStatement st = con.prepareStatement(selectOrders);
			ResultSet rs = st.executeQuery();
			
			return rs;
			
		}
		
		return null;
			
	}
	
	public ResultSet getOrderItems(String orderID) throws SQLException {
		
		Connection con = DBConnection.getDbConnection();
		
		if(con != null) {
			String selectOrderItems = "SELECT * FROM ORDERITEM WHERE ORDERID = ?";
			
			PreparedStatement st = con.prepareStatement(selectOrderItems);
			
			st.setInt(1, Integer.parseInt(orderID));
			
			ResultSet rs = st.executeQuery();
			
			return rs;
			
		}
		
		return null;
			
	}
	
	
	
}
