package util;

import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * <p>
 * MD5Util.java
 * </p>
 * 
 * <p>
 * This class store some important public methods.
 * <ul>
 * <li>1. {@link MD5Util#addNewStaff addNewStaff}: This method is used to add a
 * new staff to the database.</li>
 * <li>2. {@link MD5Util#addNewUser addNewUser}: This method is used to add a
 * new general user to database.</li>
 * <li>3. {@link MD5Util#validStaffPassword validStaffPassword}: This method is
 * used to valid a password with staff's password.</li>
 * <li>4. {@link MD5Util#validUserPassword validUserPassword}: This method is
 * used to valid a password with a user's password.</li>
 * <li>5. {@link MD5Util#getSalt getSalt}: This method is used to generate a
 * salt.</li>
 * <li>6. {@link MD5Util#getEncryptedPwd getEncryptedPwd}: This method is used
 * to use a password and salt get encrypted password.</li>
 * <li>7. {@link MD5Util#hexStringToByte hexStringToByte}: THis method is used
 * to convert a hexadecimal string to byte array.</li>
 * <li>8. {@link MD5Util#byteToHexString byteToHexString}: This method is used
 * to convert a byte array to a hexadecimal string.</li>
 * <li>9. {@link MD5Util#main main}: The main method is used to add initialized
 * user to the database.</li>
 * </ul>
 * </p>
 * 
 * @author Xueli Jia
 * @author Yiming Li
 * @author Zhao Zhao
 * @version 1.8
 * 
 */
public class MD5Util {
	/**
	 * Define salt length equal to 12
	 */
	private static final int SALT_LENGTH = 12;

	/**
	 * Define Hexadecimal string is equal to "0123456789ABCDEF"
	 */
	private static final String HEX_NUMS_STR = "0123456789ABCDEF";

	/**
	 * Convert a byte array to a hexadecimal string.
	 * 
	 * @param b
	 *            Byte array
	 * @return A hexadecimal string
	 */
	public static String byteToHexString(byte[] b) {
		StringBuffer hexString = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1)
				hex = '0' + hex;
			hexString.append(hex.toUpperCase());
		}
		return hexString.toString();
	}

	/**
	 * Convert a hexadecimal string to byte array.
	 * 
	 * @param hex
	 *            A hex String
	 * @return A byte array
	 */
	public static byte[] hexStringToByte(String hex) {
		int len = (hex.length() / 2);
		byte[] result = new byte[len];
		char[] hexChars = hex.toCharArray();
		for (int i = 0; i < len; i++) {
			int pos = i * 2;
			result[i] = (byte) (HEX_NUMS_STR.indexOf(hexChars[pos]) << 4 | HEX_NUMS_STR
					.indexOf(hexChars[pos + 1]));
		}
		return result;
	}

	/**
	 * Randomly generate a salt.
	 * 
	 * @return salt
	 */
	public static byte[] getSalt() {
		SecureRandom random = new SecureRandom();
		byte[] salt = new byte[SALT_LENGTH];
		random.nextBytes(salt);
		return salt;
	}

	/**
	 * Use a password and salt get encrypted password.
	 * 
	 * @param password
	 *            A password
	 * @param salt
	 *            A salt
	 * @return Encrypted password
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 */
	public static String getEncryptedPwd(String password, byte[] salt)
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		byte[] pwd = null;
		MessageDigest md = null;
		md = MessageDigest.getInstance("MD5");
		md.update(salt);
		md.update(password.getBytes("UTF-8"));
		byte[] digest = md.digest();
		pwd = new byte[digest.length + SALT_LENGTH];
		System.arraycopy(salt, 0, pwd, 0, SALT_LENGTH);
		System.arraycopy(digest, 0, pwd, SALT_LENGTH, digest.length);
		md.update(pwd);
		return byteToHexString(md.digest());
	}

	/**
	 * Add a new staff to the database.
	 * 
	 * @param name
	 *            Staff name
	 * @param ID
	 *            Staff ID
	 * @param email
	 *            Staff E-mail
	 * @param password
	 *            Staff password
	 * @param position
	 *            Staff position
	 * @return Whether the add operation is successful
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 * @throws FileNotFoundException
	 */
	public static boolean addNewStaff(String name, int ID, String email,
			String password, String position) throws NoSuchAlgorithmException,
			UnsupportedEncodingException, FileNotFoundException {
		byte[] salt = getSalt();
		Connection con = MySQLConnection.connection();
		try {
			Statement state = con.createStatement();
			String query = "INSERT INTO staff VALUES('" + name + "','" + ID
					+ "','" + email + "','" + getEncryptedPwd(password, salt)
					+ "','" + byteToHexString(salt) + "','" + position + "')";
			state.executeUpdate(query);
			state.close();
			con.close();
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * Add a new general user to database.
	 * 
	 * @param name
	 *            General User name
	 * @param ID
	 *            General User ID
	 * @param email
	 *            General User E-mail
	 * @param password
	 *            General User password
	 * @return Whether the add operation is successful.
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 * @throws FileNotFoundException
	 */
	public static boolean addNewUser(String name, int ID, String email,
			String password) throws NoSuchAlgorithmException,
			UnsupportedEncodingException, FileNotFoundException {
		byte[] salt = getSalt();
		Connection con = MySQLConnection.connection();
		try {
			Statement state = con.createStatement();
			String query = "INSERT INTO general_user VALUES('" + name + "','"
					+ ID + "','" + email + "','"
					+ getEncryptedPwd(password, salt) + "','"
					+ byteToHexString(salt) + "')";
			state.executeUpdate(query);
			state.close();
			con.close();
		} catch (SQLException e) {
			return false;
		}
		return true;
	}

	/**
	 * Valid a password with staff's password.
	 * 
	 * @param username
	 *            Staff Name
	 * @param password
	 *            A password
	 * @return Whether the password is equal to staff's password
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 * @throws FileNotFoundException
	 */
	public static boolean validStaffPassword(String username, String password)
			throws NoSuchAlgorithmException, UnsupportedEncodingException,
			FileNotFoundException {
		Connection con = MySQLConnection.connection();
		try {
			Statement state = con.createStatement();
			String query = "SELECT salt,password FROM staff WHERE name='"
					+ username + "'";
			ResultSet rs = state.executeQuery(query);
			while (rs.next()) {
				if (getEncryptedPwd(password,
						hexStringToByte(rs.getString("salt"))).equals(
						rs.getString("password")))
					return true;
			}
			state.close();
			con.close();
		} catch (SQLException e) {

		}
		return false;
	}

	/**
	 * Valid a password with a user's password.
	 * 
	 * @param username
	 *            User Name
	 * @param password
	 *            A password
	 * @return Whether the password is the same with the user's password
	 * @throws NoSuchAlgorithmException
	 * @throws UnsupportedEncodingException
	 * @throws FileNotFoundException
	 */
	public static boolean validUserPassword(String username, String password)
			throws NoSuchAlgorithmException, UnsupportedEncodingException,
			FileNotFoundException {
		Connection con = MySQLConnection.connection();
		try {
			Statement state = con.createStatement();
			String query = "SELECT salt,password FROM general_user WHERE name='"
					+ username + "'";
			ResultSet rs = state.executeQuery(query);
			while (rs.next()) {
				if (getEncryptedPwd(password,
						hexStringToByte(rs.getString("salt"))).equals(
						rs.getString("password")))
					return true;
			}
			state.close();
			con.close();
		} catch (SQLException e) {

		}
		return false;
	}

	// Initialize staff and user into database.
	public static void main(String[] args) throws NoSuchAlgorithmException,
			UnsupportedEncodingException, FileNotFoundException {
		addNewStaff("staff0", 200800000, "staff0@liv.ac.uk", "123456", "Curator");
		addNewStaff("staff1", 200800001, "staff1@liv.ac.uk", "123456", "Curator");
		addNewStaff("staff2", 200800002, "staff2@liv.ac.uk", "123456",
				"Database Administer");
		addNewStaff("staff3", 200800003, "staff3@liv.ac.uk", "123456",
				"Database Administer");
		addNewStaff("staff4", 200800004, "staff4@liv.ac.uk", "123456",
				"Senior Librarian");
		addNewStaff("staff5", 200800005, "staff5@liv.ac.uk", "123456",
				"Senior Librarian");
		addNewStaff("staff6", 200800006, "staff6@liv.ac.uk", "123456",
				"Junior Librarian");
		addNewStaff("staff7", 200800007, "staff7@liv.ac.uk", "123456",
				"Junior Librarian");

		addNewUser("user0", 200811110, "user0@liv.ac.uk", "123456");
		addNewUser("user1", 200811111, "user1@liv.ac.uk", "123456");
		addNewUser("user2", 200811112, "user2@liv.ac.uk", "123456");
		addNewUser("user3", 200811113, "user3@liv.ac.uk", "123456");
		addNewUser("user4", 200811114, "user4@liv.ac.uk", "123456");
		addNewUser("user5", 200811115, "user5@liv.ac.uk", "123456");
		addNewUser("user6", 200811116, "user6@liv.ac.uk", "123456");
		addNewUser("user7", 200811117, "user7@liv.ac.uk", "123456");
	}
}
