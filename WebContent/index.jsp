<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<script src="js/jquery.min.js"></script>
<script src="js/bootstrape.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/adminlogin.css" />
</head>
<body>

	<form action="LoginServlet" name="theForm" method="post">

		<div class="container-fluid text-center">
			<div class="row content">

				<div class="col-sm-4 sidenav"></div>


				<div class="col-sm-4 text-left">

					<div id="tab-div">

						<img src=css/images/r.png height="50px" width="50px">

						<h4 style="color: black; font-family: Trebuchet MS">
							<b>Raj Group</b>
						</h4>


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
								<td><input type="reset" name="Reset" value="Reset"
									id="loginBox"></td>
								<td><input type="submit" name="login" value="Login"
									id="loginBox"></td>
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

					</div>


				</div>
				<div class="col-sm-4 sidenav"></div>
			</div>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>
	</form>
</body>
</html>
