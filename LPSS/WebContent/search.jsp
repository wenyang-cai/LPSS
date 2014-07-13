<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>Search</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery.subwayMap-0.5.0.js"></script>

<style type="text/css">
/* The main DIV for the map */
.subway-map {
	margin: 0;
	width: 800px;
	height: 500px;
}

/* Text labels */
.text {
	text-decoration: none;
	color: black;
}

.subway-map span {
	margin: 5px 5px 5px 0;
}
</style>

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
<%// judge if the user logs in
HttpSession s = request.getSession();
			if((String) session.getAttribute("User")==null&&(String) session.getAttribute("Staff")==null){
				// return to home page
				response.sendRedirect("/LPSS/index.jsp");
			}else{
				if(session.getAttribute("warning")!=null){
				%>
	TINY.box.show('warning.jsp', 1, 200, 200, 1);
<%
				}
				session.setAttribute("warning",null);
				session.setAttribute("page", "search.jsp");
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
					<div class="kg3_top"></div>
					<div class="kg3_center">
						<a href="#"><img src="images/an01.gif" border="0"
							class="leftAn" /></a> <a href="#"><img src="images/an02.gif"
							border="0" class="leftAn" /></a>

						<ul class="tab-hd">
							<li id="tab-hd1" onclick="chenk(1)"><img
								src="images/tabh1.gif" width="84" height="27" /></li>
							<li id="tab-hd2" onclick="chenk(2)"><img
								src="images/tab2.gif" width="89" height="27" /></li>
							<li id="tab-hd3" onclick="chenk(3)"><img
								src="images/tab3.gif" width="91" height="27" /></li>
						</ul>
						<ul class="tab-bd">
							<li id="tab-bd1" style="">
								<div class="hd">
									<ul class="mem">
										<!-- Package to use -->
										<%@ page import="util.*"%>
										<%@ page import="java.util.*"%>
										<%@ page import="java.sql.*"%>
										<%
										// connect to datbase and display the books by keyword
																			String bookOption = (String)session.getAttribute("bookOption");
																			String libraryName = (String)session.getAttribute("libraryName");
																			String keyword = (String)session.getAttribute("keyword");

																			Connection con = MySQLConnection.connection();

																			try {
																				Statement state = con.createStatement();

																				// it use sql language to search
																				// ignore the case sensitive
																				// if bookOption has the part of keyword
																				// it will display the information of this book
																				String query = "SELECT * FROM book WHERE libraryName='"
																						+ libraryName + "' AND " + bookOption + " LIKE '%"
																						+ keyword + "%';";
																				ResultSet rs = state.executeQuery(query);

																				while (rs.next()) {
																					String title = (String) rs.getString("title");
																					String author = (String) rs.getString("author");
																					String publisher = (String) rs.getString("publisher");
																					String barcode = (String) rs.getString("barcode");
																					String status = (String) rs.getString("status");
																					String callNumber = (String) rs.getString("callNumber");
										%>
										<li><img src="images/tb1.gif" class="tb" />
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="37%" align="right">Title</td>
													<td width="63%"><%=title%></td>
												</tr>
												<tr>
													<td align="right">Author</td>
													<td><%=author%></td>
												</tr>
												<tr>
													<td align="right">Publisher</td>
													<td><%=publisher%></td>
												</tr>
												<tr>
													<td align="right">Barcode</td>
													<td><%=barcode%></td>
												</tr>
												<tr>
													<td align="right">Status</td>
													<td><%=status%></td>
												</tr>
												<tr>
													<td align="right">Class NO</td>
													<td><%=callNumber%></td>
												</tr>
												<tr>
													<%if((String) session.getAttribute("User")!=null){%>
													<td colspan="2"><a
														href="addOperationList?barcode=<%=barcode%>"><img
															src="images/an03.gif" width="98" height="16" border="0"
															style="margin-right: 5px;" /></a><a
														href="addBookList?barcode=<%=barcode%>"><img
															src="images/an04.gif" width="98" height="16" border="0" /></a></td>
													<%}else{%>
													<td colspan="2"><a
														href="addOperationList?barcode=<%=barcode%>"><img
															src="images/an03.gif" width="98" height="16" border="0"
															style="margin-right: 5px;" /></a></td>
													<%} %>
												</tr>
											</table></li>
										<%
											}
												state.close();
												con.close();
											} catch (SQLException e) {

											}
										%>
									</ul>
								</div>
							</li>


							<li id="tab-bd2" style="display: none">
								<div class="hd">
									<ul class="mem">
										<%
										// connect to datbase and display the books stored in the book_list
										// which store the favourite books of users
											HttpSession ss = request.getSession();
											String user = (String) ss.getAttribute("User");

											con = MySQLConnection.connection();

											try {
												Statement state = con.createStatement();

												String query = "SELECT barcode FROM book_list WHERE name='"
														+ user + "';";

												ResultSet rs = state.executeQuery(query);

												while (rs.next()) {
													String bar = (String) rs.getString("barcode");

													Connection con1 = MySQLConnection.connection();

													try {
														Statement state1 = con1.createStatement();

														String query1 = "SELECT * FROM book WHERE barcode='"
																+ bar + "';";

														ResultSet rs1 = state1.executeQuery(query1);

														while (rs1.next()) {
															String title = (String) rs1.getString("title");
															String author = (String) rs1.getString("author");
															String publisher = (String) rs1
																	.getString("publisher");
															String barcode = (String) rs1.getString("barcode");
															String status = (String) rs1.getString("status");
															String callNumber = (String) rs1
																	.getString("callNumber");
										%>
										<li><img src="images/tb1.gif" class="tb" />
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="37%" align="right">Title</td>
													<td width="63%"><%=title%></td>
												</tr>
												<tr>
													<td align="right">Author</td>
													<td><%=author%></td>
												</tr>
												<tr>
													<td align="right">Publisher</td>
													<td><%=publisher%></td>
												</tr>
												<tr>
													<td align="right">Barcode</td>
													<td><%=barcode%></td>
												</tr>
												<tr>
													<td align="right">Status</td>
													<td><%=status%></td>
												</tr>
												<tr>
													<td align="right">Class NO</td>
													<td><%=callNumber%></td>
												</tr>
												<tr>
													<td colspan="2"><a
														href="addOperationList?barcode=<%=barcode%>"><img
															src="images/an03.gif" width="98" height="16" border="0"
															style="margin-right: 5px;" /></a><a
														href="deleteBookList?barcode=<%=barcode%>"><img
															src="images/andelete.gif" width="98" height="16"
															border="0" /></a></td>
												</tr>
											</table></li>
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
										%>

									</ul>
								</div>
							</li>


							<li id="tab-bd3" style="display: none">
								<div class="hd">
									<ul class="mem">
										<%
										// connect to datbase and display the books by list in the session
											ArrayList<String> list = (ArrayList<String>) s.getAttribute("Barcode");

										// if list is not empty and display the books
										// because the list only stores the barcode, it needs to connect to database and get other information of books
										if(list!=null){
											for(int i=0;i<list.size();i++){
												String bar = list.get(i);
													Connection con1 = MySQLConnection.connection();

													try {
														Statement state1 = con1.createStatement();

														String query1 = "SELECT * FROM book WHERE barcode='"
																+ bar + "';";

														ResultSet rs1 = state1.executeQuery(query1);

														while (rs1.next()) {
															String title = (String) rs1.getString("title");
															String author = (String) rs1.getString("author");
															String publisher = (String) rs1
																	.getString("publisher");
															String barcode = (String) rs1.getString("barcode");
															String status = (String) rs1.getString("status");
															String callNumber = (String) rs1
																	.getString("callNumber");
										%>
										<li><span><%=(i+1)%></span>
											<table width="100%" border="0" cellspacing="0"
												cellpadding="0">
												<tr>
													<td width="37%" align="right">Title</td>
													<td width="63%"><%=title%></td>
												</tr>
												<tr>
													<td align="right">Author</td>
													<td><%=author%></td>
												</tr>
												<tr>
													<td align="right">Publisher</td>
													<td><%=publisher%></td>
												</tr>
												<tr>
													<td align="right">Barcode</td>
													<td><%=barcode%></td>
												</tr>
												<tr>
													<td align="right">Status</td>
													<td><%=status%></td>
												</tr>
												<tr>
													<td align="right">Class NO</td>
													<td><%=callNumber%></td>
												</tr>
												<tr>
													<%if((String) session.getAttribute("User")!=null){%>
													<td colspan="2"><a
														href="deleteOperationList?barcode=<%=barcode%>"><img
															src="images/andelete.gif" width="98" height="16"
															border="0" style="margin-right: 5px;" /></a><a
														href="addBookList?barcode=<%=barcode%>"><img
															src="images/an04.gif" width="98" height="16" border="0" /></a></td>
													<%}else{ %>
													<td colspan="2"><a
														href="deleteOperationList?barcode=<%=barcode%>"><img
															src="images/andelete.gif" width="98" height="16"
															border="0" style="margin-right: 5px;" /></a></td>
													<%} %>
												</tr>
											</table></li>
										<%
											}
														state1.close();
														con1.close();

													} catch (SQLException e) {

													}
											}
										}
										%>

									</ul>
								</div>
							</li>


						</ul>
					</div>
					<div class="kg3_foot"></div>
				</div>

				<div class="right02">
					<div class="search">
						<form action="searchBook" method="post">
							<div class="searchMk" style="margin-left: 25px;">
								<select name="Library" id="select1">
									<%
									// by default the bookOption is null and display the first option
									if(libraryName!=null){
										// judge which option has been chosen before and display it again
										if (libraryName.equals("lib1")) {
									%>
									<option value="1" selected="selected">Library1</option>
									<option value="2">Library2</option>
									<option value="3">Library3</option>
									<%
										}
									%>

									<%
									// judge which option has been chosen before and display it again
										if (libraryName.equals("lib2")) {
									%>
									<option value="1">Library1</option>
									<option value="2" selected="selected">Library2</option>
									<option value="3">Library3</option>
									<%
										}
									%>

									<%
									// judge which option has been chosen before and display it again
										if (libraryName.equals("lib3")) {
									%>
									<option value="1">Library1</option>
									<option value="2">Library2</option>
									<option value="3" selected="selected">Library3</option>
									<%
										}
									// judge which option has been chosen before and display it again
									}else{
										%>
									<option value="1" selected="selected">Library1</option>
									<option value="2">Library2</option>
									<option value="3">Library3</option>
									<%
									}
									%>
								</select>
							</div>
							<div class="searchMk" style="margin-left: 10px;">
								<select name="Option" id="select2">
									<%
									// by default the bookOption is null and display the first option
									if(bookOption!=null){
										// judge which option has been chosen before and display it again
										if (bookOption.equals("title")) {
									%>
									<option value="1" selected="selected">Title</option>
									<option value="2">Author</option>
									<option value="3">Call Number</option>
									<%
										}
									%>
									<%
									// judge which option has been chosen before and display it again
										if (bookOption.equals("author")) {
									%>
									<option value="1">Title</option>
									<option value="2" selected="selected">Author</option>
									<option value="3">Call Number</option>
									<%
										}
									%>
									<%
									// judge which option has been chosen before and display it again
										if (bookOption.equals("callNumber")) {
									%>
									<option value="1">Title</option>
									<option value="2">Author</option>
									<option value="3" selected="selected">Call Number</option>
									<%
										}
									}else{
										%>
									<option value="1" selected="selected">Title</option>
									<option value="2">Author</option>
									<option value="3">Call Number</option>
									<%
									}
									%>
								</select>
							</div>
							<%if(keyword==null){keyword="";}%>
							<input name="KeyWord" type="text" class="textSearch"
								value="<%=keyword%>" />
							<button></button>
						</form>
					</div>


					<div class="topBj"></div>
					<div class="map">
						<div
							style="background-image: url(images/maps/map1.jpg); height: 500px; width: 800px; margin: 15px 0px 0px 11px;">
							<!-- position:relative;z-index:10; -->

							<div id="map" class="subway-map" data-columns="800"
								data-rows="500" data-cellSize="1" data-legendId="legend"
								data-textClass="text" data-gridNumbers="false" data-grid="false"
								data-lineWidth="3"
								style="background-image: url(image/map1.jpg); background-position: center; background-repeat: repeat-y;">
							</div>

							<script type="text/javascript">
								$.getJSON("getPoints", function(data) {
									$.each(data, function(i, item) {
										$("#map").append(item.string);
									});
									$(".subway-map").subwayMap({
										debug : true
									});
								});
							</script>

						</div>
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
	<script>
		function chenk(dtbd) {
			if (dtbd == 1) {
				document.getElementById("tab-hd1").innerHTML = "<img Src='images/tabh1.gif'>";
				document.getElementById("tab-hd2").innerHTML = "<img Src='images/tab2.gif'>";
				document.getElementById("tab-hd3").innerHTML = "<img Src='images/tab3.gif'>";
				document.getElementById("tab-bd1").style.display = "";
				document.getElementById("tab-bd2").style.display = "none";
				document.getElementById("tab-bd3").style.display = "none";
			}
			if (dtbd == 2) {
				document.getElementById("tab-hd1").innerHTML = "<img Src='images/tab1.gif'>";
				document.getElementById("tab-hd2").innerHTML = "<img Src='images/tabh2.gif'>";
				document.getElementById("tab-hd3").innerHTML = "<img Src='images/tab3.gif'>";
				document.getElementById("tab-bd1").style.display = "none";
				document.getElementById("tab-bd2").style.display = "";
				document.getElementById("tab-bd3").style.display = "none";
			}
			if (dtbd == 3) {
				document.getElementById("tab-hd1").innerHTML = "<img Src='images/tab1.gif'>";
				document.getElementById("tab-hd2").innerHTML = "<img Src='images/tab2.gif'>";
				document.getElementById("tab-hd3").innerHTML = "<img Src='images/tabh3.gif'>";
				document.getElementById("tab-bd1").style.display = "none";
				document.getElementById("tab-bd2").style.display = "none";
				document.getElementById("tab-bd3").style.display = "";
			}

		}
	</script>
</body>
</html>
