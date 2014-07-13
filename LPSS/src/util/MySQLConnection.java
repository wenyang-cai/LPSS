package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * <p>
 * This Class handles connection with MySQL.
 * </p>
 * <p>
 * It will use username and password to connect the MySQL and return the
 * connection for other classes to use.
 * </p>
 * 
 * @author Yiming Li, Jiazhe Wang
 * @version 1.8
 * 
 */
public class MySQLConnection {

	public static Connection connection() {
		Connection con = null;
		// driver
		// mysql-connector-java-5.1.18-bin.jar
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
		// get connection using username(root) and password(123456)
		// if you get this from github, change the username and password below!!!
		try {
			con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/lpss", "root", "CHANGE_YOUR_PASSWORD_HERE!!!");
		} catch (SQLException el) {
			el.printStackTrace();
		}
		return con;
	}
}
