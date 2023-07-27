package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.catalina.connector.Response;

import model.Encryption;
import model.User;

public class UserDAO {

	public String registerUser(User user) throws SQLException {
		
    	Connection con = DBConnection.getDbConnection();
    	
    	if(con != null) {
    		
    		String getUserDataQuery = "Select * from sign_up where username = ?";
    		PreparedStatement st1 = con.prepareStatement(getUserDataQuery);
    		
    		st1.setString(1, user.getUsername());
    		
    		ResultSet rs = st1.executeQuery();
    		
    		while(rs.next()) {
    			return "User Exists";
    		}
    		
    		String insertUserData = "Insert into sign_up(Fullname, Username, Email, Password, img) values(?,?,?,?,?)";
        	PreparedStatement st2 = con.prepareStatement(insertUserData);

        	String encryptedPass = Encryption.encrypt(user.getUsername(), user.getPassword());
        	
        	st2.setString(1, user.getName());
        	st2.setString(2, user.getUsername());
        	st2.setString(3, user.getEmail());
        	st2.setString(4, encryptedPass);
        	st2.setString(5, user.getImg());
        	
        	int result = st2.executeUpdate();
        	
        	if(result > 0) {
        		return "User Registered";
        	} 
    	}
    	
		return null;
	  
	}
	
	
	public String login(String username, String password) throws SQLException {
		
    	Connection con = DBConnection.getDbConnection();
    	
    	if(con != null) {
    		
    		String getUserDataQuery = "Select user_id, username, password  from sign_up where username = ?";
    		PreparedStatement st1 = con.prepareStatement(getUserDataQuery);
    		
    		st1.setString(1, username);
    		ResultSet rs = st1.executeQuery();
    		
    		while(rs.next()) {
    			
    			String pass = Encryption.decrypt(rs.getString(3), rs.getString(2));
    			
    			if(pass.equals(password)) {
    				return "Password Matched";
    			} else {
    				return "Wrong Password";
    			}
    			
    		}
    		
    		return "User Not Found";
    	}
    	
		return null;
	}
	
	public User getUserData(String username) throws SQLException {
		
    	Connection con = DBConnection.getDbConnection();
    	
    	if(con != null) {
    		
    		String getUserDataQuery = "Select * from sign_up where username = ?";
    		PreparedStatement st1 = con.prepareStatement(getUserDataQuery);
    		
    		st1.setString(1, username);
    		
    		ResultSet rs = st1.executeQuery();
    		
    		//String name, String username, String email, String password, String img
    		
    		
    		while(rs.next()) {
    			User user = new User(rs.getString(2),rs.getString(3),rs.getString(4), rs.getString(5), rs.getString(6));
    			user.setId(rs.getInt(1));
    			return user;
    		}
    		
    	}
    	
		return null;
	  
	}
	
	public String updateUserDetails(User user) throws SQLException {
		Connection con = DBConnection.getDbConnection();
    	
    	if(con != null) {
    		
    		String updateDetailsWithPWQuery = "UPDATE sign_up SET fullname = ?, email = ?, img = ?, password = ? WHERE username = ?";
    		String updateDetailsWithOutPWQuery = "UPDATE sign_up SET fullname = ?, email = ?, img = ? WHERE username = ?";
    		
    		PreparedStatement st = null;
    			
    		if(user.getPassword() == null) {
    			st = con.prepareStatement(updateDetailsWithOutPWQuery);
    			st.setString(4, user.getUsername());
    		} else {
    			st = con.prepareStatement(updateDetailsWithPWQuery);
    			String encryptedPass = Encryption.encrypt(user.getUsername(), user.getPassword());
    			st.setString(4, encryptedPass);
    			st.setString(5, user.getUsername());
    		} 
    		
    		st.setString(1, user.getName());
    		st.setString(2, user.getEmail());
    		st.setString(3, user.getImg());
    		
    		int result = st.executeUpdate();
    		
    		if(result > 0) {
    			return "USER DETAILS UPDATED";
    		}
    	}
    	
    	return null;
	}
	
	
}
