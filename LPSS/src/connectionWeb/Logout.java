package connectionWeb;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * <p>
 * This Class handles the request for logging out.
 * </p>
 * <p>
 * If user logout then the web will clear everything in session.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */

public class Logout extends HttpServlet {

	private static final long serialVersionUID = -8902240121484130265L;

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
		// Set response type
		response.setContentType("text/html");
		// Get user request
		HttpSession session = request.getSession();

		// Set all the attribute in session to null
		session.setAttribute("Staff", null);
		session.setAttribute("User", null);
		session.setAttribute("Barcode", null);
		session.setAttribute("People", null);
		session.setAttribute("Personal", null);
		session.setAttribute("AddBook", null);
		session.setAttribute("AddStaff", null);
		session.setAttribute("ModifyStaff", null);
		session.setAttribute("DeleteStaff", null);
		session.setAttribute("ChangePassword", null);
		session.setAttribute("libraryName", null);
		session.setAttribute("bookOption", null);
		session.setAttribute("keyword", null);
		session.setAttribute("page", null);
		session.setAttribute("warning",null);
		// Redirect to index page
		response.sendRedirect("/LPSS/index.jsp");
	}
}
