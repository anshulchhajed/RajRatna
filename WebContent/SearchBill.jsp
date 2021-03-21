<%@page import="java.util.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Raj Softwares</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/png" href="css/images/r.png" />
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
var v=document.clockForm.t1.value;  
var url="empData.jsp?val="+v;  
  
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
document.getElementById('amit').innerHTML=val;  
}  
}  
</script>  

</head>
<jsp:include page="common.jsp"></jsp:include>
<body>
<jsp:include page="header.jsp"></jsp:include>

<form name="clockForm">
  
<div class="container-fluid text-center">    
  <jsp:include page="left.jsp"></jsp:include>
  
    <div class="col-sm-8 text-left"> 
     
      <h1>
Search Item <br><br><input type="text" name="t1" autocomplete="off" placeholder=" Itemcode / ItemName / Color" autofocus onkeyup="sendInfo()" style="font-size:20px;height:40px; width:100%;"> </input>
      </h1>
      <hr>
      
        <div><jsp:include page="empData.jsp"></jsp:include></div>
        
        <div id="amit"> </div> 
          </div>
 
   <jsp:include page="rightPart.jsp"></jsp:include>
  </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>

</form>

</body>
</html>
