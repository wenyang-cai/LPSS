package connectionWeb;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.MD5Util;
import util.MySQLConnection;

/**
 * <p>
 * This class handles the request for changing password.
 * </p>
 * 
 * <p>
 * When the user willing to change their own password, the class will make sure
 * the old password is matched and the new password entered twice are the same.
 * </p>
 * 
 * <p>
 * If and only if all the condition satisfied the password could be changed.
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 */
public class ChangePassword extends HttpServlet {

	private static final long serialVersionUID = -4352065446327611756L;

	/**
	 * The doPost method of the servlet.
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * 
	 * @param response
	 *            the response send by the server to the client
	 * 
	 * @throws ServletException
	 *             if an error occurred
	 * 
	 * @throws IOException
	 *             if an error occurred
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Specify response transfer type
		response.setContentType("text/html");
		// Get user request
		HttpSession session = request.getSession();

		// Get first entered new password
		String new1 = request.getParameter("new1");
		// Get second entered new password
		String new2 = request.getParameter("new2");
		// Get user name stored in session
		String username = (String) session.getAttribute("User");
		// Get staff name stored in session
		String staffname = (String) session.getAttribute("Staff");

		// Get general user's old password
		String oldUser = request.getParameter("oldUser");
		// Get staff's old password
		String oldStaff = request.getParameter("oldStaff");
		
		// there is empty input
		if(oldUser==null){
			if(oldStaff.equals("")||new1.equals("")||new2.equals("")){
				session.setAttribute("ChangePassword", "No_empty");
				response.sendRedirect("/LPSS/personal.jsp");
				return;
			}
		}else{
			if(oldUser.equals("")||new1.equals("")||new2.equals("")){
				session.setAttribute("ChangePassword", "No_empty");
				response.sendRedirect("/LPSS/personal.jsp");
				return;
			}
		}

		// Check whether two new password are equal, If so, then check whether
		// the old password matches.
		if (new1.equals(new2)) {

			// Check old password in database and old password which user
			// entered are the same.
			if (oldUser != null) {
				try {
					// If old password user entered matches,
					// Delete the user and add new user with the same name and
					// new password.
					if (MD5Util.validUserPassword(username, oldUser)) {
						// Connect to database
						Connection con = MySQLConnection.connection();
						// Get session
						HttpSession s = request.getSession();

						// Get user name stored in the session
						String user = (String) s.getAttribute("User");

						// Create two empty string to template store user ID and
						// email.
						String ID = "";
						String email = "";

						// Try to find user who name is equal to current user's
						// name.
						// Get its ID and Email.
						try {
							Statement state = con.createStatement();
							String query = "SELECT * FROM general_user WHERE name='"
									+ user + "';";
							ResultSet rs = state.executeQuery(query);
							while (rs.next()) {
								ID = (String) rs.getString("ID");
								email = (String) rs.getString("email");
							}
							state.close();
							con.close();
						} catch (SQLException e) {
							session.setAttribute("ChangePassword", "No");
						}

						// Start database connection
						con = MySQLConnection.connection();

						// Query the database and delete the current user
						try {
							Statement state = con.createStatement();

							String query = "DELETE FROM general_user WHERE name='"
									+ user + "';";
							state.executeUpdate(query);

							state.close();
							con.close();
						} catch (SQLException e) {
							session.setAttribute("ChangePassword", "No");
						}

						// Add the new user with all information of current
						// user.
						try {
							if (MD5Util.addNewUser(user, Integer.parseInt(ID),
									email, new1)) {
								session.setAttribute("ChangePassword", "Yes");
							} else {
								session.setAttribute("ChangePassword", "No");
							}
						} catch (NoSuchAlgorithmException e) {
							session.setAttribute("ChangePassword", "No");
						}
					} else {
						session.setAttribute("ChangePassword", "No_oldPassword");
					}
				} catch (Exception e) {
					session.setAttribute("ChangePassword", "No");
				}
			} else {
				// If the current user is not a general user but a staff
				// Try valid current staff entered password
				// Then delete this staff and then add staff with the same
				// information with different password
				try {

					// If the old password entered is valid
					if (MD5Util.validStaffPassword(staffname, oldStaff)) {
						// Connect to database
						Connection con = MySQLConnection.connection();
						// Get session
						HttpSession s = request.getSession();

						// Get current staff name
						String user = (String) s.getAttribute("Staff");

						// Three string to store staff information
						String ID = "";
						String email = "";
						String position = "";

						// Try get staff information except password and salt
						try {
							Statement state = con.createStatement();

							String query = "SELECT * FROM staff WHERE name='"
									+ user + "';";
							ResultSet rs = state.executeQuery(query);

							while (rs.next()) {
								ID = (String) rs.getString("ID");
								email = (String) rs.getString("email");
								position = (String) rs.getString("position");
							}

							state.close();
							con.close();
						} catch (SQLException e) {
							session.setAttribute("ChangePassword", "No");
						}

						con = MySQLConnection.connection();

						// Try to delete this staff from website
						try {
							Statement state = con.createStatement();

							String query = "DELETE FROM staff WHERE name='"
									+ user + "';";
							state.executeUpdate(query);

							state.close();
							con.close();
						} catch (SQLException e) {
							session.setAttribute("ChangePassword", "No");
						}

						// Try to add a new staff with the same information
						// except new password and salt
						try {
							if (MD5Util.addNewStaff(user, Integer.parseInt(ID),
									email, new1, position)) {
								session.setAttribute("ChangePassword", "Yes");
							} else {
								session.setAttribute("ChangePassword", "No");
							}
						} catch (NoSuchAlgorithmException e) {
							session.setAttribute("ChangePassword", "No");
						}
					} else {
						session.setAttribute("ChangePassword", "No_oldPassword");
					}
				} catch (Exception e) {
					session.setAttribute("ChangePassword", "No");
				}
			}
		} else {
			session.setAttribute("ChangePassword", "No_noequals");
		}

		// Redirect to personal page
		response.sendRedirect("/LPSS/personal.jsp");
	}
}
