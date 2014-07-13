<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>Personal</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	function Auto() {
<%// judge if the user logs in
			HttpSession s = request.getSession();
			if ((String) session.getAttribute("User") == null
					&& (String) session.getAttribute("Staff") == null) {
				// return to home page
				response.sendRedirect("/LPSS/index.jsp");

			} else {
				if (session.getAttribute(
	"warning") != null) {%>
		TINY.box.show('warning.jsp'
, 1, 200, 200, 1);
				<%}
				session.setAttribute("warning", null);
				session.setAttribute("page", "personal.jsp");
			}%>
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
			<div class="mainNr">
				<div class="left02">
					<img src="images/leftNavBt4.gif" />
					<div class="kg3_center" style="height: 500px;">
						<ul class="leftNav">
							<li><a href="personal?option=0">Account INFO.</a></li>
							<li><a href="personal?option=1">Change Password</a></li>
						</ul>
						<%
							// general user will have borrow list and favorite list
							if ((String) session.getAttribute("User") != null) {
						%>
						<img src="images/leftNavBt5.gif" />
						<ul class="leftNav">
							<li><a href="personal?option=2">Borrowed List</a></li>
							<li><a href="personal?option=3">Favorite List</a></li>
						</ul>
						<%
							} else {
								// staff will have to-do-list
						%>
						<img src="images/leftNavBt6.gif" />
						<ul class="leftNav">
							<li><a href="personal?option=4">My To-Do List</a></li>
						</ul>
						<%
							}
						%>
					</div>
					<div class="kg3_foot"></div>
				</div>

				<div class="right02">
					<img src="images/PersonalBanner.jpg" width="819" height="119" />
					<div class="topBj"></div>
					<div>
						<div class="kg4_top"></div>
						<div class="kg4_center"
							style="height: 407px; overflow-x: hidden; overflow-y: auto;">
							<!-- Package to use -->
							<%@ page import="util.*"%>
							<%@ page import="java.util.*"%>
							<%@ page import="java.sql.*"%>
							<%
								// connect to mysql 
								Connection con = MySQLConnection.connection();
								if (session.getAttribute("Personal") != null) {
									// display the personal information of general user
									// get from database
									if (session.getAttribute("Personal").equals("0")
											&& session.getAttribute("User") != null) {
										String name = (String) session.getAttribute("User");
										String ID = "";
										String email = "";
										try {
											Statement state = con.createStatement();

											// get name, ID and email
											String query = "SELECT * FROM general_user WHERE name='"
													+ name + "';";
											ResultSet rs = state.executeQuery(query);

											while (rs.next()) {
												ID = (String) rs.getString("ID");
												email = (String) rs.getString("email");
											}

											state.close();
											con.close();
										} catch (SQLException e) {

										}
							%>
							<table>
								<tr>
									<td>Name:</td>
									<td><%=name%></td>
								</tr>
								<tr>
									<td>ID:</td>
									<td><%=ID%></td>
								</tr>
								<tr>
									<td>email:</td>
									<td><%=email%></td>
								</tr>
							</table>

							<%
								} else if (session.getAttribute("Personal").equals("0")
											&& session.getAttribute("Staff") != null) {
										// display the personal information of staff
										// get from database
										String name = (String) session.getAttribute("Staff");
										String ID = "";
										String email = "";
										String position = "";
										try {
											Statement state = con.createStatement();
											// get ID, name, email and postion
											String query = "SELECT * FROM staff WHERE name='"
													+ name + "';";
											ResultSet rs = state.executeQuery(query);

											while (rs.next()) {
												ID = (String) rs.getString("ID");
												email = (String) rs.getString("email");
												position = (String) rs.getString("position");
											}

											state.close();
											con.close();
										} catch (SQLException e) {

										}
							%>
							<table>
								<tr>
									<td>Name:</td>
									<td><%=name%></td>
								</tr>
								<tr>
									<td>ID:</td>
									<td><%=ID%></td>
								</tr>
								<tr>
									<td>email:</td>
									<td><%=email%></td>
								</tr>
								<tr>
									<td>position:</td>
									<td><%=position%></td>
								</tr>
							</table>
							<%
								} else if (session.getAttribute("Personal").equals("1")
											&& session.getAttribute("User") != null) {
										// change password by general user
							%>
							<form action="changePassword" method="post">
								<table align="center">
									<tr>
										<td>Old password:</td>
										<td><input type="password" name="oldUser" /></td>
									</tr>
									<tr>
										<td>New password:</td>
										<td><input type="password" name="new1" /></td>
									</tr>
									<tr>
										<td>Password confirm:</td>
										<td><input type="password" name="new2" /></td>
									</tr>
									<tr>
										<td><input type="submit" value="Change" /></td>
										<td><input type="reset" value="Reset" /></td>
									</tr>
									<%
										// exception
												// No_empty: there is an empty input
												// No_equals: new password do not match
												// No_oldPassword: input wrong old password
												if (s.getAttribute("ChangePassword") != null) {
													if (s.getAttribute("ChangePassword").equals("No_empty")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">There is an
												empty input and please check it.</font></td>
									</tr>
									<%
										} else if (s.getAttribute("ChangePassword").equals(
															"No_noequals")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">New
												passwords do not match.</font></td>
									</tr>
									<%
										} else if (s.getAttribute("ChangePassword").equals(
															"No_oldPassword")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">Old
												passwords are wrong.</font></td>
									</tr>
									<%
										} else if (s.getAttribute("ChangePassword")
															.equals("No")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">There is
												something wrong!</font></td>
									</tr>

									<%
										} else if (s.getAttribute("ChangePassword").equals(
															"Yes")) {
									%>
									<tr>
										<td colspan="2">You have changed password successfully.</td>
									</tr>
									<%
										}
													// set to original value of null
													s.setAttribute("ChangePassword", null);
												}
									%>

								</table>
							</form>
							<%
								} else if (session.getAttribute("Personal").equals("1")
											&& session.getAttribute("Staff") != null) {
										// change password of staff
							%>
							<form action="changePassword" method="post">
								<table align="center">
									<tr>
										<td>Old password:</td>
										<td><input type="password" name="oldStaff" /></td>
									</tr>
									<tr>
										<td>New password:</td>
										<td><input type="password" name="new1" /></td>
									</tr>
									<tr>
										<td>Password confirm:</td>
										<td><input type="password" name="new2" /></td>
									</tr>
									<tr>
										<td><input type="submit" value="Change" /></td>
										<td><input type="reset" value="Reset" /></td>
									</tr>
									<%
										// exception
												// No_empty: there is an empty input
												// No_equals: new password do not match
												// No_oldPassword: input wrong old password
												if (s.getAttribute("ChangePassword") != null) {
													if (s.getAttribute("ChangePassword").equals("No_empty")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">There is an
												empty input and please check it.</font></td>
									</tr>
									<%
										} else if (s.getAttribute("ChangePassword").equals(
															"No_noequals")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">New
												passwords do not match.</font></td>
									</tr>
									<%
										} else if (s.getAttribute("ChangePassword").equals(
															"No_oldPassword")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">Old
												passwords are wrong.</font></td>
									</tr>
									<%
										} else if (s.getAttribute("ChangePassword")
															.equals("No")) {
									%>
									<tr>
										<td colspan="2"><font color="#FF0000">There is
												something wrong!</font></td>
									</tr>

									<%
										} else if (s.getAttribute("ChangePassword").equals(
															"Yes")) {
									%>
									<tr>
										<td colspan="2">You have changed password successfully.</td>
									</tr>
									<%
										}
													// set to original value of null
													s.setAttribute("ChangePassword", null);
												}
									%>

								</table>
							</form>

							<%
								} else if (session.getAttribute("Personal").equals("2")
											&& session.getAttribute("User") != null) {
										// display the borrowed books of general users
										String name = (String) session.getAttribute("User");
										String title = "";
										String author = "";
										String publisher = "";
										String barcode = "";
										String status = "";
										String callNumber = "";
										String nameOfShelf = "";
										String libraryName = "";
										String copy = "";

										try {
											Statement state = con.createStatement();

											String query = "SELECT * FROM borrow_list WHERE name='"
													+ name + "';";
											ResultSet rs = state.executeQuery(query);

											while (rs.next()) {
												barcode = (String) rs.getString("barcde");

												Connection con1 = MySQLConnection.connection();
												try {
													Statement state1 = con1.createStatement();

													String query1 = "SELECT * FROM book WHERE barcode='"
															+ barcode + "';";
													ResultSet rs1 = state1.executeQuery(query1);

													while (rs1.next()) {
														title = (String) rs1.getString("title");
														author = (String) rs1.getString("author");
														publisher = (String) rs1
																.getString("publisher");
														status = (String) rs1.getString("status");
														callNumber = (String) rs1
																.getString("callNumber");
														nameOfShelf = (String) rs1
																.getString("nameOfShelf");
														libraryName = (String) rs1
																.getString("libraryName");
														copy = (String) rs1.getString("copy");
							%>
							<table>
								<tr>
									<td>Title:</td>
									<td><%=title%></td>
								</tr>
								<tr>
									<td>Author:</td>
									<td><%=author%></td>
								</tr>
								<tr>
									<td>Publisher:</td>
									<td><%=publisher%></td>
								</tr>
								<tr>
									<td>Barcode:</td>
									<td><%=barcode%></td>
								</tr>
								<tr>
									<td>Status:</td>
									<td><%=status%></td>
								</tr>
								<tr>
									<td>CallNumber:</td>
									<td><%=callNumber%></td>
								</tr>
								<tr>
									<td>NameOfShelf:</td>
									<td><%=nameOfShelf%></td>
								</tr>
								<tr>
									<td>LibraryName:</td>
									<td><%=libraryName%></td>
								</tr>
								<tr>
									<td>Copy:</td>
									<td><%=copy%></td>
								</tr>
								<tr>
									<td>----------------------------</td>
									<td>-------------------------------------------------------------</td>
								</tr>
							</table>
							<%
								}

													state1.close();
													con1.close();
												} catch (SQLException e) {

												}
											}

											state.close();
											con.close();
										} catch (SQLException e) {

										}

									} else if (session.getAttribute("Personal").equals("3")
											&& session.getAttribute("User") != null) {
										// display the favourite books of general user
										String name = (String) session.getAttribute("User");
										String title = "";
										String author = "";
										String publisher = "";
										String barcode = "";
										String status = "";
										String callNumber = "";
										String nameOfShelf = "";
										String libraryName = "";
										String copy = "";

										try {
											Statement state = con.createStatement();

											String query = "SELECT * FROM book_list WHERE name='"
													+ name + "';";
											ResultSet rs = state.executeQuery(query);

											while (rs.next()) {
												barcode = (String) rs.getString("barcode");

												Connection con1 = MySQLConnection.connection();
												try {
													Statement state1 = con1.createStatement();

													String query1 = "SELECT * FROM book WHERE barcode='"
															+ barcode + "';";
													ResultSet rs1 = state1.executeQuery(query1);

													while (rs1.next()) {
														title = (String) rs1.getString("title");
														author = (String) rs1.getString("author");
														publisher = (String) rs1
																.getString("publisher");
														status = (String) rs1.getString("status");
														callNumber = (String) rs1
																.getString("callNumber");
														nameOfShelf = (String) rs1
																.getString("nameOfShelf");
														libraryName = (String) rs1
																.getString("libraryName");
														copy = (String) rs1.getString("copy");
							%>
							<table>
								<tr>
									<td>Title:</td>
									<td><%=title%></td>
								</tr>
								<tr>
									<td>Author:</td>
									<td><%=author%></td>
								</tr>
								<tr>
									<td>Publisher:</td>
									<td><%=publisher%></td>
								</tr>
								<tr>
									<td>Barcode:</td>
									<td><%=barcode%></td>
								</tr>
								<tr>
									<td>Status:</td>
									<td><%=status%></td>
								</tr>
								<tr>
									<td>CallNumber:</td>
									<td><%=callNumber%></td>
								</tr>
								<tr>
									<td>NameOfShelf:</td>
									<td><%=nameOfShelf%></td>
								</tr>
								<tr>
									<td>LibraryName:</td>
									<td><%=libraryName%></td>
								</tr>
								<tr>
									<td>Copy:</td>
									<td><%=copy%></td>
								</tr>
								<tr>
									<td>----------------------------</td>
									<td>-------------------------------------------------------------</td>
								</tr>
							</table>

							<%
								}

													state1.close();
													con1.close();
												} catch (SQLException e) {

												}
											}

											state.close();
											con.close();
										} catch (SQLException e) {

										}
									} else if (session.getAttribute("Personal").equals("4")
											&& session.getAttribute("Staff") != null) {
										// display the do-to-list of staff
										// there are many books to be returned
										String name = (String) session.getAttribute("Staff");
										String title = "";
										String author = "";
										String publisher = "";
										String barcode = "";
										String status = "";
										String callNumber = "";
										String nameOfShelf = "";
										String libraryName = "";
										String copy = "";

										try {
											Statement state = con.createStatement();

											String query = "SELECT * FROM to_do_list WHERE name='"
													+ name + "';";
											ResultSet rs = state.executeQuery(query);

											while (rs.next()) {
												barcode = (String) rs.getString("barcde");

												Connection con1 = MySQLConnection.connection();
												try {
													Statement state1 = con1.createStatement();

													String query1 = "SELECT * FROM book WHERE barcode='"
															+ barcode + "';";
													ResultSet rs1 = state1.executeQuery(query1);

													while (rs1.next()) {
														title = (String) rs1.getString("title");
														author = (String) rs1.getString("author");
														publisher = (String) rs1
																.getString("publisher");
														status = (String) rs1.getString("status");
														callNumber = (String) rs1
																.getString("callNumber");
														nameOfShelf = (String) rs1
																.getString("nameOfShelf");
														libraryName = (String) rs1
																.getString("libraryName");
														copy = (String) rs1.getString("copy");
							%>
							<table>
								<tr>
									<td>Title:</td>
									<td><%=name%></td>
								</tr>
								<tr>
									<td>Author:</td>
									<td><%=author%></td>
								</tr>
								<tr>
									<td>Publisher:</td>
									<td><%=publisher%></td>
								</tr>
								<tr>
									<td>Barcode:</td>
									<td><%=barcode%></td>
								</tr>
								<tr>
									<td>Status:</td>
									<td><%=status%></td>
								</tr>
								<tr>
									<td>CallNumber:</td>
									<td><%=callNumber%></td>
								</tr>
								<tr>
									<td>NameOfShelf:</td>
									<td><%=nameOfShelf%></td>
								</tr>
								<tr>
									<td>LibraryName:</td>
									<td><%=libraryName%></td>
								</tr>
								<tr>
									<td>Copy:</td>
									<td><%=copy%></td>
								</tr>
								<tr>
									<td>----------------------------</td>
									<td>-------------------------------------------------------------</td>
								</tr>
							</table>

							<%
								}

													state1.close();
													con1.close();
												} catch (SQLException e) {

												}
											}

											state.close();
											con.close();
										} catch (SQLException e) {

										}
									}
								} else {
									if (session.getAttribute("User") != null) {
										String name = (String) session.getAttribute("User");
										String ID = "";
										String email = "";
										try {
											Statement state = con.createStatement();

											// get name, ID and email
											String query = "SELECT * FROM general_user WHERE name='"
													+ name + "';";
											ResultSet rs = state.executeQuery(query);

											while (rs.next()) {
												ID = (String) rs.getString("ID");
												email = (String) rs.getString("email");
											}

											state.close();
											con.close();
										} catch (SQLException e) {

										}
							%>
							<table>
								<tr>
									<td>Name:</td>
									<td><%=name%></td>
								</tr>
								<tr>
									<td>ID:</td>
									<td><%=ID%></td>
								</tr>
								<tr>
									<td>email:</td>
									<td><%=email%></td>
								</tr>
							</table>
							<%
								} else {
										// display the personal information of staff
										// get from database
										String name = (String) session.getAttribute("Staff");
										String ID = "";
										String email = "";
										String position = "";
										try {
											Statement state = con.createStatement();
											// get ID, name, email and postion
											String query = "SELECT * FROM staff WHERE name='"
													+ name + "';";
											ResultSet rs = state.executeQuery(query);

											while (rs.next()) {
												ID = (String) rs.getString("ID");
												email = (String) rs.getString("email");
												position = (String) rs.getString("position");
											}

											state.close();
											con.close();
										} catch (SQLException e) {

										}
							%>
							<table>
								<tr>
									<td>Name:</td>
									<td><%=name%></td>
								</tr>
								<tr>
									<td>ID:</td>
									<td><%=ID%></td>
								</tr>
								<tr>
									<td>email:</td>
									<td><%=email%></td>
								</tr>
								<tr>
									<td>position:</td>
									<td><%=position%></td>
								</tr>
							</table>
							<%
								}
								}
							%>
						</div>
						<div class="kg4_foot"></div>
					</div>
				</div>
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
