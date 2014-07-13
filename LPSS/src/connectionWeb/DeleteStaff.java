package connectionWeb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.MySQLConnection;

/**
 * <p>
 * This Class handles the request for deleting staff
 * </p>
 * <p>
 * This class allows high-level user to delete his staffs
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class DeleteStaff extends HttpServlet {

	private static final long serialVersionUID = -4784422959936942088L;

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

		// Get entered name and ID
		String name = request.getParameter("name");
		String ID = request.getParameter("ID");

		if(name.equals("")||ID.equals("")){
			session.setAttribute("DeleteStaff", "No_empty");
			response.sendRedirect("/LPSS/people.jsp");
			return;
		}
		// Connect database
		Connection con = MySQLConnection.connection();

		// Delete staff
		try {
			Statement state = con.createStatement();

			String query = "DELETE FROM staff WHERE name='" + name
					+ "' and ID='" + ID + "';";
			if(state.executeUpdate(query)==1){
				session.setAttribute("DeleteStaff", "Yes");
			}else{
				session.setAttribute("DeleteStaff", "No_nostaff");
			}

			state.close();
			con.close();
			
		} catch (SQLException e) {
			session.setAttribute("DeleteStaff", "No");
		}

		// refresh people page
		response.sendRedirect("/LPSS/people.jsp");
	}
}
