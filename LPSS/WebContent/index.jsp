<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>Welcome to library</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<!-- Tiny Box -->
<link href="css/tinyBox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/tinybox.js"></script>
<script type="text/javascript">
	function Auto() {
<%session.setAttribute("page", "index.jsp");
			// track the session and get the information of user
			// if general user or staff do not log in our web
			// it will display dialog to hint to log in
			HttpSession s = request.getSession();
			if ((String) s.getAttribute("Forget") != null) {%>
	TINY.box.show('help.jsp', 1, 480, 600, 1);
<%s.setAttribute("Forget", null);
			} else if ((String) s.getAttribute("User") == null
					&& (String) s.getAttribute("Staff") == null) {%>
	TINY.box.show('login.jsp', 1, 347, 250, 1);
<%} else if (session.getAttribute("warning") != null) {%>
	TINY.box.show('warning.jsp', 1, 200, 200, 1);
<% }
			session.setAttribute("warning", null);%>
	}
</script>

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
				<div class="left01">
					<div class="homeBanner">
						<img src="images/homeBanner.jpg" />
					</div>
					<div class="kg2">
						<h2>News</h2>
						<dl>
							<dt>
								<img src="images/pic01.jpg" />
							</dt>
							<dt style="margin-left: 30px;">
								<a
									href="http://www.goodreads.com/list/show/16.Best_Books_of_the_19th_Century">
									<u>
										<p>British Library</p>
										<p>19th Century Books</p>
										<p>now online</p>
								</u>
								</a>
							</dt>
						</dl>
					</div>
					<div class="kg2" style="float: right;">
						<h2>New Books</h2>
						<img src="images/pic02.jpg" style="margin-left: 30px;" />
					</div>
				</div>
				<div class="right01">
					<div id="introduction">
						<div class="kg1_top"></div>
						<div class="kg1_center">
							<h2>Introduction</h2>
							<p>The Library Path Search System (LPSS) is a search system
								which can find the shortest path for returning or collecting
								particular books in our library.</p>
							<p>
								It has three basic functions:<br /> 1. Guiding borrowers to
								find books, <br /> 2. Guiding librarians to return and collect
								books efficiently <br /> 3. Controlling a library robot to
								return and collect books automatically.
							</p>
							<p>If you have any problem when using this system, please go
								to the Help page to find some help information.</p>

						</div>
						<div class="kg1_foot"></div>
					</div>

					<div id="recom">
						<div class="kg1_top"></div>
						<div class="kg1_center">
							<h2>Recommended Books</h2>
							<p>1. JAVA, JAVA, JAVA (Morelli & Walde)</p>
							<p>2. C++ Primer (Lippman, Lajoie & Moo)</p>
							<p>3. Database Solutions (Connolly & Begg)</p>
						</div>
						<div class="kg1_foot"></div>
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
