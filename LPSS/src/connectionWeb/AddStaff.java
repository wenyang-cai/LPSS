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
 * This Class handles the request for adding a staff.
 * </p>
 * 
 * <p>
 * When a user request for adding a staff, This class will get relevant staff
 * information and check format then add it to the database.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class AddStaff extends HttpServlet {

	private static final long serialVersionUID = 6751934887809865640L;

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
		// Set response content type
		response.setContentType("text/html");
		// Get user request
		HttpSession session = request.getSession();

		// Get the new staff's information
		String name = request.getParameter("name");
		String ID = request.getParameter("ID");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		if(name.equals("")||ID.equals("")||email.equals("")||password.equals("")){
			session.setAttribute("AddStaff", "No_empty");
			response.sendRedirect("/LPSS/people.jsp");
			return;
		}
		String position = request.getParameter("position");

		// Authority Control
		if (position.equals("1")) {
			position = "Curator";
		} else if (position.equals("2")) {
			position = "Database Administer";
		} else if (position.equals("3")) {
			position = "Senior Librarian";
		}else{
			position = "Junior Librarian";
		}
		
		// Try to add staff
		try {
			if (MD5Util.addNewStaff(name, Integer.parseInt(ID), email,
					password, position)) {
				session.setAttribute("AddStaff", "Yes");
			} else {
				session.setAttribute("AddStaff", "No");
			}
		} catch (Exception e) {
			session.setAttribute("AddStaff", "No");
		}

		// Try to add staff
		response.sendRedirect("/LPSS/people.jsp");
	}
}
