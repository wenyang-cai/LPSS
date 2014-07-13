package connectionWeb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MySQLConnection;

/**
 * <p>
 * This Class handles the request for deleting user's book list.
 * </P>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class DeleteBookList extends HttpServlet {
	
	private static final long serialVersionUID = 8205045594445191761L;

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
		// Set respond content type
		response.setContentType("text/html");

		// Get book barcode
		String barcode = request.getParameter("barcode");

		// Connect database
		Connection con = MySQLConnection.connection();

		// Delete the book list
		try {
			Statement state = con.createStatement();
			String query = "DELETE from book_list WHERE barcode='" + barcode
					+ "'";

			state.executeUpdate(query);
			state.close();
			con.close();
		} catch (SQLException e) {

		}

		// refresh search page
		response.sendRedirect("/LPSS/search.jsp");
	}
}
