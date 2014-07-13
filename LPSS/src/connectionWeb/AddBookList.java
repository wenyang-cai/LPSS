package connectionWeb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.MySQLConnection;

/**
 * <p>
 * This class handles the request for adding book list.
 * </p>
 * <p>
 * When the user request to add a book list, this class will first search for
 * the book in the library according to barcode to find the book's in the
 * database then add it to particular user's book list.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class AddBookList extends HttpServlet {
	
	private static final long serialVersionUID = -3462656656288424187L;

	/**
	 * The doGet method of the servlet.
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Specify content type
		response.setContentType("text/html");
		// Get book barcode from web
		String barcode = request.getParameter("barcode");
		// Get user request
		HttpSession s = request.getSession();
		// Get user name
		String user = (String) s.getAttribute("User");
		// Connect to database
		Connection con = MySQLConnection.connection();
		
		String ID = null;
		// Connect and send operating command
		try {
			Statement state = con.createStatement();

			String query = "SELECT ID FROM general_user WHERE name='" + user
					+ "';";
			ResultSet rs = state.executeQuery(query);
			
			// Get book ID
			while (rs.next()) {
				ID = (String) rs.getString("ID");
			}
			
			// close connection
			state.close();
			con.close();
		} catch (SQLException e) {

		}
		
		// Connect to database
		con = MySQLConnection.connection();
		
		// Send operating command to insert book list to database
		try {
			Statement state = con.createStatement();
			String query = "INSERT INTO book_list VALUES('" + user + "','" + ID
					+ "','" + barcode + "')";

			state.executeUpdate(query);
			state.close();
			con.close();
		} catch (SQLException e) {

		}
		
		// Refresh the search page
		response.sendRedirect("/LPSS/search.jsp");
	}
}
