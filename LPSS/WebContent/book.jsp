<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang -->

<!-- Package to use -->
<%@ page import="util.MySQLConnection"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>Books</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	function Auto() {
<%HttpSession s = request.getSession();
if ((String) session.getAttribute("User") == null
					&& (String) session.getAttribute("Staff") == null) {
				// return to home page
				response.sendRedirect("/LPSS/index.jsp");
			}else{
			// track the session and get the information of user
			
			String user = (String) session.getAttribute("Staff");

			// connect to MySQL and by the staff name to get the information of position
			Connection con = MySQLConnection.connection();
			String position = "";
			try {
				Statement state = con.createStatement();

				String query = "SELECT * FROM staff WHERE name='" + user + "';";
				ResultSet rs = state.executeQuery(query);

				while (rs.next()) {
					position = (String) rs.getString("position");
					state.close();
					con.close();
				}
			} catch (Exception e) {

			}
			// only Curator, Database Administer and Senior Librarian can go into this web
			// and add the information of books
			if (!position.equals("Curator")
					&& !position.equals("Database Administer")
					&& !position.equals("Senior Librarian")) {
				session.setAttribute("warning", "Yes");
				// return to page coming
				String p = (String) session.getAttribute("page");
				response.sendRedirect("/LPSS/" + p);

			} else {
				if (session.getAttribute("warning") != null) {%>
				TINY.box.show('warning.jsp', 1, 200, 200, 1);
				<%}
				session.setAttribute("warning", null);
				session.setAttribute("page", "book.jsp");
			}}%>
	}
</script>
<link href="css/tinyBox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/tinybox.js"></script>
<script type="text/javascript">
	function Help() {
		TINY.box.show('help.jsp', 1, 480, 600, 1);
	}
</script>
</head>
<body onload="Auto()">
	<!-- head begin-->
	<div id="head">
		<img src="images/head.gif" border="0" usemap="#Map" />
		<map name="Map" id="Map">
			<area shape="rect" coords="81,19,280,77" href="index.jsp" />
			<area shape="rect" coords="979,30,1031,53" href="index.jsp" />
			<area shape="rect" coords="1041,30,1081,53" onclick="Help()" />
			<area shape="rect" coords="1091,28,1147,54" href="logout" />
			<area shape="rect" coords="1154,25,1180,53" href="index.jsp" />
		</map>
	</div>
	<!-- head end-->
	<div class="mid">
		<ul class="mainNav">
			<li class="hover"><a href="index.jsp">Home</a></li>
			<li><a href="personal.jsp">Personal</a></li>
			<li><a href="search.jsp">Search</a></li>
			<li><a href="people.jsp">People</a></li>
			<li><a href="book.jsp">Books</a></li>
			<li><a href="maps.jsp">Maps</a></li>
			<li class="last"><a href="about.jsp">About us</a></li>
		</ul>

		<div class="main">
			<div class="mainTop"></div>
			<div class="mainNr" align="center">
				<form action="addBook" method="post">
					<table width="381" height="392" align="center" class="personalBd">
						<tr>
							<td align="right">Title</td>
							<td><input type="text" name="title" /></td>
						</tr>
						<tr>
							<td align="right">Author</td>
							<td><input type="text" name="author" /></td>
						</tr>
						<tr>
							<td align="right">Publisher</td>
							<td><input name="publisher" type="text" size="20" /></td>
						</tr>
						<tr>
							<td align="right">Barcode</td>
							<td><input name="barcode" type="text" size="20" /></td>
						</tr>
						<tr>
							<td align="right">Status</td>
							<td><select name="status">
									<option value="1" selected="selected">Borrowed</option>
									<option value="2">Returned</option>
							</select></td>
						</tr>

						<tr>
							<td align="right">CallNumber</td>
							<td><input name="callNumber" type="text" size="20" /></td>
						</tr>
						<tr>
							<td align="right">NameOfShelf</td>
							<td><input type="text" name="nameOfShelf" /></td>
						</tr>

						<tr>
							<td align="right">LibraryName</td>
							<td><select name="libraryName">
									<option value="1" selected="selected">Library1</option>
									<option value="2">Library2</option>
									<option value="3">Library3</option>
							</select></td>
						</tr>

						<tr>
							<td align="right">Copy</td>
							<td><input type="text" name="copy" /></td>
						</tr>
						<tr>
							<td></td>
							<td><input type="submit" value="Load" /> <input
								type="reset" value="Reset" /></td>
						</tr>
						<%
							// get the information of AddBook sesstion to display different sentence
							if (s.getAttribute("AddBook") != null) {
								if (s.getAttribute("AddBook").equals("No")) {
						%>
						<tr>
							<td colspan="2"><font color="#FF0000">There is
									something wrong!</font></td>
						</tr>
						<%
							// empty input and should hint user to check it
								} else if (s.getAttribute("AddBook").equals("No_empty")) {
						%>
						<tr>
							<td colspan="2"><font color="#FF0000">There is an
									empty input and please check it.</font></td>
						</tr>
						<%
							// copy is not integer and should hint user to check it
								} else if (s.getAttribute("AddBook").equals("No_noint")) {
						%>
						<tr>
							<td colspan="2"><font color="#FF0000">The copy should
									be integer.</font></td>
						</tr>
						<%
							// load into database successfully
								} else if (s.getAttribute("AddBook").equals("Yes")) {
						%>
						<tr>
							<td colspan="2">You have loaded into database successfully.</td>
						</tr>
						<%
							}
								// set it to original value of null
								s.setAttribute("AddBook", null);
							}
						%>
					</table>
				</form>
				<div class="clearit"></div>
			</div>
			<div class="mainFoot"></div>
		</div>

		<div id="foot">
			<img src="images/foot.gif" />
		</div>
	</div>
</body>
</html>