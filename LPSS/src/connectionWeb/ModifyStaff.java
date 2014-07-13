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
 * This Class handles the request for modifying staffs.
 * </p>
 * <p>
 * This class allows a high-level user to modify the staffs' data.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class ModifyStaff extends HttpServlet {

	private static final long serialVersionUID = 8308349710182119088L;

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
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Set response content type
		response.setContentType("text/html");
		// Get user request
		HttpSession session = request.getSession();

		// Get user Name ID new Position user entered
		String name = request.getParameter("name");
		String ID = request.getParameter("ID");
		
		String newPosition = request.getParameter("newPosition");
		
		if(name.equals("")||ID.equals("")||newPosition.equals("")){
			session.setAttribute("ModifyStaff", "No_empty");
			response.sendRedirect("/LPSS/people.jsp");
			return;
		}
		// Authority Control
		if (newPosition.equals("1")) {
			newPosition = "Curator";
		} else if (newPosition.equals("2")) {
			newPosition = "Database Administer";
		} else if (newPosition.equals("3")) {
			newPosition = "Senior Librarian";
		}else{
			newPosition = "Junior Librarian";
		}

		// Connect to database
		Connection con = MySQLConnection.connection();

		// Update the staff information
		try {
			Statement state = con.createStatement();

			String query = "UPDATE staff SET position='" + newPosition
					+ "' WHERE name='" + name + "' and ID='" + ID + "';";
			if(state.executeUpdate(query)==1){
				session.setAttribute("ModifyStaff", "Yes");
			}else{
				session.setAttribute("ModifyStaff", "No_nostaff");
			}

			state.close();
			con.close();
			
		} catch (SQLException e) {
			session.setAttribute("ModifyStaff", "No");
		}

		// Refresh people page
		response.sendRedirect("/LPSS/people.jsp");
	}
}
