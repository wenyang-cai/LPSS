package connectionWeb;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.MD5Util;

/**
 * <p>
 * This class is used to check user login with password encoded
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class CheckLogin extends HttpServlet {

	private static final long serialVersionUID = 3016329378803842203L;

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

		// Get user name and password
		String username = request.getParameter("Username");
		String password = request.getParameter("Password");

		// check password with password encoding
		try {

			if (MD5Util.validStaffPassword(username, password)) {
				// Staff

				HttpSession session = request.getSession();

				session.setAttribute("Staff", username);
				session.setMaxInactiveInterval(60*5);
				session.setAttribute("Login", "Yes");

			} else if (MD5Util.validUserPassword(username, password)) {
				// User

				HttpSession session = request.getSession();

				session.setAttribute("User", username);
				session.setMaxInactiveInterval(60*5);
				session.setAttribute("Login", "Yes");

			} else {
				// Invalid

				HttpSession session = request.getSession();

				session.setAttribute("Login", "No");
			}

		} catch (Exception e) {

		}

		// refresh index page
		response.sendRedirect("/LPSS");
	}
}
