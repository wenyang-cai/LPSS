<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>About us</title>
<link href="css/styles.css" rel="stylesheet" type="text/css" />

<link href="css/tinyBox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/tinybox.js"></script>
<script type="text/javascript">
	function Help() {
		TINY.box.show('help.jsp', 1, 480, 600, 1);
	}
</script>

<script type="text/javascript">
	function Auto() {
<%session.setAttribute("page", "about.jsp");
			if (session.getAttribute("warning") != null) {%>
	
<%if ((String) session.getAttribute("User") == null
						&& (String) session.getAttribute("Staff") == null) {
					response.sendRedirect("/LPSS/index.jsp");
				} else {%>
	TINY.box.show('warning.jsp', 1, 200, 200, 1);
<%}
			}
			session.setAttribute("warning", null);%>
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
					<img src="images/leftNavBt.gif" />
					<div class="kg3_center" style="height: 500px;">
						<ul class="leftNav">
							<li><a href="about?option=1">Jiazhe Wang</a></li>
							<li><a href="about?option=2">Wenyang Cai</a></li>
							<li><a href="about?option=3">Xueli Jia</a></li>
							<li><a href="about?option=4">Yiming Li</a></li>
							<li><a href="about?option=5">Zhao Zhao</a></li>
						</ul>
						<img src="images/leftNavBt2.gif" />
						<ul class="leftNav">
							<li><a
								href="about">CodeCooks</a></li>
						</ul>
						<img src="images/leftNavBt3.gif" />
						<ul class="leftNav">
							<li><a href="mailto:neo.jz.wang@gmail.com?Subject=Hello">Email</a></li>
						</ul>
					</div>
					<div class="kg3_foot"></div>
				</div>

				<div class="right02">
					<img src="images/AboutBanner.jpg" />
					<div class="topBj"></div>
					<div>
						<div class="kg4_top"></div>
						<div class="kg4_center"
							style="height: 407px; overflow-x: hidden; overflow-y: auto;">

							<%
								if ((String) session.getAttribute("About") != null) {
									if (session.getAttribute("About").equals("1")) {
							%>

							<div>
								<br />
								<p align="center">
									<font size="8">Jiazhe Wang (Neo)</font>
								</p>
								<br /> <img align="right" alt="JiazheWang"
									src="images/jiazhewang.jpg" />

								<h2>Contact</h2>
								<p>
									<b>Email:</b><a
										href="mailto:neo.zj.wang@gmail.com?Subject=Hello, Neo"><u>neo.jz.wang@gmail.com</u></a>
								</p>

								<p>
									<b>Personal Page:</b><a href="http://www.jiazhewang.com">
										<u>www.jiazhewang.com</u>
									</a>
								</p>
								<br />

								<h2>Skills</h2>
								<ul>
									<li><b>Programming:</b> Java, ObjC, Python, JSP/JS/HTML/CSS, C/C++</li>
									<li><b>Design:</b> Photoshop, Dreamweaver, Flash, Final Cut</li>
									<li><b>Research:</b> Machine Learning, Data Visualization</li>
								</ul>

								<br />

								<h2>Contributions</h2>
								<ul>
									<li>Project Management</li>
									<li>Website Construction</li>
									<li>UI Design & Implementation</li>
									<li>JSP(HTML/JS) Development</li>
								</ul>

							</div>

							<%
								} else if (session.getAttribute("About").equals("2")) {
							%>

							<div>

								<br />
								<p align="center">
									<font size="8"">Wenyang Cai (Sidney)</font>
								</p>
								<br /> <img align="right" alt="WenyangCai"
									src="images/wenyangcai.jpg" />

								<h2>Contact</h2>
								<p>
									Email: <a
										href="mailto:sgwcai@student.liverpool.ac.uk?Subject=Hello, wenyang"><u>sgwcai@student.liverpool.ac.uk</u></a>
								</p>

								<br />

								<h2>Personal Info.</h2>
								<p>I am from China. I like travelling and watching movies. I
									am happy to study in Liverpool. I have seen a lot and learnt a
									lot. It is glad to see new things and make new friends in new
									place. Hope this project could acquire a good success.</p>

								<br />

								<h2>Contributions</h2>
								<ul>
									<li>Material Collecting</li>
									<li>UI Frame Design</li>
									<li>Database Management</li>
									<li>UI Testing</li>
								</ul>

							</div>


							<%
								} else if (session.getAttribute("About").equals("3")) {
							%>

							<div>

								<br />
								<p align="center">
									<font size="8"">Xueli Jia</font>
								</p>
								<br /> <img align="right" alt="XueliJia"
									src="images/xuelijia.jpg" />

								<h2>Contact</h2>
								<p>
									Email: <a
										href="mailto:Xueli.J@hotmail.com?Subject=Hello, xueli"><u>Xueli.J@hotmail.com</u></a>
								</p>

								<br />

								<h2>Personal Info.</h2>
								<p>I am a year-two student at Liverpool College with a major
									in Artificial Intelligence.</p>
								<p>I come from a happy family of china; I am the youngest
									girl and I have two brothers and a sister. I prefer to make
									friends, and in my spare time I like sport and talking with my
									friends. Welcome to make friends with me.</p>

								<br />

								<h2>Contributions</h2>
								<ul>
									<li>Path Finding Algorithm Implementation</li>
									<li>Algorithm Testing</li>
								</ul>

							</div>

							<%
								} else if (session.getAttribute("About").equals("4")) {
							%>
							<div>
								<br />
								<p align="center">
									<font size="8">Yiming Li (Nathan)</font>
								</p>
								<br /> <img align="right" alt="YimingLi-Nathan"
									src="images/yimingli.jpg" />

								<h2>Contact</h2>
								<p>
									Email: <a
										href="mailto:sgyli10@student.liverpool.ac.uk?Subject=Hello, Yiming"><u>sgyli10@student.liverpool.ac.uk</u></a>
								</p>

								<p>
									Personal Page:<a href="http://www.csc.liv.ac.uk/~x1yl2"
										target="blank"><u>www.csc.liv.ac.uk/~x1yl2</u></a>
								</p>
								<br />

								<h2>Skills</h2>
								<p>Computer Skills: Have an intimate knowledge of Micrisoft
									Office,Java,C,C++,Objective-C,JSP and HTML</p>

								<br />

								<h2>Contributions</h2>
								<ul>
									<li>Database Design & Implementation</li>
									<li>JSP(Java/HTML) Development</li>
									<li>Website Construction</li>
								</ul>

							</div>

							<%
								} else {
							%>

							<div>

								<br />
								<p align="center">
									<font size="8"">Zhao Zhao (Sky Nightroad)</font>
								</p>
								<br /> <img align="right" alt="ZhaoZhao"
									src="images/zhaozhao.jpg" />

								<h2>Contact</h2>
								<p>
									Email: <a
										href="mailto:skynightroad@sina.com?Subject=Hello, Zhao"><u>skynightroad@sina.com</u></a>
								</p>

								<br />

								<h2>Academic Interests</h2>
								<ul>
									<li>Data mining (Machine Learning approach)</li>
									<li>Theoretical Physics (Astrophysical)</li>
									<li>Applied Psychology (Micro expression)</li>
								</ul>

								<br />

								<h2>Contributions</h2>
								<ul>
									<li>Path Finding Algorithm Design</li>
									<li>Path Finding Algorithm Implementation</li>
									<li>Algorithm Testing</li>
								</ul>

							</div>


							<%
								}
							%>


							<%
								} else {
							%>
							<h2>CodeCooks</h2>
							<br />
							<p>
								We are the team AI-Group-2 named CodeCooks. The team members were<br />  
								Jiazhe Wang (Neo), Wenyang Cai (Sidney), Xueli Jia, Yiming Li (Nathan) <br />
								and Zhao Zhao (sky). All team members were year2 students in Artificial Intelligence <br />
								of Computer Science at the University of Liverpool.
							</p>
							<br />
							<p>
								This project was the assignment for the AI Group Project module in the second year <br />
								of CS UoL. The main part of this project is the Heuristics path finding algorithm<br />
								for searching the shortest path to collect several books in a library. And we also<br />
								did a lot of work on this website and the database.</p>
							<br />
							<p>
								Thank you for showing an interest in our work. Hope you like this website. <br />
								Please feel free to contact any of us.</p>
							<%
								}
								session.setAttribute("About", null);
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
