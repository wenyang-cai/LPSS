<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- jsp file for LPSS project -->
<!-- Copyright (c) 2013 Jiazhe Wang -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<link href="css/styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<form action="checkLogin" method="get">
		<div
			style="width: 287px; height: 180px; background: url(images/login_bg.gif) no-repeat 0px 0px; padding: 70px 30px 0px 30px;">

			<table width="100%" height="149" border="0" cellpadding="0"
				cellspacing="0">


				<tr>
					<td>
						<p>
							<img src="images/tb01.gif" />
						</p> <input name="Username" type="text"
						style="width: 262px; height: 26px; background: url(images/text2.gif) no-repeat 0px 0px; border: 0px; line-height: 26px; padding-left: 10px;" />
					</td>
				</tr>


				<tr>
					<td>
						<p>
							<img src="images/tb02.gif" />
						</p> <input name="Password" type="password"
						style="width: 262px; height: 26px; background: url(images/text2.gif) no-repeat 0px 0px; border: 0px; line-height: 26px; padding-left: 10px;" />
					</td>
				</tr>

				<%
					session = request.getSession();
					// judge if input is wrong and display sentence
					if (session.getAttribute("Login") != null) {
						if (session.getAttribute("Login").equals("No")) {
				%>
				<tr>
					<td colspan=2 align="center"><font color="#FF0000">Wrong username or password!</font></td>
				</tr>
				<%
					}
					} else {
				%>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>

				<%
					}
					// set to original value of null
					session.setAttribute("Login", null);
				%>
				<tr>
					<td align="right" style="padding-right: 10px;">

						<button type="submit"
							style="background: url(images/login_an02.gif) no-repeat 0px 0px; width: 84px; height: 26px; border: 0px; cursor: pointer" />
						<button type="reset"
							style="background: url(images/login_an2.gif) no-repeat 0px 0px; width: 61px; height: 26px; border: 0px; margin-left: 10px; cursor: pointer" />
					</td>
				</tr>

				<tr>
					<td><u><a href="forgetPassword"><font
								size="2px" color="#87955c">Forget Password.</font></a></u></td>
				</tr>

			</table>
		</div>
	</form>
</body>
</html>
