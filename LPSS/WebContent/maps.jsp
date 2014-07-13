<!DOCTYPE html>
<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang -->
<!-- reference: url=(0059)http://www.enjoyhtml5.com/hackathons/20110108/04/index.html -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="UTF-8"><%@ page import="util.MySQLConnection"%>
<!-- Package to use -->
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<script type="text/javascript" src="js/db.js"></script>
<script type="text/javascript" src="js/paint.js"></script>
<script type="text/javascript" src="js/daily.js"></script>
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
<title>Maps</title>
<script type="text/javascript">
	function Auto() {
<%if ((String) session.getAttribute("User") == null
					&& (String) session.getAttribute("Staff") == null) {
				// return to home page
				response.sendRedirect("/LPSS/index.jsp");
			}else{
			// track the session and get the information of user
			HttpSession s = request.getSession();
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
			} catch (SQLException e) {

			}
			// only Curator and Database Administer can go into this web
			// and edit the map
			if (!position.equals("Curator")
					&& !position.equals("Database Administer")) {
				session.setAttribute("warning", "Yes");
				String p = (String) session.getAttribute("page");
				response.sendRedirect("/LPSS/" + p);

			} else {
				if (session.getAttribute("warning") != null) {%>
		TINY.box.show('warning.jsp', 1
, 200, 200, 1);
				<%}
				session.setAttribute("warning", null);
				session.setAttribute("page", "maps.jsp");
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
						<a href="#"><img src="images/an05.gif" border="0"
							class="leftAn" /></a> 
						<a href="#"><img src="images/an06.gif"
							border="0" class="leftAn" /></a>

						<ul class="tab-hd">
							<li id="tab-hd1" onClick="chenk(1)"><img
								src="images/tab4.gif" width="97" height="26" /></li>
						</ul>
						<div class="mapHd">
							<ul class="pics">
								<li><img src="images/1.png" width="242" height="41"></li>
								<li><img src="images/2.png"></li>
								<li><img src="images/4.png"></li>
								<li><img src="images/5.png"></li>
								<li><img src="images/7.png"></li>
								<li><img src="images/3.png" width="22" height="82"></li>
								<li><img src="images/12.png"></li>
							</ul>
						</div>

					</div>
					<div class="kg3_foot"></div>
				</div>

				<div class="right02">
					<div class="search">
						<div class="searchMk" style="margin-left: 20px;">
							<select name="" id="select2">
								<option value="1">Map1</option>
								<option value="2">Map2</option>
								<option value="3">Map3</option>
							</select>
						</div>
						<input name="" type="text" class="text" />
						<button></button>
					</div>


					<div class="topBj"></div>
					<div class="map">
						<article class="one-note">
							<section class="content" id="canvasBox">
								<canvas id="noteContent" width="796" height="487"
									style="border: #ccc solid 1px; margin: 15px 0px 0px 11px;"></canvas>
							</section>
						</article>
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


	<div id="container" style="display: none">

		<aside class="tools">
			<h3>Tool</h3>
			<section id="tools">
				<label for="fontFamily">Font：</label> <select name="fontFamily"
					id="fontFamily" style="margin-bottom: 5px;">
					<option value="宋体">Font：</option>
					<option value="黑体">Font：</option>
					<option value="幼圆">Font：</option>
				</select> <label for="fontSize">FontSize：<span id="fontSizeOutput"></span></label>
				<input type="range" id="fontSize" value="12" min="12" max="30">
				<label for="penWidth">Width：<span id="penWidthOutput"></span></label>
				<input id="penWidth" type="range" value="1" min="1" max="20">

				<label for="">Color：<span id="colorOutput"></span></label>
				<ul class="colors" id="colors">
					<li style="color: red; background-color: red;">red</li>
					<li style="color: blue; background-color: blue;">blue</li>
					<li style="color: green; background-color: green;">green</li>
					<li style="color: lime; background-color: lime;">lime</li>
					<li style="color: orchid; background-color: orchid;">orchid</li>
					<li style="color: purple; background-color: purple;">purple</li>
					<li style="color: pink; background-color: pink;">pink</li>
					<li style="color: silver; background-color: silver;">silver</li>
					<li style="color: yellow; background-color: yellow;">yellow</li>
					<li style="color: burlywood; background-color: burlywood;">burlywood</li>
					<li style="color: chocolate; background-color: chocolate;">chocolate</li>
					<li style="color: black; background-color: black;">black</li>
				</ul>
				<p style="margin-top: 15px;">
					<strong style="font-size: 14px;">Hint：</strong><br>1、Double
					click text.<br>2、Drag to editor.<br>3、Drag diagrams
					to editor.
				</p>
			</section>
		</aside>


		<button id="submit" style="margin-left: 170px; margin-top: 10px;">Save</button>

	</div>


	<div id="textarea_wapper"
		style="position: absolute; width: 313px; height: 120px; background-color: gray; display: none;">
		<textarea rows="5" cols="36" id="text_area"></textarea>
		<button id="print_text" style="float: right">Print</button>
		<button id="cancel_text" style="float: right">Cancel</button>
	</div>



</body>
</html>