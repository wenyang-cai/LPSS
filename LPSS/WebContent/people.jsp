<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang & Yiming Li -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>People</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script>
	(function($) {
		function hideOptions(speed) {
			if (speed.data) {
				speed = speed.data
			}
			if ($(document).data("nowselectoptions")) {
				$($(document).data("nowselectoptions")).slideUp(speed);
				$($(document).data("nowselectoptions")).prev("div")
						.removeClass("tag_select_open");
				$(document).data("nowselectoptions", null);
				$(document).unbind("click", hideOptions);
				$(document).unbind("keyup", hideOptionsOnEscKey);
			}
		}
		function hideOptionsOnEscKey(e) {
			var myEvent = e || window.event;
			var keyCode = myEvent.keyCode;
			if (keyCode == 27)
				hideOptions(e.data);
		}
		function showOptions(speed) {
			$(document).bind("click", speed, hideOptions);
			$(document).bind("keyup", speed, hideOptionsOnEscKey);
			$($(document).data("nowselectoptions")).slideDown(speed);
			$($(document).data("nowselectoptions")).prev("div").addClass(
					"tag_select_open");
		}

		$.fn.selectCss = function(_speed) {
			$(this)
					.each(
							function() {
								var speed = _speed || "fast";
								if ($(this).data("cssobj")) {
									$($(this).data("cssobj")).remove();
								}
								$(this).hide();
								var divselect = $("<div></div>").insertAfter(
										this).addClass("tag_select");
								$(this).data("cssobj", divselect);
								var divoptions = $("<ul></ul>").insertAfter(
										divselect).addClass("tag_options")
										.hide();
								divselect.click(function(e) {
									if ($($(document).data("nowselectoptions"))
											.get(0) != $(this).next("ul")
											.get(0)) {
										hideOptions(speed);
									}
									if (!$(this).next("ul").is(":visible")) {
										e.stopPropagation();
										$(document).data("nowselectoptions",
												$(this).next("ul"));
										showOptions(speed);
									}
								});
								divselect.hover(function() {
									$(this).addClass("tag_select_hover");
								}, function() {
									$(this).removeClass("tag_select_hover");
								});
								$(this)
										.change(
												function() {
													$(this)
															.nextAll("ul")
															.children(
																	"li:eq("
																			+ $(this)[0].selectedIndex
																			+ ")")
															.addClass(
																	"open_selected")
															.siblings()
															.removeClass(
																	"open_selected");
													$(this)
															.next("div")
															.html(
																	$(this)
																			.children(
																					"option:eq("
																							+ $(this)[0].selectedIndex
																							+ ")")
																			.text());
												});
								$(this)
										.children("option")
										.each(
												function(i) {
													var lioption = $(
															"<li></li>")
															.html(
																	$(this)
																			.text())
															.attr(
																	"title",
																	$(this)
																			.attr(
																					"title"))
															.appendTo(
																	divoptions);
													if ($(this)
															.attr("selected")) {
														lioption
																.addClass("open_selected");
														divselect.html($(this)
																.text());
													}
													lioption.data("option",
															this);
													lioption
															.click(function() {
																lioption
																		.data("option").selected = true;
																$(
																		lioption
																				.data("option"))
																		.trigger(
																				"change",
																				true)
															});
													lioption.hover(function() {
														$(this).addClass(
																"open_hover");
													}, function() {
														$(this).removeClass(
																"open_hover");
													});
												});
							});
		}
	})(jQuery);
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("select").selectCss();
	});
</script>

<script type="text/javascript">
	function Auto() {
<%// this page only can access by staff of library
			// so, can get username of staff from session
			HttpSession s = request.getSession();
			String user = (String) session.getAttribute("Staff");
			// if there is no staff name, return to home page
			if ((String) session.getAttribute("User") == null
					&& (String) session.getAttribute("Staff") == null) {
				// return to home page
				response.sendRedirect("/LPSS/index.jsp");
			} else {
				if (user == null) {
					session.setAttribute("warning", "Yes");
					String p = (String) session.getAttribute("page");
					response.sendRedirect("/LPSS/" + p);

				} else {
					if (session.getAttribute("warning") != null) {%>
		TINY.box.show('warning.jsp', 1, 200, 200, 1);
<%}
					session.setAttribute("warning", null);
					session.setAttribute("page", "people.jsp");

				}
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

	<!-- Package to use -->
	<%@ page import="util.*"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*"%>
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
					<img src="images/leftNavBt7.gif" width="277" height="48" />
					<div class="kg3_center" style="height: 480px;">
						<ul class="leftNav">
							<li><a href="people?option=0">User</a></li>
							<li><a href="people?option=1">Staff</a></li>
						</ul>
						<%
							// judge if the staff is curator
							// if it is true, he/she can have functions to add, modify and delete other staff
							Connection con1 = MySQLConnection.connection();
							boolean judge = false;
							try {
								Statement state = con1.createStatement();

								// sql language to judge if he/she is curator
								String query = "SELECT * FROM staff WHERE position='Curator' and name='"
										+ user + "';";
								ResultSet rs = state.executeQuery(query);

								// if it has the result set, it means judge = true
								while (rs.next()) {
									judge = true;
								}
								state.close();
								con1.close();
							} catch (SQLException e) {

							}
							// when it is true, the curator has other three functions
							if (judge) {
						%>
						<img src="images/leftNavBt8.gif" />
						<ul class="leftNav">
							<li><a href="people?option=2">Add</a></li>
							<li><a href="people?option=3">Modify</a></li>
							<li><a href="people?option=4">Delete</a></li>
						</ul>
						<%
							}
						%>

					</div>
					<div class="kg3_foot"></div>
				</div>

				<div class="right02">
					<div class="search">
						<div class="searchMk" style="margin-left: 10px;">
							<select name="" id="select1">
								<option value="1" title="Choose options">Name</option>
								<option value="2">ID</option>
								<option value="3">Position</option>
							</select>
						</div>
						<input name="" type="text" class="text" />
						<button></button>
					</div>


					<div class="topBj"></div>
					<div>
						<div class="kg4_top"></div>
						<div class="kg4_center" style="padding: 0px 6px;">

							<%
								// 0 means to display the information of general users as a table
								if (s.getAttribute("People") != null) {
									if (s.getAttribute("People").equals("0")) {
							%>

							<h2
								style="display: block; border-bottom: #ccc solid 1px; height: 40px; line-height: 40px; text-indent: 20px;">User
								Information</h2>
							<div
								style="border-top: #fff solid 1px; width: 807px; overflow-x: hidden; height: 400px; overflow-y: auto;">
								<table width="100%" border="0" cellspacing="2" cellpadding="0"
									class="peopleTb">
									<thead>
										<tr>
											<td>Name</td>
											<td>ID</td>
											<td>Email</td>
										</tr>
									</thead>
									<tbody>
										<%
											// also connect to mysql and get name, ID and email to display by general user
													Connection con = MySQLConnection.connection();

													try {
														Statement state = con.createStatement();

														String query = "SELECT * FROM general_user;";
														ResultSet rs = state.executeQuery(query);

														while (rs.next()) {
															String name = (String) rs.getString("name");
															String ID = (String) rs.getString("ID");
															String email = (String) rs.getString("email");
										%>
										<tr>
											<td><%=name%></td>
											<td><%=ID%></td>
											<td><a href="mailto:<%=email%>" class="blue"><%=email%></a></td>
										</tr>
										<%
											}
														state.close();
														con.close();
													} catch (SQLException e) {

													}
										%>

										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</div>




							<%
								// 1 means to display the information of staff as a table
									} else if (s.getAttribute("People").equals("1")) {
							%>
							<h2
								style="display: block; border-bottom: #ccc solid 1px; height: 40px; line-height: 40px; text-indent: 20px;">Staff
								Information</h2>
							<div
								style="border-top: #fff solid 1px; width: 807px; overflow-x: hidden; height: 400px; overflow-y: auto;">
								<table width="100%" border="0" cellspacing="2" cellpadding="0"
									class="peopleTb">
									<thead>
										<tr>
											<td>Name</td>
											<td>ID</td>
											<td>Email</td>
											<td>Position</td>
										</tr>
									</thead>
									<tbody>
										<%
											// also connect to mysql and get name, ID, email and position of staff to display as a table
													Connection con = MySQLConnection.connection();

													try {
														Statement state = con.createStatement();

														String query = "SELECT * FROM staff;";
														ResultSet rs = state.executeQuery(query);

														while (rs.next()) {
															String name = (String) rs.getString("name");
															String ID = (String) rs.getString("ID");
															String email = (String) rs.getString("email");
															String position = (String) rs.getString("position");
										%>
										<tr>
											<td><%=name%></td>
											<td><%=ID%></td>
											<td><a href="mailto:<%=email%>" class="blue"><%=email%></a></td>
											<td><%=position%></td>
										</tr>
										<%
											}
														state.close();
														con.close();
													} catch (SQLException e) {

													}
										%>

										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</div>



							<%
								// 2 menas this is display for curator to add staff
									} else if (s.getAttribute("People").equals("2")) {
							%>

							<h2
								style="display: block; border-bottom: #ccc solid 1px; height: 40px; line-height: 40px; text-indent: 20px;">Add
								Staff</h2>
							<div
								style="border-top: #fff solid 1px; width: 807px; overflow-x: hidden; height: 400px; overflow-y: auto;">


								<form action="addStaff" method="post">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="load">
										<tr>
											<td width="18%" align="right">User:</td>
											<td width="82%"><input type="text" name="name" /></td>
										</tr>
										<tr>
											<td align="right">ID:</td>
											<td><input type="text" name="ID" /></td>
										</tr>
										<tr>
											<td align="right">Email:</td>
											<td><input type="text" name="email" /></td>
										</tr>
										<tr>
											<td align="right">Password:</td>
											<td><input type="password" name="password" /></td>
										</tr>


										<tr>
											<td align="right">Position:</td>

											<td>
												<div class="searchMk" style="margin: 0px;">
													<select name="position">
														<option value="1" selected="selected">Curator</option>
														<option value="2">DB Admin</option>
														<option value="3">Senior Libra</option>
														<option value="4">Junior Libra</option>
													</select>
												</div>
											</td>

										</tr>


										<tr>
											<td>&nbsp;</td>
											<td><input type="submit" value="Add" class="an05" /> <input
												type="reset" value="Reset" class="an05" /></td>
										</tr>
										<%
											// exceptions
													// No_empty: there is an empty input
													// No: other exceptions, such as there is something wrong with mysql
													if (s.getAttribute("AddStaff") != null) {
														if (s.getAttribute("AddStaff").equals("No")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is
													something wrong!</font></td>
										</tr>
										<%
											} else if (s.getAttribute("AddStaff")
																.equals("No_empty")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is an
													empty input and please check it.</font></td>
										</tr>
										<%
											} else if (s.getAttribute("AddStaff").equals("Yes")) {
										%>
										<tr>
											<td colspan="2">You have added staff successfully.</td>
										</tr>
										<%
											}
														// set to original value of null
														session.setAttribute("AddStaff", null);
													}
										%>

									</table>
								</form>

							</div>


							<%
								// 3 menas this is display for curator to modify staff of position
									} else if (s.getAttribute("People").equals("3")) {
							%>
							<h2
								style="display: block; border-bottom: #ccc solid 1px; height: 40px; line-height: 40px; text-indent: 20px;">Modify
								Staff</h2>
							<div
								style="border-top: #fff solid 1px; width: 807px; overflow-x: hidden; height: 400px; overflow-y: auto;">



								<form action="modifyStaff" method="post">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="load">
										<tr>
											<td width="18%" align="right">User:</td>
											<td width="82%"><input type="text" name="name" /></td>
										</tr>
										<tr>
											<td align="right">ID:</td>
											<td><input type="text" name="ID" /></td>
										</tr>
										<tr>
											<td align="right">Position:</td>
											<td>
												<div class="searchMk" style="margin: 0px;">
													<select name="newPosition">
														<option value="1" selected="selected">Curator</option>
														<option value="2">DB Admin</option>
														<option value="3">Senior Libra</option>
														<option value="4">Junior Libra</option>
													</select>
												</div>
											</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td><input type="submit" value="Modify" class="an05" />
												<input type="reset" value="Reset" class="an05" /></td>
										</tr>
										<%
											// exceptions
													// No_empty: there is an empty input
													// No_staff: ID or name is wrong, no staff has them in MySQL
													// No: other exception, such as: there is something wrong with mysql
													if (s.getAttribute("ModifyStaff") != null) {
														if (s.getAttribute("ModifyStaff").equals("No")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is
													something wrong!</font></td>
										</tr>
										<%
											} else if (s.getAttribute("ModifyStaff").equals(
																"No_empty")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is an
													empty input and please check it.</font></td>
										</tr>
										<%
											} else if (s.getAttribute("ModifyStaff").equals(
																"No_nostaff")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is no
													staff to modify. Please check the name and ID.</font></td>
										</tr>
										<%
											} else if (s.getAttribute("ModifyStaff").equals("Yes")) {
										%>
										<tr>
											<td colspan="2">You have modified staff successfully.</td>
										</tr>
										<%
											}
														// set to original value of null
														s.setAttribute("ModifyStaff", null);
													}
										%>

									</table>
								</form>


							</div>



							<%
								// 4 menas this is display for curator to delete staff of position
									} else if (s.getAttribute("People").equals("4")) {
							%>
							<h2
								style="display: block; border-bottom: #ccc solid 1px; height: 40px; line-height: 40px; text-indent: 20px;">Delete
								Staff</h2>

							<div
								style="border-top: #fff solid 1px; width: 807px; overflow-x: hidden; height: 400px; overflow-y: auto;">

								<form action="deleteStaff" method="post">
									<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="load">
										<tr>
											<td width="18%" align="right">User:</td>
											<td width="82%"><input type="text" name="name" /></td>
										</tr>
										<tr>
											<td align="right">ID:</td>
											<td><input type="text" name="ID" /></td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td><input type="submit" value="Delete" class="an05" />
												<input type="reset" value="Reset" class="an05" /></td>
										</tr>
										<%
											// exceptions
													// No_empty: there is an empty input
													// No_staff: ID or name is wrong, no staff has them in MySQL
													// No: other exception, such as: there is something wrong with mysql
													if (s.getAttribute("DeleteStaff") != null) {
														if (s.getAttribute("DeleteStaff").equals("No")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is
													something wrong!</font></td>
										</tr>
										<%
											} else if (s.getAttribute("DeleteStaff").equals(
																"No_empty")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is an
													empty input and please check it.</font></td>
										</tr>
										<%
											} else if (s.getAttribute("DeleteStaff").equals(
																"No_nostaff")) {
										%>
										<tr>
											<td colspan="2"><font color="#FF0000">There is no
													staff to delete. Please check the name and ID.</font></td>
										</tr>
										<%
											} else if (s.getAttribute("DeleteStaff").equals("Yes")) {
										%>
										<tr>
											<td colspan="2">You have delete staff successfully.</td>
										</tr>
										<%
											}
														// set to original value of null
														s.setAttribute("DeleteStaff", null);
													}
										%>

									</table>
								</form>


							</div>




							<%
								}
									// nothing to choose
									// by default it will display as follows
								} else {
							%>

							<h2
								style="display: block; border-bottom: #ccc solid 1px; height: 40px; line-height: 40px; text-indent: 20px;">User
								Information</h2>
							<div
								style="border-top: #fff solid 1px; width: 807px; overflow-x: hidden; height: 400px; overflow-y: auto;">
								<table width="100%" border="0" cellspacing="2" cellpadding="0"
									class="peopleTb">
									<thead>
										<tr>
											<td>Name</td>
											<td>ID</td>
											<td>Email</td>
										</tr>
									</thead>
									<tbody>
										<%
											// also connect to mysql and get the name, ID and email of general user to display
												Connection con = MySQLConnection.connection();

												try {
													Statement state = con.createStatement();

													String query = "SELECT * FROM general_user;";
													ResultSet rs = state.executeQuery(query);

													while (rs.next()) {
														String name = (String) rs.getString("name");
														String ID = (String) rs.getString("ID");
														String email = (String) rs.getString("email");
										%>
										<tr>
											<td><%=name%></td>
											<td><%=ID%></td>
											<td><a href="mailto:<%=email%>" class="blue"><%=email%></a></td>
										</tr>
										<%
											}
													state.close();
													con.close();
												} catch (SQLException e) {

												}
										%>

										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
											<td>&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</div>
							<%
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
