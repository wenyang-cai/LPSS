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
 * This class handles the request for adding a book to the operation list.
 * </p>
 * <p>
 * After user searched some book then can add the book to the operation list,
 * then the user can search for the path to get those books in operation list.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class AddOperationList extends HttpServlet {

	private static final long serialVersionUID = -5363783975081640482L;

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
		// Specify response content type to web
		response.setContentType("text/html");
		// Get book barcode
		String barcode = request.getParameter("barcode");
		// Get user request
		HttpSession s = request.getSession();

		// Create a arraylist to hold the barcode
		@SuppressWarnings("unchecked")
		ArrayList<String> list = (ArrayList<String>) s.getAttribute("Barcode");

		if (list == null) {
			list = new ArrayList<String>();
		}

		// Avoid add same book to operation list
		boolean flag = false;
		for (int i = 0; i < list.size(); i++) {
			if (barcode.equals(list.get(i))) {
				flag = true;
			}
		}
		if (flag == false) {
			list.add(barcode);
		}

		s.setAttribute("Barcode", list);

		// refresh search page
		response.sendRedirect("/LPSS/search.jsp");
	}
}
