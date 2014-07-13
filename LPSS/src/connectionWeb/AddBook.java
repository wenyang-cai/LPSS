package connectionWeb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.MySQLConnection;

/**
 * 
 * <p>
 * This class handle the request of adding books.
 * </p>
 * <p>
 * When the user request to add books to library, this class try to connect to
 * library and send a operating command to database to add a book with relevant
 * information from web.
 * </p>
 * <p>
 * If the user have no authority to add the book then database will denied the
 * operation.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class AddBook extends HttpServlet {

	private static final long serialVersionUID = 4166021500856262397L;

	/**
	 * The doPost method of the servlet.
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
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
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Get the user request
		HttpSession session = request.getSession();
		// Specify transfer type
		response.setContentType("text/html");

		// Get attributes of a book
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String publisher = request.getParameter("publisher");
		String barcode = request.getParameter("barcode");

		String status = request.getParameter("status");
		if (status.equals("1")) {
			status = "Borrowed";
		} else if (status.equals("2")) {
			status = "Returned";
		}

		String callNumber = request.getParameter("callNumber");
		String nameOfShelf = request.getParameter("nameOfShelf");

		String libraryName = request.getParameter("libraryName");
		if (libraryName.equals("1")) {
			libraryName = "lib1";
		} else if (status.equals("2")) {
			libraryName = "lib2";
		} else {
			libraryName = "lib3";
		}

		String copy = request.getParameter("copy");

		if (title.equals("") || author.equals("") || publisher.equals("")
				|| barcode.equals("") || callNumber.equals("")
				|| nameOfShelf.equals("") || copy.equals("")) {
			session.setAttribute("AddBook", "No_empty");
			response.sendRedirect("/LPSS/book.jsp");
			return;
		}

		try {
			Integer.parseInt(copy);
		} catch (Exception e) {
			session.setAttribute("AddBook", "No_noint");
			response.sendRedirect("/LPSS/book.jsp");
			return;
		}

		// Connect to database
		Connection con = MySQLConnection.connection();

		// send operating command to database if successful then return message
		// yes else return message no.
		try {
			Statement state = con.createStatement();
			String query = "INSERT INTO book VALUES('" + title + "','" + author
					+ "','" + publisher + "','" + barcode + "','" + status
					+ "','" + callNumber + "','" + nameOfShelf + "','"
					+ libraryName + "','" + Integer.parseInt(copy) + "')";

			if(state.executeUpdate(query)==1){
				session.setAttribute("AddBook", "Yes");	
			}else{
				session.setAttribute("AddBook", "No");
			}
			state.close();
			con.close();
			
		} catch (Exception e) {
			session.setAttribute("AddBook", "No");
		}

		// Refresh book page
		response.sendRedirect("/LPSS/book.jsp");
	}
}
