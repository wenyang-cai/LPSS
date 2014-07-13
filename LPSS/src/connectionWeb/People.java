package connectionWeb;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * <p>
 * This class handle the request of people JSP.
 * </p>
 * <p>
 * When user chooses different options, the session will record the number.
 * It will display on the web of people JSP.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class People extends HttpServlet {
	private static final long serialVersionUID = 6219974856423796878L;
	private String option="5";
	
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
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		
		option = request.getParameter("option");
		session.setAttribute("People", option);

		response.sendRedirect("/LPSS/people.jsp");
	}
}
