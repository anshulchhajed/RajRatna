<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="library.jsp"></jsp:include>

</head>

<jsp:include page="common.jsp"></jsp:include>

<body>
	<jsp:include page="header.jsp"></jsp:include>


	<form name="clockForm" action="BillingServlet" method="post">
		<div class="container-fluid text-center">
			<div class="row content">

				<jsp:include page="left.jsp"></jsp:include>

				<div class="col-sm-8 text-left">
					<p></p>
					<h1>Hi!</h1>
					<p></p>
				</div>
				<jsp:include page="rightPart.jsp"></jsp:include>
			</div>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>

	</form>
</body>
</html>
