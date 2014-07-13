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
 * This class handle the request of forgetting password.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class ForgetPassword extends HttpServlet{

	private static final long serialVersionUID = 275196638835217531L;

	/**
	 * The doGet method of the servlet.
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
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.setAttribute("Forget", "Yes");
		// Refresh book page
		response.sendRedirect("/LPSS/index.jsp");
	}
}
