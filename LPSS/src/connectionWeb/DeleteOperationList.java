package connectionWeb;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * <p>
 * This Class handles the request for deleting user's operation list.
 * </p>
 * <p>
 * This class allows user to delete their operation list. when the user logout
 * the operation list will also be deleted.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class DeleteOperationList extends HttpServlet {
	
	private static final long serialVersionUID = -1833224465135985750L;

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
		// Set response content type
		response.setContentType("text/html");

		// Set response content type
		String barcode = request.getParameter("barcode");

		// Get user request
		HttpSession s = request.getSession();

		// Get the list
		@SuppressWarnings("unchecked")
		ArrayList<String> list = (ArrayList<String>) s.getAttribute("Barcode");

		// Remove the barcode
		list.remove(barcode);
		s.setAttribute("Barcode", list);

		// Remove the barcode
		response.sendRedirect("/LPSS/search.jsp");
	}
}
