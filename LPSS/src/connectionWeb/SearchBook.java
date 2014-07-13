package connectionWeb;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * <p>
 * This Class handles the request for searching books.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class SearchBook extends HttpServlet {

	private static final long serialVersionUID = -6653066473904929268L;

	/**
	 * Name of library, for distinguishing libraries. Could be "lib1", "lib2",
	 * "lib3".
	 */
	private String libraryName = null;

	/**
	 * The attribute with which a book is searched. Could be "title", "author",
	 * "callNumber".
	 */
	private String bookOption = null;

	/**
	 * The keyword for searching books.
	 */
	private String keyword = "";

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
		// Get user request
		HttpSession session = request.getSession();

		// Get library name
		String a = request.getParameter("Library");
		if (a.equals("1")) {
			libraryName = "lib1";
		} else if (a.equals("2")) {
			libraryName = "lib2";
		} else if (a.equals("3")) {
			libraryName = "lib3";
		}

		// Get library name
		String b = request.getParameter("Option");
		if (b.equals("1")) {
			bookOption = "title";
		} else if (b.equals("2")) {
			bookOption = "author";
		} else if (b.equals("3")) {
			bookOption = "callNumber";
		}

		// Get keyWord
		keyword = (String) (request.getParameter("KeyWord")).trim();

		// Show user's options
		session.setAttribute("libraryName", libraryName);
		session.setAttribute("bookOption", bookOption);
		session.setAttribute("keyword", keyword);

		// Show user's options
		response.sendRedirect("/LPSS/search.jsp");
	}
}