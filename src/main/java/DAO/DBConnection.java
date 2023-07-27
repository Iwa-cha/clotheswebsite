package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBConnection {	
	
	private static Connection con = null;
	
	
	public static  Connection getDbConnection() {
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String URL = "jdbc:mysql://localhost:3306/Glamela";
		String user = "root";
		String pass = "";
		
		con = DriverManager.getConnection(URL, user, pass);
		
	} catch (SQLException | ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	return con;
}
}
