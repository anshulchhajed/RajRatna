<%@page import="javax.swing.text.html.parser.DTD"%>
<%@page import="java.util.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Raj Softwares</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="js/clock.js"></script>
  <link href="css/home.css" rel="stylesheet">
  <script src="js/alertify.min.js"></script>
<link rel="stylesheet" href="css/alertify.core.css" />
<link rel="stylesheet" href="css/alertify.default.css" id="toggleCSS" />
  <script>  
var request;  
function sendInfo()  
{  
var v=document.clockForm.company_id.value;  
var url="ModifyDealerServlet?company_id="+v;  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  
  
try{  
request.onreadystatechange=getInfo;  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  
  
function getInfo(){  
if(request.readyState==4){  
var val=request.responseText;  
document.getElementByName('company_id').innerHTML=val;  
}  
}  
</script>  
</head>

<body>
<form name="clockForm" action="ModifyDealerDataServlet" method="post">

 
 
 					<%
 					
 					ArrayList<Data> list =(ArrayList<Data>)request.getAttribute("success");
 					Data data=list.get(0);
 				
				%>
 <jsp:include page="header.jsp"></jsp:include>
<div class="container-fluid text-center">    
  <jsp:include page="left.jsp"></jsp:include>
  
    <div class="col-sm-8 text-left"> 
   <center><h2>Modify Merchant</h2>
		<p class="hint-text">Register the Company or Dealer</p>
    </center>
    
          <div class="form-group">
			
			<div class="col-sm-6"><input type="text" class="form-control" name="company_id" readonly="readonly" value="<%=data.companyId%>" placeholder="Company ID" required="required" onblur="sendInfo()"></input></div>
			<div class="col-sm-6"><input type="text" class="form-control" name="company_name" value="<%=data.companyName%>" placeholder="Company Name" required="required"></div>
				
        </div>
        
        <div class="form-group">
			
				<div class="col-sm-6"><input type="text" class="form-control" name="first_name" value="<%=data.firsrName %>" placeholder="First Name" required="required"></div>
				<div class="col-sm-6"><input type="text" class="form-control" name="last_name" value="<%=data.lastName %>" placeholder="Last Name" required="required"></div>
        </div>
       
        <div class="form-group">
        	<div class="col-sm-12"><input type="tel" class="form-control" name="address" value="<%=data.address %>" placeholder="Address" required="required"></div>
        </div>
		
		<div class="form-group">
			
				<div class="col-sm-6"><input type="text" class="form-control" name="city" value="<%=data.city %>" placeholder="City" required="required"></div>
				<div class="col-sm-6"><input type="text" class="form-control" name="pincode" value="<%=data.pincode%>" placeholder="Pincode" required="required"></div>
				
        </div>
        		<div class="form-group">
<div class="col-sm-12"><input type="text" class="form-control" name="contact" value="<%=data.contact %>" placeholder="Contact No" required="required"></div>
        </div>        
    	<div class="form-group">
          <div class="col-sm-12"><button type="submit" class="btn btn-primary btn-lg btn-block">Modify Dealer</button></div>
         <center><div class="col-sm-12">
           <%
					
					String failed = (String) request.getAttribute("failed");
					if (failed != null) {
				%>
				<div class="alert alert-danger" role="alert">
 					<%=failed%>
				</div>
				<%
					}
				
					
					String success = (String) request.getAttribute("success1");
					if (success != null) {
				%>
				<div class="alert alert-success" role="alert">
 					<%=success%>
				</div>
				<%
					}
				%>
           
           </div></center>  
        </div>
    
    </div>
   <jsp:include page="rightPart.jsp"></jsp:include>
  </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</form>

</body>
</html>
