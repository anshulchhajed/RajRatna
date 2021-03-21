<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" type="text/css" href="css/adminlogin.css">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
* {
	box-sizing: border-box;
}

.row::after {
	content: "";
	clear: both;
	display: table;
}

[class*="col-"] {
	float: left;
	padding: 15px;
}

html {
	font-family: "Lucida Sans", sans-serif;
}

.header {
	background-color: #9933cc;
	color: #ffffff;
	padding: 15px;
}

.menu ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.menu li {
	padding: 8px;
	margin-bottom: 7px;
	background-color: #33b5e5;
	color: #ffffff;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
}

.menu li:hover {
	background-color: #0099cc;
}

.aside {
	background-color: #33b5e5;
	padding: 15px;
	color: #ffffff;
	text-align: center;
	font-size: 14px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
}

/* For mobile phones: */
[class*="col-"] {
	width: 100%;
}

@media only screen and (min-width: 600px) {
	/* For tablets: */
	.col-s-1 {
		width: 8.33%;
	}
	.col-s-2 {
		width: 16.66%;
	}
	.col-s-3 {
		width: 25%;
	}
	.col-s-4 {
		width: 33.33%;
	}
	.col-s-5 {
		width: 41.66%;
	}
	.col-s-6 {
		width: 50%;
	}
	.col-s-7 {
		width: 58.33%;
	}
	.col-s-8 {
		width: 66.66%;
	}
	.col-s-9 {
		width: 75%;
	}
	.col-s-10 {
		width: 83.33%;
	}
	.col-s-11 {
		width: 91.66%;
	}
	.col-s-12 {
		width: 100%;
	}
}

@media only screen and (min-width: 768px) {
	/* For desktop: */
	.col-1 {
		width: 8.33%;
	}
	.col-2 {
		width: 16.66%;
	}
	.col-3 {
		width: 25%;
	}
	.col-4 {
		width: 33.33%;
	}
	.col-5 {
		width: 41.66%;
	}
	.col-6 {
		width: 50%;
	}
	.col-7 {
		width: 58.33%;
	}
	.col-8 {
		width: 66.66%;
	}
	.col-9 {
		width: 75%;
	}
	.col-10 {
		width: 83.33%;
	}
	.col-11 {
		width: 91.66%;
	}
	.col-12 {
		width: 100%;
	}
}
</style>
</head>
<body>

  
  	<form action="LoginServlet" name="theForm" method="post">


		<div class="row">
			<div class="col-4 col-s-3 menu"></div>

			<div class="col-4 col-s-6">
				<div id="tab-div">
					<center>
						<img src=css/images/r.png height="50px" width="50px">
					</center>
					<center>
						<h4 style="color: black;font-family:Trebuchet MS">
							<b>Raj Group</b>
						</h4>
					</center>
					<center>
						<table>
							<tr>
								<td align="center" id=td1>User Id</td>
								<td><input type="text" name="login_id" size="50"
									placeholder="Enter Login Id" autocomplete="off" autofocus
									required id="admin_text"></td>
							</tr>

							<tr>
								<td align="center" id="td1">Password</td>
								<td><input type="password" name="login_password" size="50"
									placeholder="Enter Password" id="admin_pass" required></td>
							</tr>

							<tr>
								<td align="center" id="td1">User Type</td>
								<td><Select name="user_type" id="select">
										<option value="Administrator">Administrator</option>
										<option value="Operator">Operator</option>
								</Select></td>
							</tr>
							<tr>
								<td><input type="reset" name="Reset" value="Reset" id="submit_button" ></td>
							<td><input type="submit" name="login" value="Login" id="submit_button"></td>
							</tr>
							<tr>
								<td colspan="2" align="center" style="color: darkred">
									<%
										String a = (String) request.getAttribute("msg");
										if (a != null) {
									%> <%=a%> <%
 	}
 %>
								</td>
							</tr>
						</table>
					</center>
				</div>
			</div>

			<div class="col-4 col-s-12"></div>
		</div>

		<div class="footer">
			<p>Copyright &copy; 2020</p>
			<p>Raj Group &reg;</p>
		</div>
	</form>
</body>
</html>
