<%@page import="java.util.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="library.jsp"></jsp:include>

<script>
	var request;
	
	function sendInfo() {
		var v = document.clockForm.t1.value;
		var url = "ItemData.jsp?val=" + v;

		if (window.XMLHttpRequest) {
			request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			request = new ActiveXObject("Microsoft.XMLHTTP");
		}

		try {
			request.onreadystatechange = getInfo;
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}
	
	function getInfo() {
		if (request.readyState == 4) {
			var val = request.responseText;
			var specialChars = "[]\\";
			for(i = 0; i < specialChars.length;i++){
			if(val.indexOf(specialChars[i]) > -1){
		
			val=null;
			break;
		}
		 else{
			document.getElementById('amit').innerHTML = val;
			}
		}
	}
	}
</script>

</head>

<jsp:include page="common.jsp"></jsp:include>
<body>
	<jsp:include page="header.jsp"></jsp:include>

	<form name="clockForm">
		<div class="container-fluid text-center">
			<div class="row content">

				<jsp:include page="left.jsp"></jsp:include>

				<div class="col-sm-8 text-left">

					<h1>
						Search Item <br> <br> <input type="text" name="t1"
							autocomplete="off" placeholder="Enter ItemName or ItemCode"
							autofocus onkeyup="sendInfo()"
							style="font-size: 20px; height: 40px; width: 100%;"> </input>
					</h1>
					<hr>

					<div><jsp:include page="ItemData.jsp"></jsp:include></div>

					<div id="amit"></div>
				</div>

				<jsp:include page="rightPart.jsp"></jsp:include>
			</div>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>

	</form>

</body>
</html>
